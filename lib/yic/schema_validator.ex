defmodule Yic.SchemaValidator do
  require Logger
  alias Yic.Forms

  # A datadefinition is always in Map form.
  def validate_changes_against_schema( changeset, schema ) when is_map(schema) do
    # first get data and proposed changes
    %{params: params, errors: errors} = changeset
    new = validate_dataitem [], params, schema, ""
    case new do
      []    -> changeset
      [_|_] -> %{changeset | errors: new ++ errors, valid?: false}
    end
  end

  # Helper function. 
  # If datadef is defined as string, it will be retrieved from database.
  def validate_changes_against_schema( changeset, schema_name ) when is_binary( schema_name ) do
    dd = Forms.get_datadef_by_name!( schema_name )
    case Poison.decode( dd.definition, %{keys: :atoms} ) do
      {:ok, map} ->
        validate_changes_against_schema( changeset, map )
      {:error, msg} ->
        Logger.error( msg )
        %{changeset | errors: [{schema_name, {"Schema could not be decoded", []}}], valid?: false}
    end    
  end

  def validate_dataitem errors, data, schemaitem, path do
    case schemaitem.type do
      "object" when is_map( data ) ->
        errors
        |> check_required_properties( schemaitem, data, path )
        |> check_undefined_properties( schemaitem.properties, Map.keys(data), path )
        |> validate_properties( Map.keys( schemaitem.properties ), data, schemaitem.properties, path )
      "object" when is_binary( data ) ->
        case Poison.decode( data ) do
          {:ok, map} ->
            errors
            |> check_required_properties( schemaitem, map, path )
            |> check_undefined_properties( schemaitem.properties, Map.keys(map), path )
            |> validate_properties( Map.keys( schemaitem.properties ), map, schemaitem.properties, path )
          {:error, msg} ->
            Logger.error( msg )
            [{path, {"Invalid data item for JSON decoding", []}}|errors]
        end 
      "array" when is_list(data) ->
        # TODO
        errors
      "array" ->
        [{path, {"Data is not of type array", []}}|errors]
      "number" when is_number(data) ->
        errors
        |> validate_num_minimum( data, schemaitem, path )
        |> validate_num_maximum( data, schemaitem, path )
        |> validate_multiple_of( data, schemaitem, path )
      "number" when is_binary(data) ->
        try do
          String.to_float(data)
        rescue
          ArgumentError ->
            [{path, {"Data is not of type number", []}}|errors]
        else
          castvalue ->
              errors
              |> validate_num_minimum( castvalue, schemaitem, path )
              |> validate_num_maximum( castvalue, schemaitem, path )
              |> validate_multiple_of( castvalue, schemaitem, path )    
        end
      "number" ->
        [{path, {"Data is not of type number", []}}|errors]
      "integer" when is_integer(data) ->
        errors
        |> validate_num_minimum( data, schemaitem, path )
        |> validate_num_maximum( data, schemaitem, path )  
        |> validate_multiple_of( data, schemaitem, path )
      "integer" when is_binary(data) ->
        try do
          String.to_integer(data)
        rescue
          ArgumentError ->
            [{path, {"Data is not of type integer", []}}|errors]
        else
          castvalue ->
            errors
            |> validate_num_minimum( castvalue, schemaitem, path )
            |> validate_num_maximum( castvalue, schemaitem, path )
            |> validate_multiple_of( castvalue, schemaitem, path )    
        end
      "integer" ->
        [{path, {"Data is not of type integer #{data}", []}}|errors]
      "string" when is_binary( data ) ->
        errors
        |> validate_min_length( data, schemaitem, path )
        |> validate_max_length( data, schemaitem, path )
        |> validate_pattern( data, schemaitem, path )       
        |> validate_format( data, schemaitem, path )
      "string" ->
        [{path, {"Data is not of type string", []}}|errors]
      "boolean" when is_boolean( data ) ->
        # no specific validations, check on data validity is sufficient
        errors
      "boolean" ->
        [{path, {"Data is not of type boolean", []}}|errors]
      _default ->
        [{path, {"Uncaught data type", []}}|errors]
      end
  end

  # ---------------------------
  # String validation rules
  # ---------------------------

  def validate_min_length errors, data, schemaitem, path do
    case Map.fetch( schemaitem, :minLength ) do
      {:ok, value} ->
        cond do
          String.length( data ) < value ->
            [{path, {"String length is smaller than required minimum", []}}|errors]
          true ->
            errors
        end
      :error ->
        errors
    end
  end

  def validate_max_length errors, data, schemaitem, path do
    case Map.fetch( schemaitem, :maxLength ) do
      {:ok, value} ->
        cond do
          String.length( data ) > value ->
            [{path, {"String length is larger than required maximum", []}}|errors]
          true ->
            errors
        end
      :error ->
        errors
    end
  end

  def validate_pattern errors, data, schemaitem, path do
    case Map.fetch( schemaitem, :pattern ) do
      {:ok, pattern} ->
        exec_pattern errors, data, schemaitem, pattern, path
      :error ->
        errors
    end    
  end

  def validate_format errors, data, schemaitem, path do
    case Map.fetch( schemaitem, :format ) do
      {:ok, format} ->
        case format do
          "email" ->
            pattern = "(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
            exec_pattern errors, data, schemaitem, pattern, path
          _ ->
            errors
        end
      :error ->
        errors
    end    
  end

  def exec_pattern errors, data, _schemaitem, pattern, path do
    case Regex.compile(pattern) do
      {:ok, regex } ->
        cond do
          String.match?(data, regex) ->
            errors
          true ->
            [{path, {"String does not conform to pattern", []}}|errors]
        end
      {:error, msg } ->
        Logger.error "Validation Error: #{msg} in rule #{pattern}"
        [{path, {msg, []}}|errors]
    end
  end

  # ---------------------------
  # Number validation rules
  # ---------------------------

  def validate_num_minimum errors, data, schemaitem, path do
    case Map.fetch( schemaitem, :minimum ) do
      { :ok, minimum } ->
        case Map.fetch( schemaitem, :exclusiveMinimum ) do
          {:ok, true} ->
            cond do
              ( data < minimum ) ->
                [{path, {"Value is smaller than exclusive minumum", []}}|errors]
              true ->
                errors
            end
          {:ok, false} ->
            cond do
              ( data <= minimum ) ->
                [{path, {"Value is smaller then minumum", []}}|errors]
              true ->
                errors
            end
          :error ->
            cond do
              ( data < minimum ) ->
                [{path, {"Value is smaller then minumum", []}}|errors]
              true ->
                errors
            end
          end
      :error ->
        errors
    end
  end

  def validate_num_maximum errors, data, schemaitem, path do
    case Map.fetch( schemaitem, :maximum ) do
      { :ok, maximum } ->
        case Map.fetch( schemaitem, :exclusiveMiximum ) do
          {:ok, true} ->
            cond do
              ( data > maximum ) ->
                [{path, {"Value is larger than exclusive maximum", []}}|errors]
              true ->
                errors
            end
          {:ok, false} ->
            cond do
              ( data >= maximum ) ->
                [{path, {"Value is larger then maximum", []}}|errors]
              true ->
                errors
            end
          :error ->
            cond do
              ( data > maximum ) ->
                [{path, {"Value is larger then maximum", []}}|errors]
              true ->
                errors
            end
        end
      :error ->
        errors
    end
  end

  def validate_multiple_of errors, data, schemaitem, path do
    case Map.fetch( schemaitem, :multipleOf ) do
      { :ok, multiple } ->
        cond do
          rem( data, multiple ) == 0 ->
            errors
          true ->
            [{path, {"Value is not a multiple of", []}}|errors]
        end
      :error ->
        errors
    end
  end

  # ---------------------------
  # Object validation rules
  # ---------------------------

  # Check if there are required properties, if so, check for it
  def check_required_properties( errors, schemaitem, data, path ) when is_map( schemaitem ) do
    case Map.fetch(schemaitem, :required) do
      {:ok, []} ->
        errors
      {:ok, values} ->
        check_required_properties( errors, values, data, path )
      :error ->
        errors
    end
  end

  def check_required_properties( errors, [], _data, _path ), do: errors
  def check_required_properties( errors, [property|properties], data, path ) do
    result = case Map.has_key?(data, property) do
      true ->
        errors
      false ->
        [{ path, {"Missing reuired property: #{property}", []}}|errors]
    end
    check_required_properties( result, properties, data, path )
  end

  # Check if undefined properties are allowed, if not. check for superfluous properties
  def check_undefined_properties( errors, schemaitem, data, path ) when is_map( schemaitem ) do
    case Map.fetch( schemaitem, :additionalProperties ) do
      { :ok, true } ->
        errors
      { :ok, false } ->
        check_undefined_properties( errors, schemaitem.properties, Map.keys(data), path )
      :error ->
        errors
    end
  end

  def check_undefined_properties( errors, _properties, [], _path ), do: errors
  def check_undefined_properties( errors, properties, [datakey|datakeys], path ) do
    result = case Map.has_key?(properties, datakey) do
      true ->
        errors
      false ->
        [{ path, {"Superfluous property: #{datakey}", []}}|errors]
    end
    check_undefined_properties( result, properties, datakeys, path )
  end

  # Validate properties
  def validate_properties( errors, [], _data, _schema_item, _path ), do: errors
  def validate_properties( errors, [key|keys], data, schema_item, path ) do
    new_path = case path do
      "" ->
        key
      _ ->
        "#{path}.#{key}"
    end
    errors
    |> validate_dataitem( Map.get( data, Atom.to_string( key ) ), Map.get( schema_item, key), new_path )
    |> validate_properties( keys, data, schema_item, path )
  end

end
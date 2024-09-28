defmodule Yic.Validate do
  require Logger
  alias Yic.Forms

  # A datadefinition is always in Map form.
  def validate_changes_against_datadef( changeset, datadef ) when is_map(datadef) do
      # first get data and proposed changes
    %{data: data, changes: changes, errors: errors} = changeset
    # Merge into one set with latest proposed values
    dataset = Map.merge( data, changes )
    # Validate all datadef fields against the set
    new = validate_dataitem [], dataset, datadef, datadef.root, datadef.root
    case new do
      []    -> changeset
      [_|_] -> %{changeset | errors: new ++ errors, valid?: false}
    end
  end

  # Helper function. 
  # If datadef is defined as string, it will be retrieved from database.
  def validate_changes_against_datadef( changeset, datadef ) when is_binary(datadef) do
    dd = Forms.get_datadef_by_name!(datadef)
    case Poison.decode( dd.definition, %{keys: :atoms!} ) do
      {:ok, map} ->
        validate_changes_against_datadef( changeset, map )
      {:error, msg} ->
        Logger.error( msg )
        %{changeset | errors: [{datadef, {"Invalid path to datadef", []}}], valid?: false}
    end    
  end

  def validate_dataitem errors, data, datadef, path, name do
    case find_element( name, datadef.datatypes ) do
      { :error, msg } ->
        Logger.error msg
        errors ++ [{ String.to_atom( name ), {"Field not found, alert admin", [datadef: "missing field"]} }]
      { :ok, element } ->
        case element.basetype do
          "map" when is_map(data) ->
            validate errors, data, datadef, element.validations, build_path( path, element.name )
          "map" when is_bitstring(data) ->
              case Jason.decode( data, [keys: :atoms] ) do
                {:ok, datamap} ->
                  validate errors, datamap, datadef, element.validations, build_path( path, element.name )
                {:error, msg} ->
                  Logger.error( msg )
                  errors ++ [{ String.to_atom( element.name ), "Field of type map is not a valid JSON" }]
              end  
          "array" ->
            validate errors, data, datadef, element.validations, build_path( path, element.name )
            # validate_array( data, element, path, errors )
          basetype when basetype in ["string", "number", "id"] ->
            errors
            |> type_check( element.basetype, data, path )
            |> validate( data, datadef, element.validations, build_path( path, element.name ) )
          _ ->
            Logger.info("Field type #{element.basetype} not found, alert admin")
            errors ++ [{ String.to_atom( element.name ), "Field type #{element.basetype} not found, alert admin" }]
        end
    end
  end

  def find_element( name, [] ), do: { :error, "#{name} not found in data definition." }

  def find_element name, [item|datadef] do
    cond do 
      item.name == name -> 
        {:ok, item}
      true -> 
        find_element name, datadef
    end
  end
  
  def validate( errors, _value, _datadef, [], _path ), do: errors

  def validate errors, value, datadef, [ %{ type: "array", fields: _fields} | validations], path do
    errors 
    # |> validate_arrayfields data, datadef, fields, path
    |> validate( value, datadef, validations, path )
  end

  def validate errors, value, datadef, [%{ type: "fields", fields: fields, strict: _strict} | validations], path do
    errors
    |> validate_mapfields( value, datadef, fields, path )
    |> validate( value, datadef, validations, path )
  end

  def validate errors, value, datadef, [%{ type: "format", rule: rule, error: error} | validations], path do
    errors
    |> exec_rule( "format", rule, value, error, String.to_atom( path ) )
    |> validate( value, datadef, validations, path )
  end

  def validate errors, value, datadef, [%{ type: "email", error: error} | validations], path do
    rule = "(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
    errors
    |> exec_rule( "format", rule, value, error, String.to_atom( path ) )
    |> validate( value, datadef, validations, path )
  end

  def validate errors, value, datadef, [ validation | validations ], path do
    Logger.warning( "Error in validation rule for #{validation.type}. Validation not properly processed." )
    errors
    |> append( [{ String.to_atom( path ), {"Validation rule not of correct format", []} }] )
    |> validate( value, datadef, validations, path )
  end

  def type_check( errors, type, value, path ) do
    valid = case type do
      "string" ->
        is_binary(value)
      "id" ->
        if is_binary(value) do
          try do
            String.to_integer(value)
          rescue
            ArgumentError ->
              false
          else
            castvalue ->
              is_integer(castvalue)
          end
        else
          is_integer(value)
        end
      "number" ->
        if is_binary(value) do
          try do
            String.to_integer(value)
          rescue
            ArgumentError ->
              false
          else
            castvalue ->
              is_integer(castvalue)
          end
        else
          is_integer(value)
        end
    end
    if valid do
      errors
    else
      errors ++ [{ String.to_atom( path ), {"Value type is incorrect. Expected type #{type}", []} }]     
    end
  end

  def exec_rule errors, "format", rule, value, error, path do
    case Regex.compile(rule) do
      {:ok, regex } ->
        if String.match?(value, regex) do
          errors
        else
          errors ++ [{ path, {error, []} }]
        end
      {:error, msg } ->
        Logger.error "Validation Error: #{msg} in rule #{rule}"
        errors ++ [{ path, {error, []} }]
    end
  end

  def exec_rule errors, validationtype, _validationrule, _value, _error, _path do
    Logger.warning validationtype <> " not specified" 
    #TODO Validate actions, for now, accept
    errors
  end

  def validate_mapfields( errors, _data, _datadef, [], _path ), do: errors

  def validate_mapfields errors, data, datadef, [field|fields], path do
    errors
    |> check_fielditem( data, datadef, field, path )
    |> validate_mapfields( data, datadef, fields, path )
  end

  def check_fielditem errors, data, datadef, field, path do
    fieldatom = String.to_atom(field.field)
    case Map.get( data, fieldatom ) do
      nil ->
        cond do
          field.required -> 
            new_path = build_path( path, field.field )
            Logger.info("Required field #{ String.to_atom( new_path ) } not found, alert admin")
            errors ++ [{ String.to_atom( new_path ), {"Required field",[ validation: "required" ]} }]
          true -> 
            errors
        end
      element ->
        validate_dataitem errors, element, datadef, path, field.field
    end
  end

  defp append(a, b), do: a ++ b

  defp build_path path, name do
    cond do
      path == name -> ""
      path == "" -> name
      true -> path <> "." <> name
    end
  end
end
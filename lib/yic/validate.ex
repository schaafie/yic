defmodule Yic.Validate do

  alias Yic.Forms

  def validate_changes_against_datadef( changeset, datadef ) when is_binary(datadef) do
    dd = Forms.get_datadef_by_name!(datadef)
    validate_changes_against_datadef( changeset, dd )
  end

  def validate_changes_against_datadef( changeset, datadef ) do
      # first get data and proposed changes
    %{data: data, changes: changes, errors: errors} = changeset
    # Merge into one set with latest proposed values
    dataset = Map.merge( data, changes )
    # Validate all datadef fields against the set
    new = validate_dd dataset, datadef, [], "", datadef.root
    case new do
      []    -> changeset
      [_|_] -> %{changeset | errors: new ++ errors, valid?: false}
    end
  end

  def validate_dd data, datadef, errors, path, name  do
    case find_element( name, datadef.datatypes ) do
      { :error, msg } ->
        IO.puts msg
        errors ++ [{ String.to_atom( name ), {"Field not found, alert admin", [datadef: "missing field"]} }]
      { :ok, element } ->
        case element.basetype do
          "map" ->
            validate_map( data, datadef, element, build_path( path, element.name ), errors )
          "array" ->
            validate_array( data, element, path, errors )
          "string" when element.type == "map" ->
            {:ok, datamap} = Jason.decode( data, [keys: :atoms] )
            validate_map( datamap, datadef, element, build_path( path, element.name ), errors )
          basetype when basetype in ["string", "number", "id"] ->
            validate( element.name, data, element.validations, build_path( path, element.name ) , errors )
          _ ->
            errors ++ [{ String.to_atom( element.name ), "Field type #{element.basetype} not found, alert admin" }]
        end
    end
  end

  def find_element( name, [] ), do: { :error, "#{name} not found in data definition." }

  def find_element name, [item|datadef] do
    cond do 
      item.name == name -> {:ok, item}
      true -> find_element name, datadef
    end
  end
  
  def validate_map( data, datadef, element, path, errors ) do
    validate_map_elements data, datadef, element.fields, path, errors
  end

  def validate_map_elements( _data, _datadef, [], _path, errors), do: errors

  def validate_map_elements data, datadef, [field|fields], path, errors do
    fieldatom = String.to_atom(field.field)
    updated_errors = case Map.get( data, fieldatom ) do
      nil ->
        cond do
          field.required -> 
            new_path = build_path( path, field.field )
            errors ++ [{ String.to_atom( new_path ), {"Required field",[ validation: "required" ]} }]
          true -> errors
        end
      element ->
        validate_dd( element, datadef, errors, path, field.field )
    end
    validate_map_elements data, datadef, fields, path, updated_errors
  end

  def build_path path, name do
    case path do
      "" -> name
      _ -> path <> "." <> name
    end
  end

  def validate_array( _data, _element, _path, errors ) do
    #TODO validate array, for now, accept content
    errors
  end

  def validate( _fieldname, _value, [], _path, errors ), do: errors

  def validate( fieldname, value, [validation | validations], path, errors ) do
    case Map.fetch( validation, :rule ) do
      :error ->
        if is_valid( validation.type, value ) do
          validate( fieldname, value, validations, path, errors )
        else 
          validate( fieldname, value, validations, path, errors ++ [{ String.to_atom( path ), {validation.error, []} }] )
        end
      {:ok, rule} ->
        if is_valid( validation.type, rule, value ) do
          validate( fieldname, value, validations, path, errors )
        else 
          validate( fieldname, value, validations, path, errors ++ [{ String.to_atom( path ), {validation.error, []} }] )
        end
    end
  end

  def is_valid( "email", value ) do
    is_valid("format", "(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])", value)
  end

  def is_valid( "format", rule, value ) do
    case Regex.compile(rule) do
      {:ok, regex } ->
        String.match?(value, regex)
      {:error, msg } ->
        IO.puts "Validation Error"
        IO.inspect msg
        false
    end
  end

  def is_valid( _validationtype, _validationrule, _value ) do
    #TODO Validate actions, for now, accept
    true
  end

end
defmodule Yic.Validate do

  def validate_changes_against_datadef( changeset, datadef, opts \\ []) do
    # first get data and proposed changes
    %{data: data, changes: changes} = changeset
    # Merge into one set with latest proposed values
    dataset = Map.merge( data, changes )
    # Validate all datadef fields against the set
    validate_dd dataset, datadef, [], "", datadef.root
  end

  def validate_dd data, datadef, errors, path, name  do
    case find_element( name, datadef.datatypes ) do
      { :error, msg } ->
        IO.puts msg
        errors ++ [{ String.to_atom( name ), "Field not found, alert admin" }]
      { :ok, element } ->
        case element.basetype do
          "map" ->
            validate_map( data, datadef, element, build_path( path, element.name ), errors )
          "array" ->
            validate_array( data, element, path, errors )
          "string" when element.type == "map "->
            validate( element.name, Poison.decode( data ), element.validations, build_path( path, element.name ), errors )
          basetype when basetype in ["string", "number"] ->
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
    new_path = build_path path, field.field
    fieldatom = String.to_atom(field.field)
    updated_errors = case Map.get( data, fieldatom ) do
      nil ->
        cond do
          field.required -> errors ++ [{ String.to_atom( new_path ), "Required field" }]
          true -> errors
        end
      element ->
        validate_dd( element, datadef, errors, new_path, field.field )
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
    if is_valid( validation.type, validation.rule, value ) do
      validate( fieldname, value, validations, path, errors )
    else 
      validate( fieldname, value, validations, path, errors ++ [{ String.to_atom( path ), validation.errortxt }] )
    end
  end

  def is_valid( _validationtype, _validation, _value ) do
    #TODO Validate actions, for now, accept
    true
  end

end
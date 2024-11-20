defmodule YicWeb.InputHelpers do
    use Phoenix.HTML
  
    def codearea(form, field, opts \\ []) do

      value = Phoenix.HTML.Form.input_value(form, field) || "{}"
      name = Phoenix.HTML.Form.input_name(form, field)
      id = Phoenix.HTML.Form.input_id(form, field)

      tag_opts = opts ++ [ id: id , name: name , value: value, language: "json" ]

      # Issue with Inputhelpers
      # tag needs an atom as proper input and an atom name cannot contain a dash
      # webcomponents require a dash in the name. Hence tag cannot handle webcomponents
      #
      # tag :yic-json-editor, tag_opts => This fails
      # tag "yic-json-editor", tag_opts => provides correct tag but unexpected behaviour.
      #
      # converting to bitstring also results in the same unexpected behaviour.
      # wc = :erlang.list_to_bitstring(String.to_charlist("yic-json-editor"))
      # tag wc, tag_opts

      # content_tag "codejar-editor", value, tag_opts
      content_tag "yic-form-json-input", value, tag_opts
    end

  end
defmodule YicWeb.ErrorHelpers do
  @moduledoc """
  Conveniences for translating and building error messages.
  """

  use Phoenix.HTML
  require Logger

  @doc """
  Generates tag for inlined form input errors.
  """
  def deep_error_tag(form, field, root) do
    list = find_all_fields( form.errors, field, root, [])
    Enum.map( list, fn error -> 
      content_tag(:span, translate_error(error), 
        class: "invalid-feedback", 
        phx_feedback_for: input_name(form, field))
    end)
  end

  def find_all_fields([], _field, _root, list), do: list

  def find_all_fields( [{key, val}|errors], field, root, list) do
    if key == field do
      find_all_fields( errors, field, root, [val|list] )
    else
      if String.starts_with?( Atom.to_string(key), root <> "." <> Atom.to_string(field)) do
        { msg, opt } = val
        find_all_fields( errors, field, root, [{ Atom.to_string(key)<>": "<>msg, opt}|list] )
      else
        find_all_fields( errors, field, root, list )
      end
    end
  end

  def error_tag(form, field) do
      Enum.map(Keyword.get_values(form.errors, field), fn error ->
      content_tag(:span, translate_error(error),
        class: "invalid-feedback",
        phx_feedback_for: input_name(form, field)
      )
    end)
  end

  @doc """
  Translates an error message using gettext.
  """
  def translate_error({msg, opts}) do
    # When using gettext, we typically pass the strings we want
    # to translate as a static argument:
    #
    #     # Translate "is invalid" in the "errors" domain
    #     dgettext("errors", "is invalid")
    #
    #     # Translate the number of files with plural rules
    #     dngettext("errors", "1 file", "%{count} files", count)
    #
    # Because the error messages we show in our forms and APIs
    # are defined inside Ecto, we need to translate them dynamically.
    # This requires us to call the Gettext module passing our gettext
    # backend as first argument.
    #
    # Note we use the "errors" domain, which means translations
    # should be written to the errors.po file. The :count option is
    # set by Ecto and indicates we should also apply plural rules.
    if count = opts[:count] do
      Gettext.dngettext(YicWeb.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(YicWeb.Gettext, "errors", msg, opts)
    end
  end
end

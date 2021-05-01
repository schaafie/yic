defmodule FormManagerWeb.ChangesetView do
  use FormManagerWeb, :view

  # @doc """
  # Traverses and translates changeset errors.
  # 
  # See `Ecto.Changeset.traverse_errors/2` and
  # `FormManagerWeb.ErrorHelpers.translate_error/1` for more details.
  # """
  # def translate_errors(changeset) do
  #   Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  # end
  #
  # def render("error.json", %{changeset: changeset}) do
  #   # When encoded, the changeset returns its errors
  #   # as a JSON object. So we just pass it forward.
  #   %{errors: translate_errors(changeset)}
  # end

  @doc """
  Parse all errors and create valid json respons indicating field and error

  """

  def render("error.json", %{changeset: changeset}) do
    errors = Enum.map(changeset.errors, fn {element, detail} ->
      %{ 
        element: element, 
        detail: render_detail(detail) 
      }
    end)

    %{errors: errors}
  end

  def render_detail({message, values}) do
    Enum.reduce values, message, fn {k, v}, acc ->
      String.replace(acc, "%{#{k}}", to_string(v))
    end
  end

  def render_detail(message), do: message

end

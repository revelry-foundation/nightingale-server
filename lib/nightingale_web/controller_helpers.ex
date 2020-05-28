defmodule NightingaleWeb.ControllerHelpers do
  alias Ecto.Changeset

  defp translate_changeset_error({msg, opts}) do
    # https://www.mitchellhanberg.com/post/2017/10/23/encoding-ecto-validation-errors-in-phoenix/
    #
    # Because error messages were defined within Ecto, we must
    # call the Gettext module passing our Gettext backend. We
    # also use the "errors" domain as translations are placed
    # in the errors.po file.
    # Ecto will pass the :count keyword if the error message is
    # meant to be pluralized.
    # On your own code and templates, depending on whether you
    # need the message to be pluralized or not, this could be
    # written simply as:
    #
    #     dngettext "errors", "1 file", "%{count} files", count
    #     dgettext "errors", "is invalid"
    #
    if count = opts[:count] do
      Gettext.dngettext(NightingaleWeb.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(NightingaleWeb.Gettext, "errors", msg, opts)
    end
  end

  def get_changeset_errors_as_map(%Changeset{} = changeset) do
    Changeset.traverse_errors(changeset, &translate_changeset_error/1)
  end
end

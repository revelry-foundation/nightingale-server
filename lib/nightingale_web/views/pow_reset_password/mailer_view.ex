defmodule NightingaleWeb.PowResetPassword.MailerView do
  use NightingaleWeb, :mailer_view

  def subject(:reset_password, _assigns), do: "Reset password link"
end

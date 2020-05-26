defmodule NightingaleWeb.PowEmailConfirmation.MailerView do
  use NightingaleWeb, :mailer_view

  def subject(:email_confirmation, _assigns), do: "Confirm your email address"
end

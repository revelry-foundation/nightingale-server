defmodule Nightingale.Mailer do
  @moduledoc """
  Nightingale mailer
  """
  use Bamboo.Mailer, otp_app: :nightingale

  import Bamboo.Email

  def cast(%{user: user, subject: subject, text: text, html: html}) do
    new_email(
      to: user.email,
      from: Application.get_env(:nightingale, :email),
      subject: subject,
      html_body: html,
      text_body: text
    )
  end

  def process(email) do
    deliver_now(email)
  end
end

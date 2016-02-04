defmodule Forum.Mailer do
  @from "djmgguedes@gmail.com"
  use Mailgun.Client, domain: Application.get_env(:forum, :mailgun_domain),
  key: Application.get_env(:forum, :mailgun_key)

  def send_welcome_text_email(email) do
    send_email to: email,
    from: @from,
    subject: "Welcome!",
    text: "Welcome to my forum!"
  end

  def send_welcome_html_email(email) do
    send_email to: email,
    from: @from,
    subject: "Welcome!",
    html: "<strong>Welcome to my forum!</strong>"
  end
end

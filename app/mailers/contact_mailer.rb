class ContactMailer < ApplicationMailer
  def send_email(contact)
    @contact = contact
    mail(
      from: 'iitoko47@gmail.com',
      to: 'iitoko47@gmail.com',
      subject: 'お問い合わせ通知'
    )
  end
end

# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview
  def contact
    contact = Contact.new(email: "test@example.com", category: "お問い合わせ", content: "全て無料で使えますか？")
    ContactMailer.send_email(contact)
  end
end

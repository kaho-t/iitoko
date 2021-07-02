require "rails_helper"

RSpec.describe ContactMailer, type: :mailer do
  describe 'contact_email' do
    let(:contact) { FactoryBot.create(:contact)}
    let(:mail) { ContactMailer.send_email(contact)}

    it "sends a contact email to owner's email address" do
      expect(mail.to).to eq ['iitoko47@gmail.com']
    end

    it 'sends from the support email address' do
      expect(mail.from).to eq ['iitoko47@gmail.com']
    end

    it 'sends with the correct subject' do
      expect(mail.subject).to eq 'お問い合わせ通知'
    end

    it 'reminds the user of the registered email address' do
      expect(mail.html_part.body.encoded).to match contact.email
      expect(mail.text_part.body.encoded).to match contact.email
    end
  end
 end

class ContactsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :authenticate_local!
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      ContactMailer.send_email(@contact).deliver_now
      flash[:success] = 'お問い合わせを送信しました。入力いただいたメールアドレスに2~3営業日以内に返信いたします。'
      redirect_to contact_url
    else
      render 'new'
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:category, :email, :content)
  end
end

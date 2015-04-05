class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    UserMailer.contact_email(@contact).deliver_now
    redirect_to root_path, notice: "Thanks for your message! I'll get back to you soon."
  end
end

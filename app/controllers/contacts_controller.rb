class ContactsController < ApplicationController
    def new
        @contact = Contact.new
    end

    def confirm
        @contact = Contact.new(contact_params)
        render :new if @contact.invalid?
    end

    def create
        @contact = Contact.new(contact_params)
        if params[:back]
            render :new
        else
            if @contact.save
                ContactMailer.send_mail(@contact).deliver_now
                redirect_to contact_complete_path
            end
        end
    end

    def complete
    end

    private

    def contact_params
        params.require(:contact).permit(
            :name,
            :name_kana,
            :email,
            :tel,
            :subject,
            :message,
            :postal_code,
            :prefecture_code,
            :city,
            :street_and_others
            )
    end
end

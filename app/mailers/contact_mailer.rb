class ContactMailer < ApplicationMailer
    def send_mail(contact)
        mail to:   ENV['MAIL_USER_NAME'], subject: '【お問い合わせ】' + contact.subject
    end
end

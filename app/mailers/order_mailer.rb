class OrderMailer < ApplicationMailer
    # def order_announce
    #     @user = params[:user]
    #     @order_number = params[:order_number]
    #     mail(to:@user.email, subject: '注文が完了しました！')
    # end

    def order_confirmation(user, order)
        @user = user
        @order = order
        mail(to: @user.email, subject: '注文確定のお知らせ')
    end
end

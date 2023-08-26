class OrderMailer < ApplicationMailer
    def order_confirmation(user, order)
        @user = user
        @order = order
        @order_details = OrderDetail.where(order_id: @order.id).includes(:product)
        mail(to: @user.email, subject: '注文確定のお知らせ')
    end
end

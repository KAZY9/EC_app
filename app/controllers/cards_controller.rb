class CardsController < ApplicationController
  before_action :sign_in_required, only: [:new, :create, :destroy]

  def new
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    card = Card.find_by(user_id: current_user.id) # cardsテーブルからユーザーのカード情報を取得
    if card.present?
      customer = Payjp::Customer.retrieve(card.customer_id) # 顧客idを元に、顧客情報を取得
      @cards = customer.cards.all
    end
  end

  def create
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    customer = Payjp::Customer.create(
      description: 'test', 
      card: params[:token_id]
    )
    @card = Card.new(
      customer_id: customer.id,
      token_id: customer.default_card,
      user_id: current_user.id
    )
    if @card.save
      redirect_to new_card_path
    end
  end

  def destroy
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
    else
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      if customer.delete && card.delete
        redirect_to new_card_path, status: :see_other
      end
    end
  end
 
end

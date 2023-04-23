class CardsController < ApplicationController
  before_action :sign_in_required, only: [:new, :create, :destroy]
  before_action :init_payjp, only: [:new, :create, :destroy]

  def new
    cards = Card.where(user_id: current_user.id)
    @cards = []
    cards.each do |card|
      customer = Payjp::Customer.retrieve(card.customer_id)
      @cards.concat(customer.cards.data)
    end
  end

  def create
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
    unless card.blank?
      customer = Payjp::Customer.retrieve(card.customer_id)
      if customer.delete && card.delete
        redirect_to new_card_path, status: :see_other
      end
    end
  end

  private 
  
  def init_payjp
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
  end
end

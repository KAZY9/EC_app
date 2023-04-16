class PagesController < ApplicationController
  before_action :sign_in_required, only: [:mypage, :show]

  def mypage
    @username = current_user.username
  end
  
  def index
  end

  def show
  end
end

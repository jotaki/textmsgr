class ApplicationController < ActionController::Base
  def login
  end

  def post_login
    @user = User.get(params.fetch('name'), params.fetch('phone_number'))
    render 'post_login', locals: { user: @user }
  end
end

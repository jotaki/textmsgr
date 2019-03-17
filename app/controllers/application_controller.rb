class ApplicationController < ActionController::Base
  def login
  end

  def real_login
    @user = User.get(params.fetch('name'), params.fetch('phone_number'))
    render 'real_login', locals: { user: @user }
  end
end

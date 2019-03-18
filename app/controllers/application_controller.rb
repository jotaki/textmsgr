class ApplicationController < ActionController::Base
  def index
  end

  def sendtext
    name = params.fetch('name')
    number = params.fetch('phone_number')
    msg = params.fetch('message')

    if Phone
  end

end

class ApplicationController < ActionController::Base
  protect_from_forgery except: :incoming_text

  def index
    render :index, locals: { textlogs: Textlog.order('created_at DESC') }
  end

  def sendtext
    name = params.fetch('name')
    number = params.fetch('phone_number')
    msg = params.fetch('message')

    log = Textlog.new(name: name, phone: number, message: msg)
    log.save!

    render :index
  end

  def incoming_text
    log = Textlog.new(name: 'Unknown', phone: params.fetch('From'), message: params.fetch('Body'))
    log.save
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery except: :incoming_text

  def index
    flash[:notice] = nil
    render :index, locals: { textlogs: Textlog.order('created_at DESC') }
  end

  def sendtext
    flash[:notice] = nil
    name = params.fetch('name')
    number = params.fetch('phone_number')
    msg = params.fetch('message')

    if Phony.plausible? number
      log = Textlog.new(name: name, phone: number, message: msg)
      log.save!

      twclnt = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
      msg = twclnt.messages.create(
        body: "#{log.name} sent \"#{log.message}\"",
        to: log.phone,
        from: ENV['TWILIO_PHONE_NUMBER'])

      render :index, locals: { textlogs: Textlog.order('created_at DESC') }
    else
      flash[:notice] = "Number is not valid"
      render :index, locals: { textlogs: Textlog.order('created_at DESC') }
    end
  rescue ActiveRecord::RecordInvalid => e
    flash[:notice] = e
    render :index, locals: { textlogs: Textlog.order('created_at DESC') }
  end

  def incoming_text
    log = Textlog.new(name: 'Unknown', phone: params.fetch('From'), message: params.fetch('Body'))
    log.save
  end
end

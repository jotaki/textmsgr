class ApplicationController < ActionController::Base
  protect_from_forgery except: :incoming_text

  def index
    flash[:notice] = nil
    render :index, locals: { textlogs: Textlog.order('created_at DESC') }
  end

  def sendtext
    flash[:notice] = nil
    @frmname = params.fetch('name')
    @number = params.fetch('phone_number')
    @msg = params.fetch('message')

    if Phony.plausible? @number
      log = Textlog.new(name: @frmname, phone: @number, message: @msg)
      log.save!

      twclnt = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
      msg = twclnt.messages.create(
        body: "#{log.name} sent \"#{log.message}\"",
        to: log.phone,
        from: ENV['TWILIO_PHONE_NUMBER'])

      respond_to do |format|
        format.html do
          render :index, locals: { textlogs: Textlog.order('created_at DESC') }
        end
        format.js
      end
    else
      flash[:notice] = "Number is not valid"
      respond_to do |format|
        format.html do
          render :index, locals: { textlogs: Textlog.order('created_at DESC') }
        end

        format.js
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    flash[:notice] = e.to_s
    respond_to do |format|
      format.html do
        render :index, locals: { textlogs: Textlog.order('created_at DESC') }
      end
      
      format.js
    end
  end

  def incoming_text
    log = Textlog.new(name: 'Unknown', phone: params.fetch('To'), message: params.fetch('Body'))
    log.save
  end

  def phone_records
    @logs = Textlog.order('created_at ASC')

    respond_to do |format|
      format.js
    end
  end
end

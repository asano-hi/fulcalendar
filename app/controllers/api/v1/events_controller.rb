class Api::V1::EventsController < ApplicationController

  before_action :authenticate_user!

  rescue_from Exception, with: :render_status_500
  
  def index
    events = Event.all

    respond_to do |format|
      format.html
      format.json {render :json => events }
    end

  end

  private

  def render_status_500(exception)
    render json: { errors: [exception] }, status: 500
  end

end

class RegistrationsController < ApplicationController

  before_action  :require_signin
  before_action  :set_event

  def index
    @registrations = @event.registrations
  end

  def new
    if @event.registrations.find_by(user_id: current_user)
      redirect_to user_path(current_user),
      notice: 'You already registered in this Event!'
    end
    @registration = @event.registrations.new  
  end

  def create 
    @registration = @event.registrations.new(registration_params)  
    
    if @event.registrations.find_by(user_id: current_user)
      redirect_to user_path(current_user),
      notice: 'You already registered in this Event!'
    else
      @registration.user = current_user 
      if @registration.save
        redirect_to event_registrations_url(@event),
        notice: 'Thanks for registering!'
      else  
        render :new, status: :unprocessable_entity
      end
    end
  end

private

  def registration_params
    params.require(:registration).permit(:how_heard)
  end

  def set_event
    @event = Event.find_by!(slug: params[:event_id])
  end

end

class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.save
    redirect_to action: :index
  end

  private

  def event_params
    params.require(:event).permit(:name, :name, :description, :open, :start_accepting, :end_accepting)
  end
end

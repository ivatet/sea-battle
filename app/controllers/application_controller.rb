class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_player

  def set_player
    if not session.key?(:player_uuid)
      session[:player_uuid] = SecureRandom.uuid
    end

    if not session.key?(:player_name)
      session[:player_name] = [:Oliver, :Jack, :Harry, :Jacob, :Charlie].sample
    end
  end
end

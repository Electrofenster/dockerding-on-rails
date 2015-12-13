class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

  def set_locale

    if params[:locale]
      session[:locale] = params[:locale]
    end

    locale = session[:locale] || I18n.default_locale
    I18n.locale = locale
  end
end

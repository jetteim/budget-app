class ApplicationController < ActionController::API
  include Authentication

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception, unless: -> { request.format.json? }

  def boot
    render
  end
end

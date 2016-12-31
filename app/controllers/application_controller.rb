class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_authorized_for_current_course
    if current_course.user != current_user
      render text: 'Unauthorized', status: :unauthorized
    end
  end

  helper_method :current_course
  def current_course
    if params[:id].nil?
      @current_course ||= Course.find(params[:class_id])
    else
      @current_course ||= Course.find(params[:id])
    end
  end

end

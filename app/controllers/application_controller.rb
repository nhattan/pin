class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Exception do |e|
    error(e)
  end

  protected
  def error(e)
    # render :template => "#{Rails::root}/public/404.html"
    if env["ORIGINAL_FULLPATH"] =~ /^\/api/
      error_info = {
        :error => "internal-server-error",
        :exception => "#{e.class.name} : #{e.message}",
      }
      error_info[:trace] = e.backtrace[0, 10] if Rails.env.development?
      render :json => error_info.to_json, :status => 500
    else
      render :json => {message: e.message}, :status => 500
    end
  end

  private
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end

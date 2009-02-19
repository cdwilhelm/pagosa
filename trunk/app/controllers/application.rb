# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  #helper_method :render_to_string


  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'f471ea3a8a9bc7f002d3e126f617b3ca'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
end

def current_user_id
  session[:user_id]
end
#hide_action :current_user_id

def current_user_logged_in?
  ! current_user.nil?
end
#hide_action :current_user_logged_in?
#helper_method :current_user_logged_in?


private
# Retrieves the user for the current session.
def current_user
  @current_user ||= current_user_id ? User.find(current_user_id) : User.anonymous
end
#helper_method :current_user

def current_user_id=(id)
  session[:user_id] = id
  # Invalidate cached value
  @current_user = nil
end

def current_user=(user)
  self.current_user_id = user.id if user
  @current_user = user
end

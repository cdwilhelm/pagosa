class UsersController < ApplicationController

  def add_user
    @user = User.new(params[:user])
    if request.post? and @user.save
      flash.now[:notice] = "User #{@user.name} created"
      @user = User.new
      redirect_to(:action => "login" )
    end
  end

  def login
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:login], params[:password])
      if user
        session[:user_id] = user.id
        redirect_to(:controller=>"home",:action => "index" )
      else
        flash.now[:notice] = "Invalid user/password combination"
      end
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to(:action => "login" )
  end

  def index
  end

  def delete_user
  end

  def list_users
  end

end

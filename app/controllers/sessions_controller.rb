class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params['session']['email'].downcase)
      if user && user.authenticate(params[:session][:password])
        log_in user
        # checks to see if the user wants to be remembered. 
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to user
      else
        # create an error message; flash.now ensures it won't remain in the flash after the render 'new'
        flash.now[:danger] = "Invalid email/password cominbation. Please try again!" #not quite right
        render 'new'
      end
  end
  
  # destroys session
  def destroy
    # only works user is logged in
    log_out if logged_in?
    redirect_to root_url
  end

end

class UsersController < ApplicationController
  def auth
    auth_hash = request.env['omniauth.auth']
    session[:user] = User.with_facebook(auth_hash)
    session[:credentials] = auth_hash[:credentials]
    redirect_to "/#/meetings"
  end

  def auth_failure
    logger.debug request.env['omniauth.auth'].to_s
    render :json => {hi: "hello"}
  end
end

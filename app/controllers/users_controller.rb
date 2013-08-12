class UsersController < ApplicationController
  def auth
    auth_hash = request.env['omniauth.auth']
    logger.debug "==auth hash=="
    logger.debug auth_hash.to_s
    logger.debug "============="
    session[:user] = User.with_facebook(auth_hash)
    session[:credentials] = auth_hash[:credentials]
    render :json => session[:user]
  end

  def auth_failure
    logger.debug request.env['omniauth.auth'].to_s
    render :json => {hi: "hello"}
  end
end

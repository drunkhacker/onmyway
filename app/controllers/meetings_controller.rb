class MeetingsController < ApplicationController
  before_filter :check_session

  def index
  end

  def pendings
    render :json => session[:user].pending_meetings.to_json(:include => :initiator)
  end

  def history
    render :json => session[:user].confirmed_meetings.to_json(:include => :initiator)
  end

  def create
    meeting = session[:user].invite(params[:invitee_id], {:facebook_id => params[:post_id], :salt => params[:salt]})
    render :json => meeting
  end

  def new
    @my_fb_id = session[:user].facebook_id
  end

  def show
    #permission check
    @meeting = Meeting.find_by_salt(params[:salt])
    logger.debug "receiver = #{@meeting.receiver_id.class}, user = #{session[:user].facebook_id.class}, #{@meeting.receiver_id != session[:user].facebook_id}"
    redirect_to root_path if @meeting.receiver_id != session[:user].facebook_id
  end

  def confirm
    #permission check
    @meeting = Meeting.find_by_id(params[:id])
    if @meeting.receiver_id != session[:user].facebook_id
      render :json => {error: "It's not your meeting"}
    else
      @meeting.confirm({:latitude => params[:latitude], :longitude => params[:longitude]})
      render :json => @meeting
    end
  end

  def discard

  end
end

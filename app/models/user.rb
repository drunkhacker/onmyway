class User < ActiveRecord::Base
  has_many :invitations, class_name: "Meeting", foreign_key: "receiver_id" #received requests
  has_many :requests, class_name: "Meeting", foreign_key: "sender_id" #sent requests (from me)

  self.primary_key = :facebook_id

  def self.create_with_facebook(omniauth_hash)
    User.create(:facebook_id => omniauth_hash[:uid], :name => omniauth_hash[:info][:name])
  end

  def self.find_by_facebook(facebook_id)
    User.where(:facebook_id => facebook_id).first
  end

  def self.with_facebook(omniauth_hash)
    self.find_by_facebook(omniauth_hash[:uid]) || self.create_with_facebook(omniauth_hash)
  end

  def pending_meetings
    self.invitations.where(:status => Meeting::STATUS_PENDING).order("updated_at DESC")
  end

  def confirmed_meetings
    self.invitations.where(:status => Meeting::STATUS_CONFIRM).order("updated_at DESC")
  end

  def invite(invitee_id, options)
    Meeting.create({:sender_id => self.id, :receiver_id => invitee_id}.merge(options))
  end
end

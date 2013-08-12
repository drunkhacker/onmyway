class Meeting < ActiveRecord::Base
  belongs_to :invitee, class_name: "User", foreign_key: "receiver_id"
  belongs_to :initiator, class_name: "User", foreign_key: "sender_id"

  STATUS_PENDING = 0
  STATUS_CONFIRM = 1
  STATUS_DISCARD = 2

  def confirm(options)
    self.update_attributes({status: STATUS_CONFIRM}.merge(options))
  end

  def discard
    self.update_attribute(:status, STATUS_DISCARD)
  end

  def self.find_by_salt(salt)
    self.where(:salt => salt).first
  end
end

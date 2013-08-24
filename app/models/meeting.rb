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

  def self.ranks(user)
    self.joins("JOIN users ON meetings.sender_id = users.facebook_id")
    .where("receiver_id = ?", user.facebook_id)
    .select("COUNT(*) AS count_all,
             meetings.sender_id AS sender_id,
             users.name AS name, 
             MAX(meetings.updated_at) AS last_seen")
    .group("sender_id").order("count_all DESC").map do |r|
      {
       sender_id: r.sender_id,
       name: r.name,
       count: r.count_all,
       last_seen: DateTime.parse(r.last_seen)
      }
    end
  end

  def self.find_by_salt(salt)
    self.where(:salt => salt).first
  end
end

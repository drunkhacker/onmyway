require 'test_helper'

class MeetingTest < ActiveSupport::TestCase
  test "confirm" do
    meeting = users(:user2).pending_meetings[0]
    meeting.confirm
    assert users(:user2).pending_meetings.count == 1
  end

  test "discard" do
    meeting = users(:user2).pending_meetings[0]
    meeting.discard
    assert users(:user2).pending_meetings.count == 1
  end

  test "invite" do
    meeting = users(:user1).invite users(:user3)
    pendings = users(:user3).pending_meetings
    assert !meeting.nil? && pendings.count == 1, "pending meetings count = #{pendings.count}"
  end
end

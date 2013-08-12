require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "create with facebook id" do
    u = User.create_with_facebook({:uid=>"1356247794"})
    assert !u.nil? && u.id != ""
  end

  test "get my meetings" do
    u = users(:user2)
    meetings = u.pending_meetings
    assert meetings.count == 2, "meetings count = #{meetings.count}"
  end

  test "get_or_create from facebook" do
    #get
    assert User.with_facebook({:uid => "100"}).id == users(:user1).id

    #create
    assert !User.with_facebook({:uid => "10001"}).nil?
  end

  # test "the truth" do
  #   assert true
  # end
end

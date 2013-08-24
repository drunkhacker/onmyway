App.controller 'NewMeetingCtrl', ($scope, $location, Meeting, Facebook) ->
  Facebook.friends (friends) ->
    console.log friends.length
    $scope.friends = friends
    $scope.$apply()

  $scope.showMessageView = (friend) ->
    salt = "#{friend.uid}_#{Math.round(new Date().getTime()/1000)}"
    FB.ui
      method: "feed",
      link: "http://onmyway.dev/#/#{salt}",
      picture: "http://onmyway.dev/friend.png",
      name: "I'm on my way",
      description: "I'm now going to #{friend.name}. See you soon",
      message: "hihihi",
      to: friend.uid
      , (response, error) ->
        if response? and response.post_id?
          postid = response.post_id
          meeting = new Meeting(invitee_id:friend.uid, post_id:postid, salt: salt)
          meeting.$save (m, responseHeaders) ->
            console.dir m
            console.dir responseHeaders
            #move to meeting list
            $location.path '/meetings'

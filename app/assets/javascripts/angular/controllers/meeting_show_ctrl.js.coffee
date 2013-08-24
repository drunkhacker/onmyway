App.controller 'MeetingShowCtrl', ($scope, $routeParams, Meeting, Facebook, GeoController, $location) ->
    Meeting.getBySalt $routeParams, (meeting) ->
      $scope.meeting = meeting
      Facebook.getMessage($scope.meeting).then (r) -> $scope.meeting.message = r.message
      Facebook.user(meeting.sender_id).then (r) -> $scope.sex = r.gender

      if $scope.meeting and $scope.meeting.status == 1
        $scope.meetingPosition = latitude: $scope.meeting.latitude, longitude: $scope.meeting.longitude
        console.dir $scope.meetingPosition
        $scope.positionMarker = [$scope.meetingPosition]
    , (error) ->
      alert error.data.error
      $location.path '/meetings'

    $scope.sex = "male"

    $scope.check = () ->
      GeoController.getLocation().then (loc) ->
        #update meeting
        Meeting.confirm {meetingId:$scope.meeting.id}, {latitude: loc.coords.latitude, longitude: loc.coords.longitude}, (r) ->
          #back to the list
          $location.path '/meetings'
        (e) -> console.dir e

    $scope.meetingPosition = latitude:0, longitude:0

App.controller 'MeetingListCtrl', ($scope, $location, Meeting, Facebook) ->
  loadMessage = (meeting) -> 
    Facebook.getMessage(meeting).then (res) ->
      msg = res.message
      meeting.message = msg

  actions =
    "/history": Meeting.history
    "/meetings": Meeting.query

  actions[$location.path()] (meetings) ->
    $scope.meetings = meetings
    loadMessage meeting for meeting in $scope.meetings

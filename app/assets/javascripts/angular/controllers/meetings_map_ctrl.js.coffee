App.controller 'MeetingsMapCtrl', ($scope, Meeting) ->
  $scope.center = latitude:37, longitude:123
  $scope.meetingMarkers = []
  Meeting.history (meetings) ->
    #get center coord
    coords = []
    for meeting in meetings
      coords.push
        latitude: parseFloat meeting.latitude
        longitude: parseFloat meeting.longitude

    max_lat = -90
    min_lat = 90
    max_lng = -180
    min_lng = 180

    for coord in coords
      max_lat = coord.latitude if max_lat < coord.latitude
      min_lat = coord.latitude if min_lat > coord.latitude
      max_lng = coord.longitude if max_lng < coord.longitude
      min_lng = coord.longitude if min_lng > coord.longitude

    #calculate center, and zoom level
    mid_lat = (max_lat + min_lat)/2.0
    mid_lng = (max_lng + min_lng)/2.0
    $scope.center = latitude: mid_lat, longitude: mid_lng
    console.dir $scope.center
    $scope.meetingMarkers = coords

    #$("#map")[0].fit()

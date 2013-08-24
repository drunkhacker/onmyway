App.controller 'LeaderBoardCtrl', ($scope, Meeting) ->
  Meeting.ranks (r) ->
    console.dir r
    $scope.ranks = r

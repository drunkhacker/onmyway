App.factory 'Facebook', ($rootScope, $q) ->
  friends: (callback) ->
    FB.getLoginStatus (r) ->
      FB.api
        method: 'fql.query',
        query:'SELECT uid, name FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1=me()) ORDER BY name'
      , (response) ->
        callback response
  user: (uid) ->
    deferred = $q.defer()
    FB.getLoginStatus () ->
      FB.api "/"+uid, (response) ->
        $rootScope.$apply(deferred.resolve response)
    deferred.promise
  getMessage: (meeting) ->
    deferred = $q.defer()
    FB.getLoginStatus () ->
      FB.api meeting.facebook_id, (response) ->
        $rootScope.$apply(deferred.resolve response)
    deferred.promise

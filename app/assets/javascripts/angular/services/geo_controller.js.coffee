App.factory 'GeoController', ($window, $q, $rootScope) ->
  supportsGeo: $window.navigator?
  lastLocation: latitude:0, longitude:0
  getLocation: () ->
    deferred = $q.defer()
    if this.supportsGeo
      $window.navigator.geolocation.getCurrentPosition (position) ->
        this.lastLocation = position
        $rootScope.$apply(deferred.resolve position)
      , (error) ->
        deferred.reject error
    else
      deferred.reject error: "browser don't support geolocation"
    deferred.promise

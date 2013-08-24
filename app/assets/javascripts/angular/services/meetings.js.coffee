App.factory "Meeting", ($resource) -> 
  $resource '/api/:salt/:controllers/:meetingId/:action', {meetingId: '@id', controllers: 'meetings'},
    #user defined additional actions
    history: method:"GET", isArray: true, params:action:"history"
    getBySalt: method:"GET", url:"/api/:salt", params: controllers: '', salt: '@salt'
    confirm: method:"POST", params: action:"confirm", meetingId:"@id"
    ranks: method:"GET", isArray:true, params: controllers:"leaderboard"

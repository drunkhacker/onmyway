#hide menu button after click
$("#menus a").click (e) ->
  $("#menus a").parent("li").removeClass "active"
  $(e.target).parent("li").addClass "active"
  $("#menu-btn").click() if $("#menu-btn").is ':visible'

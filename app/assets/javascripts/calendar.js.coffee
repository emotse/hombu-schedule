# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).on 'ready', (e) =>
  $('div.day').on 'click', 'div.class', (e) =>
    item = if($(e.target).is('p.name, em.time')) then $(e.target).parent() else $(e.target)
    [time, name] = ($(child).text() for child in item.children())
    console.log(time, name)

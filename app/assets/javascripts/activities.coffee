# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(".activities").ready ->
  $("a.add_comment").click (e)->
    e.preventDefault()
    $(this).parent(".state").next("ul.list-group").toggle()

 
$(".activities").ready ->
  $(".topic .remove").on "ajax:success", ->
    $(this).parent().fadeOut()
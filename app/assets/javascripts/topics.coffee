# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#模拟点击第一个关注的话题以显示
$(".topics").ready ->
  $("div.topic-tag:first a").trigger("click")
    
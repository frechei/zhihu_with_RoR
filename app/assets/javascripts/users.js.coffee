# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# 此持可以重构，待熟悉coffeescript以后，把7,8,9,10四行合为一个函数然后
# 调用，现在不会的是函数里的this如何处理。

$(".users.show").ready ->
  $('a.location-link').click ->
  	$this = $(this)
  	$info = $this.parents('.info')
  	$info.children('#location').hide()
  	$info.children('#location_form').css('display', 'inline-block')
  												.children('.row').show()
  $('#edit-location').click ->
    $this = $(this)
    $info = $this.parents('.info')
    $info.children('#location').hide()
    $info.children('#location_form').css('display', 'inline-block')
                          .children('.row').show() 												
 	
$(".users.show").ready ->
 	$('a.working-link').click ->
  	$this = $(this)
  	$info = $this.parents('.info')
  	$info.children('#working').hide()
  	$info.children('#working_form').css('display', 'inline-block')
  												.children('.row').show()
  $('#edit-working').click ->
    $this = $(this)
    $info = $this.parents('.info')
    $info.children('#working').hide()
    $info.children('#working_form').css('display', 'inline-block')
                          .children('.row').show() 

$(".users.show").ready ->
  $('a.education-link').click ->
    $this = $(this)
    $info = $this.parents('.info')
    $info.children('#education').hide()
    $info.children('#education_form').css('display', 'inline-block')
                          .children('.row').show()
  $('#edit-education').click ->
    $this = $(this)
    $info = $this.parents('.info')
    $info.children('#education').hide()
    $info.children('#education_form').css('display', 'inline-block')
                          .children('.row').show()

$(".users.show").ready ->
  $('a.statements-link').click ->
    $this = $(this)
    $statement = $this.parents('.statement')
    $statement.children('#statements').hide()
    $statement.children('#statements_form').css('display', 'inline-block')
                          .children('.row').show()
  $('#edit-statements').click ->
    $this = $(this)
    $statement = $this.parents('.statement')
    $statement.children('#statements').hide()
    $statement.children('#statements_form').css('display', 'inline-block')
                          .children('.row').show()
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->

  $('#network').addClass 'active'


  $('#filter a[href="#dns-rev"]').tab 'show'
  $('#filter a[href="#dns-rev"]').addClass 'active'



  # new FixedHeader oTable
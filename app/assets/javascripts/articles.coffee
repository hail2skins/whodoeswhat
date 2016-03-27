# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $("#add_file").on "ajax:success", (event, data) ->
    $("#attachments").append data
    $(this).data "params", { index: $("#attachments div.file").length }

$(document).ready(ready)
$(document).on('page:load', ready)

token = ->
  $('#article_contact_tokens').tokenInput $('#contacts').data('url'),
    theme: 'facebook'
    prePopulate: $('#article_contact_tokens').data('load')
    propertyToSearch: "email"
    
$(document).ready(token)
$(document).on('page:load', token)
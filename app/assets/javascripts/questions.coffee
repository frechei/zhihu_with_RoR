# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  editor = new Simditor({
    textarea: $('#editor'),
    toolbar: ['title', 'bold', 'italic', 'underline', 'strikethrough',
              'color', '|', 'ol', 'ul', 'blockquote', 'code', 'table',
              'link','image', '|','hr','indent','outdent','alignment'],
    pasteImage: true,
    fileKey: 'file',
    upload: {
      url: '/photos',
      params: null,
      connectionCount: 3,
    }
  });
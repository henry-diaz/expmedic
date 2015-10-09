readURL = (input, previewer) ->
  if input.files and input.files[0]
    reader = new FileReader()
    reader.onload = (e) ->
      previewer.attr "src", e.target.result
      return
    reader.readAsDataURL input.files[0]
  return

decorateFileField = (field) ->
  img = field.next("img")
  img.addClass("img-preview")

  field.on "change", ->
    readURL(field.get(0), img)
  field.before(
    $("<a />").
      addClass("input-file").
      addClass("btn").
      addClass("btn-default").
      text("Seleccione una imagen").
      on "click", (e) ->
        e.preventDefault()
        e.stopPropagation()
        field.trigger "click"
  )
  field.hide()

$(document).on "nested:fieldAdded", (event) ->
  field = event.field.find("[data-preview]")
  decorateFileField(field)

$(document).ready ->
  $("[data-preview]").each ->
    decorateFileField($(this))

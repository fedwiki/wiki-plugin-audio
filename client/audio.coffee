
parse = (text='') ->
  result = {}
  firstLine = true
  for line in text.split /\r\n?|\n/
    if firstLine
      result.key = line
      firstLine = false
    else
      result.caption ||= ' '
      result.caption += line + ' '
  result

embed = ({key}) ->
  """
    <audio src="#{key}" preload="none" controls>
    <a href="#{key}">download audio</a></audio>
  """


emit = ($item, item) ->
  result = parse item.text
  $item.append """
    #{embed result}
    <br>
    <i>#{result.caption || "(no caption)"}</i>
  """

bind = ($item, item) ->
  $item.dblclick -> wiki.textEditor $item, item

window.plugins.audio = {emit, bind} if window?
module.exports = {parse, embed} if module?

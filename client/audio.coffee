###
 * Federated Wiki : Audio Plugin
 *
 * Licensed under the MIT license.
 * https://github.com/fedwiki/wiki-plugin-audio/blob/master/LICENSE.txt
###

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
    <iframe
      srcdoc='<audio src="#{key}" preload="none" controls style="width: 100%;"><a href="#{key}">download audio</a></audio>'
      width="100%" frameborder=0 seamless scrolling="no" height="40px">
    </iframe>
  """


emit = ($item, item) ->
  result = parse item.text
  $item.append """
    #{embed result}
    <br>
    <i>#{wiki.resolveLinks(result.caption) || "(no caption)"}</i>
  """

bind = ($item, item) ->
  $item.dblclick -> wiki.textEditor $item, item

window.plugins.audio = {emit, bind} if window?
module.exports = {parse, embed} if module?

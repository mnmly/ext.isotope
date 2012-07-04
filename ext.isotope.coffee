
# ### Overriding isotope translate hooks

# If Modernizr is not installed with `prefixed`, use this one from `isotope`

prefixes = "Moz Webkit O Ms".split(" ")
capitalize = (str) -> str.charAt(0).toUpperCase() + str.slice(1)


getStyleProperty = if Modernizr?.prefixed? then Modernizr.prefixed else (propName) ->

  style    = document.documentElement.style
  prefixed = null

  if typeof style[propName] is "string"
    return propName
  
  propName = capitalize(propName)

  for prefix in prefixes
    prefixed = prefix + propName
    if typeof style[prefixed] is "string"
      return prefixed


# Retain what's in the cssHook

_originalHookSet         = $.cssHooks.translate.set
_transitionDurationProp  = getStyleProperty('transitionDuration')

$.cssHooks.translate.set = (elem, value)->
  
  isTwoWay = $.data(elem.parentElement, 'isTwoWay')

  if isTwoWay?
    if not isTwoWay
      return _originalHookSet(elem, value)
    
  posData = $.data(elem, "isoTransform")
  _value  = null

  #If there is timer already running, kill it.
  if $.data( elem, 'timer')
    clearTimeout $.data(elem, 'timer')
    $.data(elem, 'timer', null)

  if posData?

    # Store it so that we don't have to `getComputedStyle` every single time...
    # or perhaps store it in a single variable somehow...
    unless $.data(elem, 'duration')?
      $.data(elem, 'duration', parseFloat( getComputedStyle( elem )[ _transitionDurationProp ]) * 1000)

    duration = $.data(elem, 'duration')

    # Not cool to use `setTimeout` than `transitionEnd Event`...
    # it basically waits for initial transition to end, then trigger **full** translation
    timer    = setTimeout ->
      _originalHookSet(elem, value)
    , duration

    $.data(elem, 'timer', timer)

  if posData?.translate?
    # Randomly sets initial direction
    _value = if (Math.random() < .5) then [value[0], posData.translate[1] ] else [posData.translate[0], value[1] ]
  else
    _value = value

  _originalHookSet(elem, _value)


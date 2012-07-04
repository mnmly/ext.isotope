# ext.isotope

A simple extension that adds a two-way translation on top of great library: [isotope]: here's the [demo].

## Usage

Simple. Just put `ext.isotope.js` after `isotope` script tag.

If you are using [require.js], it will be something like:

```coffeescript
  
  require.config
    paths:
      'isotope': 'path/to/isotope'
      'isotope-amd': 'path/to/ext.isotope.amd'

  define ['isotope-amd'], ->
    
    $('.container').isotope()

    # If you don't want the two-way translation:
    # (which doesn't make any sense you use this extension...)
    #
    #    $.data($('.container')[0], 'isTwoWay', false);

```

[require.js]: http://requirejs.org
[isotope]: http://isotope.metafizzy.co
[demo]: http://mnmly.github.com/ext.isotope/


## How does this work?

Basically it sorta overrides `cssHook.translate` declared in `isotope` then randomly selects which direction it should take (vertially / horisontally),
and fires a timer that handles another direction.

As I simply don't wanted to mess around with original isotope, I chose this approach to add this functionality.

**the timer solution is not optimal. it should utilize `transitionEnd` event that monitors the end of initial translation event**

## Licensing for __isotope__

**Commercial use requires purchase of one-time license fee per developer seat.** Commercial use  includes any application that makes you money. This includes portfolio sites and premium templates. Commercial licenses may be purchased at [http://metafizzy.co#licenses](http://metafizzy.co#licenses).

Use in non-commercial and personal applications is free.

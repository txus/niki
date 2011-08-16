# Niki

Niki is a Ruby DSL to describe and play musical pieces.

Its name comes from the [world-famous band Niki](http://niki.fm) which I happen
to be part of :D

It leverages Ari Russo's [Unimidi](
https://github.com/arirusso/unimidi) to send MIDI output to other
programs accepting MIDI inputs (Ableton Live, Reason, Garage Band...), which
will actually play the song.

To see what the DSL looks like, take a look at the [example song](https://github.com/txus/niki/blob/master/examples/my_song.rb).

Thanks to Unimidi, it works on all major platforms (Linux, OSX and Windows). To
ensure Niki will run on your platform (I've personally tested it with OSX only),
please look at the [Unimidi repo at Github](https://github.com/arirusso/unimidi)
for instructions about your specific platform.

Currently niki runs (at least) on Ruby MRI versions 1.8.7 and 1.9.2.

## Run the example song

First of all, get the example song files (both the Reason file and the Ruby file)

    $ curl -o my_song.rns https://raw.github.com/txus/niki/master/examples/my_song.rns
    $ curl -o my_song.rb https://raw.github.com/txus/niki/master/examples/my_song.rb

Now [download a demo version](
http://www.propellerheads.se/download/index.cfm?fuseaction=get_article&article=reason) of Propellerhead's
Reason 5 and open up `my_song.rns`.

### Configuring the midi interface

This is how you configure the midi interface in Mac OSX (it should not be
difficult in other operating systems):

* Make sure the IAC driver is activated in Mac OSX's Audio/MIDI Setup (inside the
MIDI section) (activate the "Device is online" checkbox if it is not)
* Go to the Reason options panel, go to Advanced, and set your first
MIDI bus (Bus A) to "IAC Driver IAC Bus 1" or something similar.

### Install the gem and run!

Now you should install the gem and run the example!

    $ gem install niki
    $ ruby my_song.rb

# TODO

* Tests + refactor
* Documentation
* Expand this README

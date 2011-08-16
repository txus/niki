# Niki

Niki is a Ruby DSL to describe and play musical pieces.

Its name comes from the [world-famous band Niki](http://niki.fm) which I happen
to be part of.

It leverages Giles Bowkett's [Archaeopteryx](
https://github.com/gilesbowkett/archaeopteryx) to send MIDI output to other
programs accepting MIDI inputs (Ableton Live, Reason, Garage Band...), which
will actually play the song.

To see what the DSL looks like, take a look at the [example song](https://github.com/txus/niki/blob/master/examples/my_song.rb).

## Caveats

* It runs only in Ruby 1.8.7 (due to the dependency on Archaeopteryx) :(
* I've tested this only in Snow Leopard, but it should run in more platforms.
  If your platform is not supported it's because Archaeopteryx
  doesn't support it yet.

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
* In this section, make sure at least one port is created (under the Ports
section). If not, add one clicking the + button.
* Go to the Reason options panel, go to Advanced, and set your first
MIDI bus (Bus A) to "IAC Driver IAC Bus 1" (the port you just created).

### Install the gem and run!

Now you should install the gem and run the example!

    $ gem install niki
    $ ruby my_song.rb



# TODO

* Tests + refactor
* Documentation
* Expand this README

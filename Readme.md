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

## Syntax reference

A Niki Song is represented this way:

    song = Niki::Song.new do

      # +instrument+ lets you configure different instruments in different
      # MIDI channels.
      instrument :piano do
        channel 3
      end

      instrument :drums do
        channel 10

        # You can define macros for notes:
        note[:kick]  = c1 # Define a macro for the c1 note, name it :kick
        note[:snare] = d1 # And the snare will be d1
        note[:hh]    = e1 # And the hh will be e1
      end

      # You can define reusable riffs that you will be able to play with
      # different instruments:
      riff :simple_break do
        note g3, 8
        note f3, 8
        note e3, 8
        note d3, 8
      end

      # Define your song parts like this:
      part :intro do
        # Notes are defined like this:
        #   +instrument+ +note or [array of notes]+, +duration+, +options+
        #
        # +instrument+
        #   Instrument must be one of those you defined above.
        #
        # +note or [array of notes]+
        #   Has to be a musical note like c3 or f2 or a chord like a3MAJ. It
        #   can also be an array of notes. Examples of valid musical notes:
        #
        #   c2                  - a C in the 2nd octave
        #   f4                  - an F in the 4th octave
        #   +f4                 - an F sharp in the 4th octave
        #   -d3                 - a D flat in the 3rd octave
        #   f3MAJ               - a F major chord in the 3rd octave
        #   -d3MIN              - a D flat minor chord in the 3rd octave
        #   [c3, -e3, g3, -b3]  - a C min 7th chord in the 3rd octave
        #   :kick               - whatever note you defined in your instrument
        #
        # +duration+
        #   Duration can be expressed as a number representing a fraction.
        #   For example, a quarter note (4 of them fit in a single
        #   measure) is expressed with the number 4. An eighth note (8 of them
        #   fit in a single measure) is expressed with 8, and so on.
        #
        # +options+
        #   Options is an optional hash where you can specify the following
        #   per-note settings:
        #
        #   :velocity => (a number between 0 and 127)
        #   :base     => (a base note to add to some chord for example)
        #
        drums [:kick, :hh], 8
        drums :hh, 8
        drums :hh, 8

        piano f2MAJ, 4
        piano f2MAJ, 4
        piano f2MAJ, 4
        piano f2MAJ, 4
        piano a2MIN, 4, :base => f2
        piano silence, 4

        # Play the previously defined riff with the piano.
        riff :simple_break, :piano
      end

      # You can repeat any part!
      repeat :intro

      part :chorus do
        drums :from => :intro # Use the drums from the intro

        piano c2MAJ, 4
        piano c2MAJ, 4
        piano c2MAJ, 4
        piano c2MAJ, 4
        piano g2MAJ, 4
        piano silence, 4
        piano g2MAJ, 4
        piano g2MAJ, 8
        piano g2MAJ, 8
      end
    end

    # Play the song!!!
    song.play


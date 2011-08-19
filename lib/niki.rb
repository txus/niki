require 'core_ext/fixnum'
require 'core_ext/array'
require 'niki/chords'
require 'niki/part'
require 'niki/riff'
require 'niki/song'
require 'niki/instrument'

# = Niki
#
# Niki is a Ruby DSL to describe and play musical pieces.
#
# == Syntax
#
# A Niki Song is represented this way:
#
#   song = Niki::Song.new do
#
#     # +instrument+ lets you configure different instruments in different
#     # MIDI channels.
#     instrument :piano do
#       channel 3
#     end
#
#     instrument :drums do
#       channel 10
#
#       # You can define macros for notes:
#       note[:kick]  = c1 # Define a macro for the c1 note, name it :kick
#       note[:snare] = d1 # And the snare will be d1
#       note[:hh]    = e1 # And the hh will be e1
#     end
#
#     # You can define reusable riffs that you will be able to play with
#     # different instruments:
#     riff :simple_break do
#       note g3, 8
#       note f3, 8
#       note e3, 8
#       note d3, 8
#     end
#
#     # Define your song parts like this:
#     part :intro do
#       # Notes are defined like this:
#       #   +instrument+ +note or [array of notes]+, +duration+, +options+
#       #
#       # +instrument+
#       #   Instrument must be one of those you defined above.
#       #
#       # +note or [array of notes]+
#       #   Has to be a musical note like c3 or f2 or a chord like a3MAJ. It
#       #   can also be an array of notes. Examples of valid musical notes:
#       #
#       #   c2                  - a C in the 2nd octave
#       #   f4                  - an F in the 4th octave
#       #   +f4                 - an F sharp in the 4th octave
#       #   -d3                 - a D flat in the 3rd octave
#       #   f3MAJ               - a F major chord in the 3rd octave
#       #   -d3MIN              - a D flat minor chord in the 3rd octave
#       #   [c3, -e3, g3, -b3]  - a C min 7th chord in the 3rd octave
#       #   :kick               - whatever note you defined in your instrument
#       #   silence             - a silent note
#       #
#       # +duration+
#       #   Duration can be expressed as a number representing a fraction.
#       #   For example, a quarter note (4 of them fit in a single
#       #   measure) is expressed with the number 4. An eighth note (8 of them
#       #   fit in a single measure) is expressed with 8, and so on.
#       #
#       # +options+
#       #   Options is an optional hash where you can specify the following
#       #   per-note settings:
#       #
#       #   :velocity => (a number between 0 and 127)
#       #   :base     => (a base note to add to some chord for example)
#       #
#       drums [:kick, :hh], 8
#       drums :hh, 8
#       drums :hh, 8
#
#       piano f2MAJ, 4
#       piano f2MAJ, 4
#       piano f2MAJ, 4
#       piano f2MAJ, 4
#       piano a2MIN, 4, :base => f2
#       piano silence, 4
#
#       # Play the previously defined riff with the piano.
#       riff :simple_break, :piano
#     end
#
#     # You can repeat any part!
#     repeat :intro
#
#     part :chorus do
#       drums :from => :intro # Use the drums from the intro
#
#       piano c2MAJ, 4
#       piano c2MAJ, 4
#       piano c2MAJ, 4
#       piano c2MAJ, 4
#       piano g2MAJ, 4
#       piano silence, 4
#       piano g2MAJ, 4
#       piano g2MAJ, 8
#       piano g2MAJ, 8
#     end
#   end
#
#   # Play the song!!!
#   song.play
#
module Niki
end

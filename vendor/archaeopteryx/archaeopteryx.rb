alias :L :lambda

%w{rubygems midilib/sequence midilib/consts}.each {|lib| require lib}

%w{archaeopteryx/core_ext/struct
   archaeopteryx/core_ext/array

   archaeopteryx/loop
   archaeopteryx/drum
   archaeopteryx/rhythm
   archaeopteryx/mix

   archaeopteryx/live_hacks
   archaeopteryx/track
   archaeopteryx/clip

   archaeopteryx/midi/note
   archaeopteryx/midi/clock

   archaeopteryx/midi/file_output/file_midi

   archaeopteryx/midi/practical_ruby_projects/no_midi_destinations
   archaeopteryx/midi/practical_ruby_projects/core_midi
   archaeopteryx/midi/practical_ruby_projects/core_foundation
   archaeopteryx/midi/practical_ruby_projects/live_midi
   archaeopteryx/midi/practical_ruby_projects/timer}.each do |archaeopteryx|
     require File.expand_path(File.dirname(__FILE__)) + "/../#{archaeopteryx}"
   end

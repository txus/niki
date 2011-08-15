require 'rubygems'
require 'niki'

song = Niki::Song.new :tempo => 127 do

  # Configure midi channels
  channel :basses, 1
  channel :drums, 10
  channel :chords, 2
  channel :melodies, 3

  configure :drums do |drums|
    drums[:kick]  = c1
    drums[:snare] = c1.sharp
    drums[:hh]    = g1
    drums[:ohh]   = g1.sharp
  end

  part :intro do
    # Drums
    2.times do
      drum [:kick, :hh], 8
      drum :hh, 8
      drum [:snare, :hh], 8
      drum :hh, 8

      drum [:kick, :hh], 8
      drum :hh, 8
      drum [:snare, :hh], 8
      drum [:kick, :hh], 8

      drum :hh, 16
      drum :hh, 16
      drum :hh, 16
      drum :hh, 16
      drum [:snare, :hh], 8
      drum :hh, 8

      drum [:kick, :hh], 8
      drum [:kick, :hh], 8
      drum [:snare, :hh], 8
      drum :ohh, 8
    end

    # Bass
    bass f2, 4

    bass f2, 8
    bass e2, 8
    bass f2, 8
    bass e2, 8
    bass f2, 8

    bass e3, 4
    bass c3, 4
    bass b2, 8
    bass c2, 8
    bass c2, 8
    bass g2, 4

    bass a2, 4

    bass a2, 8
    bass g2, 8
    bass a2, 8
    bass g2, 8
    bass a2, 8

    bass e3, 4
    bass c3, 4
    bass b2, 8
    bass c2, 8
    bass c2, 8
    bass g2, 4
  end

  part :intro_ending do
    # Drums
    drum [:kick, :hh], 8
    drum :hh, 8
    drum [:snare, :hh], 8
    drum :hh, 8

    drum [:kick, :hh], 8
    drum :hh, 8
    drum [:snare, :hh], 8
    drum [:kick, :hh], 8

    drum :hh, 16
    drum :hh, 16
    drum :hh, 16
    drum :hh, 16
    drum [:snare, :hh], 8
    drum :hh, 8

    drum [:kick, :hh], 8
    drum [:kick, :hh], 8
    drum [:snare, :hh], 8
    drum :ohh, 8

    # Drum break
    drum [:kick, :hh], 8
    drum :hh, 8
    drum [:kick, :hh], 8
    drum :hh, 8
    drum [:kick, :hh], 8
    drum :hh, 8
    drum [:kick, :hh], 8
    drum :hh, 8

    drum [:snare, :ooh], 4
    drum [:snare, :ooh], 4
    drum :snare, 16
    drum :snare, 16
    drum :kick, 16
    drum :kick, 16
    drum :snare, 16
    drum :snare, 16
    drum [:snare, :ooh], 16
    drum :snare, 16

    # Bass
    bass f2, 4

    bass f2, 8
    bass e2, 8
    bass f2, 8
    bass e2, 8
    bass f2, 8

    bass e3, 4
    bass c3, 4
    bass b2, 8
    bass c2, 8
    bass c2, 8
    bass g2, 4

    bass a2, 4
    bass a2, 4
    bass a2, 4
    bass a2, 4

    bass b2, 8
    bass b2, 8
    bass b2, 8
    bass c2, 8
    bass c2, 8
    bass c2, 8
    bass d3, 8
    bass e3, 8
  end

  part :pre_chorus do
    bass :from => :intro
    drum :from => :intro

    melody a2, 4
    melody a2, 4
    melody f3, 8
    melody g3, 8
    melody a3, 8
    melody g3, 4
    melody f3, 8
    melody e3, 8
    melody d3, 4
    melody c3, 8
    melody e3, 4

    melody a2, 2
    melody a2, 8
    melody g2, 4
    melody c2, 4

    melody c3, 8
    melody d3, 8
    melody e3, 8
    melody f3, 8
    melody e3, 8
    melody d3, 8
    melody c3, 8
  end

  repeat :pre_chorus

  part :chorus do
    melody :from => :pre_chorus

    # Bass
    2.times do
      bass f2, 8
      bass f3, 8
      bass f2, 8
      bass f3, 8
    end
    bass c2, 8
    bass c3, 8
    bass c2, 8
    bass c3, 8

    bass g2, 8
    bass g3, 8
    bass f2, 8
    bass d2, 8

    2.times do
      bass a1, 8
      bass a2, 8
      bass a1, 8
      bass a2, 8
    end
    bass c1, 8
    bass c2, 8
    bass c1, 8
    bass c2, 8

    bass g1, 8
    bass g2, 8
    bass f1, 8
    bass d2, 8

    # Drums
    7.times do
      drum [:kick, :hh], 8
      drum :hh, 8
      drum [:snare, :kick, :hh], 8
      drum :hh, 8
    end
    drum :kick, 8
    drum :hh, 16
    drum :hh, 16
    drum [:snare, :kick], 16
    drum :snare, 16
    drum [:kick, :ohh], 8

    # Chords
    chord a3MIN(2), 2, :base => f3
    chord a3MIN(2), 8, :base => f3
    chord a3MIN(2), 8, :base => f3
    chord a3MIN(2), 8, :base => f3
    chord c3MAJ, 4
    chord c3MAJ, 4
    chord c3MAJ, 8
    chord g3MAJ, 2
    chord [a3, b3, e4]
    chord c3MAJ, 4
    chord c3MAJ, 4
    chord g3MAJ, 8
    chord g3MAJ, 8
    chord g3MAJ, 8, :base => f4
    chord g3MAJ, 8, :base => e4
  end

  repeat :chorus

  part :outro do
    drum :from => :intro
    bass :from => :intro
    chord :from => :chorus
  end

  part :outro_ending do
    bass :from => :intro
    chord :from => :chorus
  end
end

song.play

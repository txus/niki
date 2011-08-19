require 'rubygems'
require 'niki'

song = Niki::Song.new :tempo => 127 do

  instrument :bass do
    channel 1
  end

  instrument :chords do
    channel 2
  end

  instrument :melody do
    channel 3
  end

  instrument :drums do
    channel 10

    note[:kick]  = c1
    note[:snare] = +c1
    note[:hh]    = g1
    note[:ohh]   = +g1
  end

  part :intro do
    # Drums
    2.times do
      drums [:kick, :hh], 8
      drums :hh, 8
      drums [:snare, :hh], 8
      drums :hh, 8

      drums [:kick, :hh], 8
      drums :hh, 8
      drums [:snare, :hh], 8
      drums [:kick, :hh], 8

      drums :hh, 16
      drums silence, 16
      drums :hh, 16
      drums :hh, 16
      drums [:snare, :hh], 8
      drums :hh, 8

      drums [:kick, :hh], 8
      drums [:kick, :hh], 8
      drums [:snare, :hh], 8
      drums :ohh, 8
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
    drums [:kick, :hh], 8
    drums :hh, 8
    drums [:snare, :hh], 8
    drums :hh, 8

    drums [:kick, :hh], 8
    drums :hh, 8
    drums [:snare, :hh], 8
    drums [:kick, :hh], 8

    drums :hh, 16
    drums :hh, 16
    drums :hh, 16
    drums :hh, 16
    drums [:snare, :hh], 8
    drums :hh, 8

    drums [:kick, :hh], 8
    drums [:kick, :hh], 8
    drums [:snare, :hh], 8
    drums :ohh, 8

    # drums break
    drums [:kick, :hh], 8
    drums :hh, 8
    drums [:kick, :hh], 8
    drums :hh, 8
    drums [:kick, :hh], 8
    drums :hh, 8
    drums [:kick, :hh], 8
    drums :hh, 8

    drums [:snare, :ohh], 4
    drums [:snare, :ohh], 4
    drums :snare, 16
    drums :snare, 16
    drums :kick, 16
    drums :kick, 16
    drums :snare, 16
    drums :snare, 16
    drums [:snare, :ohh], 16
    drums :snare, 16

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
    drums :from => :intro

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
      drums [:kick, :hh], 8, :velocity => 127
      drums :hh, 8
      drums [:snare, :kick, :hh], 8, :velocity => 127
      drums :hh, 8
    end
    drums :kick, 8, :velocity => 127
    drums :hh, 16
    drums :hh, 16
    drums [:snare, :kick], 16, :velocity => 127
    drums :snare, 16
    drums [:kick, :ohh], 8

    # Chords
    chords a3MIN(2), 2, :base => f3
    chords a3MIN(2), 8, :base => f3
    chords a3MIN(2), 8, :base => f3
    chords a3MIN(2), 8, :base => f3
    chords c3MAJ, 4
    chords c3MAJ, 4
    chords c3MAJ, 8
    chords g3MAJ, 2
    chords [a3, b3, e4]
    chords c3MAJ, 4
    chords c3MAJ, 4
    chords g3MAJ, 8
    chords g3MAJ, 8
    chords g3MAJ, 8, :base => f4
    chords g3MAJ, 8, :base => e4
  end

  repeat :chorus

  part :outro do
    drums :from => :intro
    bass :from => :intro
    chords :from => :chorus
  end

  part :outro_ending do
    bass :from => :intro
    chords :from => :chorus
  end
end

song.play

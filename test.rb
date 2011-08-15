require 'rubygems'
require 'niki'

song = Niki::Song.new :tempo => 127 do

  channel :bass, 1
  channel :drums, 10
  channel :chords, 2
  channel :melodies, 3

  # Sintaxi per les parts:
  #
  #   part :nom_de_la_part do
  #     . . .
  #   end
  #
  # Per repetir una part:
  #
  #   repeat :nom_de_la_part
  #
  # IMPORTANT: Els acords han d'estar sempre DINS d'una part.
  # Sintaxi pels acords:
  #
  #   chord C4MAJ
  #     Toca un acord de Do Major,
  #     duració per defecte: rodona (tot el compas)
  #
  #   chord C4MAJ, 4
  #     Toca un acord de Do Major,
  #     duració: una negra. Les duracions son:
  #       1 = rodona
  #       2 = blanca
  #       4 = negra
  #       8 = corxera
  #     ...and so on.
  #
  #   chord C4MAJ, 2, :base => A4
  #     Toca un acord de Do Major,
  #     amb duració d'una blanca,
  #     amb una nota base de La.

  # part :intro do
  #   chord c2MAJ, 1
  #   chord f2MAJ(2), 1, :base => c2
  #   chord g2MAJ(3), 0.5, :base => c3
  # end

  # repeat :intro
  #
  # repeat :intro

  part :intro do
    # Drums
    2.times do
      drum [kick, hh], 8
      drum hh, 8
      drum [snare, hh], 8
      drum hh, 8

      drum [kick, hh], 8
      drum hh, 8
      drum [snare, hh], 8
      drum [kick, hh], 8

      drum hh, 16
      drum hh, 16
      drum hh, 16
      drum hh, 16
      drum [snare, hh], 8
      drum hh, 8

      drum [kick, hh], 8
      drum [kick, hh], 8
      drum [snare, hh], 8
      drum hh, 8
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

    # Chords
    chord a3MIN(2), 2, :base => f3
    chord a3MIN(2), 8, :base => f3
    chord a3MIN(2), 8, :base => f3
    chord a3MIN(2), 8, :base => f3
    chord c3MAJ, 4
    chord c3MAJ, 4
    chord c3MAJ, 8
    chord g3MAJ, 2
    chord a3MIN
    chord c3MAJ, 4
    chord c3MAJ, 4
    chord g3MAJ, 8
    chord g3MAJ, 8
    chord g3MAJ, 8, :base => f4
    chord g3MAJ, 8, :base => e4

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

  repeat :intro
  repeat :intro
  repeat :intro
end

song.play

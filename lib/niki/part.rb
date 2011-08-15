module Niki
  class Part
    attr_reader :name, :chords, :drums, :basses, :melodies

    include Niki::Chords

    def initialize(name, song, &block)
      @name = name
      @song = song
      @drum_notes = @song.drum_notes
      @chords = []
      @drums = []
      @basses = []
      @melodies = []
      self.instance_eval(&block)
    end

    def chord note, duration = 1, options = {}
      if note.is_a?(Hash) && note[:from]
        copy_from_part(note[:from], :chords)
        return
      end

      note.push options[:base]
      @chords << [note, calculate_duration(duration)]
    end

    def drum note, duration = 1, options = {}
      if note.is_a?(Hash) && note[:from]
        copy_from_part(note[:from], :drums)
        return
      end

      drum_note = [note].flatten.map do |n|
        @drum_notes[n]
      end
      @drums << [drum_note, calculate_duration(duration)]
    end

    def bass note = nil, duration = 1, options = {}
      if note.is_a?(Hash) && note[:from]
        copy_from_part(note[:from], :basses)
        return
      end

      @basses << [[note], calculate_duration(duration)]
    end

    def melody note = nil, duration = 1, options = {}
      if note.is_a?(Hash) && note[:from]
        copy_from_part(note[:from], :melodies)
        return
      end

      @melodies << [[note], calculate_duration(duration)]
    end

    private

    def calculate_duration(duration)
      1.to_f / ((@song.tempo.to_f/120) * duration/2)
    end

    def copy_from_part(name, type)
      part = @song.get_part(name)
      instance_variable_set(:"@#{type}", part.send(type))
    end
  end
end

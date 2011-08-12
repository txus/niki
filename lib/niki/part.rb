module Niki
  class Part
    attr_reader :name, :chords, :drums, :basses, :melodies

    include Niki::Chords

    def initialize(name, song, &block)
      @name = name
      @song = song
      @chords = []
      @drums = []
      @basses = []
      @melodies = []
      self.instance_eval(&block)
    end

    def chord note, duration = 1, options = {}
      note.push options[:base]
      @chords << [note, calculate_duration(duration)]
    end

    def drum note, duration = 1, options = {}
      @drums << [note, calculate_duration(duration)]
    end

    def bass note, duration = 1, options = {}
      @basses << [[note], calculate_duration(duration)]
    end

    def melody note, duration = 1, options = {}
      @melodies << [[note], calculate_duration(duration)]
    end

    private

    def calculate_duration(duration)
      1.to_f / ((@song.tempo.to_f/120) * duration/2)
    end
  end
end

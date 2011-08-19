module Niki
  class Riff
    attr_reader :name, :notes

    include Niki::Chords

    def initialize(name, song, &block)
      @name = name
      @song = song

      @notes = []
      self.instance_exec(&block)
    end

    def note(*args)
      @notes << args
    end
  end
end

module Niki
  class Part
    attr_reader :name, :notes

    include Niki::Chords

    def initialize(name, song, &block)
      @name = name
      @song = song
      @notes = {}
      self.instance_eval(&block)
    end

    def for_instrument(instrument_name)
      @notes[instrument_name] || []
    end

    def riff(name, instrument_name, &blk)
      riff = @song.get_riff(name)
      riff.notes.each do |args|
        send(instrument_name, *args)
      end
    end

    private

    def copy_from_part(name, type)
      part = @song.get_part(name)
      @notes[type] = part.for_instrument(type)
    end

    def register_note(instrument_name, note, duration, velocity)
      @notes[instrument_name] ||= []
      @notes[instrument_name] << [note, calculate_duration(duration), velocity]
    end

    def calculate_duration(duration)
      1.to_f / ((@song.tempo.to_f/120) * duration/2)
    end
  end
end

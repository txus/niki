module Niki
  class Song
    attr_reader :tempo, :drum_notes

    include Niki::Chords

    def initialize(options, &block)
      @clock = Archaeopteryx::Midi::Clock.new(options[:tempo] || 127)

      @midi = Archaeopteryx::Midi::PracticalRubyProjects::LiveMIDI.new(:clock => @clock )

      @parts = []
      @channel = {}
      @drum_notes = {}
      @tempo = options[:tempo]
      self.instance_eval &block
    end

    def channel(instrument, number)
      @channel[instrument] = number - 1
    end

    def part(name, &block)
      raise "#{name} is already defined!" if has_part?(name)
      @parts << Part.new(name, self, &block)
    end

    def configure(instrument, &block)
      case instrument
      when :drums
        block.call @drum_notes
      end
    end

    def repeat(name, options = {})
      (options[:times] || 1).times do
        @parts << get_part(name)
      end
    end

    def play
      @parts.each do |part|
        [:basses, :chords, :melodies, :drums].map do |instrument_name|
          Thread.start do
            play_part(part, instrument_name)
          end
        end.map { |thread| thread.join }
      end
    end

    def play_part(part, instrument_name)
      part.send(instrument_name).each do |instrument|
        notes = [instrument.first].flatten.compact.map do |note|
          Archaeopteryx::Midi::Note.create(
            :channel => @channel[instrument_name],
            :number => note,
            :duration => instrument.last,
            :velocity => 127)
        end
        notes.each do |note|
          @midi.note_on(note)
        end
        sleep(instrument.last)
        notes.each do |note|
          @midi.note_off(note)
        end
      end
    end

    def get_part(name)
      @parts.detect {|p| p.name == name }
    end

    private

    def has_part?(name)
      !!@parts.map(&:name).detect {|part_name| part_name == name }
    end

  end
end

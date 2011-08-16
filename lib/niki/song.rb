require 'unimidi'

module Niki
  class Song
    attr_reader :tempo

    include Niki::Chords

    NOTE_ON  = 0x90
    NOTE_OFF = 0x80

    def initialize(options, &block)
      @midi = UniMIDI::Output.first
      @parts = []
      @instruments = []
      @channel = {}
      @tempo = options[:tempo]
      self.instance_eval &block
    end

    def part(name, &block)
      raise "#{name} is already defined!" if has_part?(name)
      @parts << Part.new(name, self, &block)
    end

    def instrument(name, &block)
      @instruments << Instrument.new(name, self, &block)
    end

    def repeat(name, options = {})
      (options[:times] || 1).times do
        @parts << get_part(name)
      end
    end

    def play
      @parts.each do |part|
        @instruments.map do |instrument|
          Thread.start do
            play_part(part, instrument)
          end
        end.map { |thread| thread.join }

        @instruments.each do |instrument|
          reset(instrument)
        end
      end
    end

    def play_part(part, instrument)
      return if part.for_instrument(instrument.name).length.zero?
      channel = instrument.channel_number

      @midi.open do |out|
        part.for_instrument(instrument.name).each do |notes, duration|
          notes = [notes].flatten.compact
          notes.each do |note|
            out.puts NOTE_ON + channel, note, 100
          end
          sleep(duration)
          notes.each do |note|
            out.puts NOTE_OFF + channel, note, 100
          end
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

    def reset(instrument)
      @midi.open do |out|
        # Reset all notes
        95.times do |i|
          out.puts NOTE_OFF + instrument.channel_number, i, 100
        end
      end
    end

  end
end

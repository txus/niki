module Niki
  class Instrument
    attr_reader :name, :channel_number

    include Niki::Chords

    def initialize(name, song, &block)
      @name = name
      @song = song
      @channel_number = nil
      @macros = {}

      self.instance_exec(&block)

      Part.send :include, self.to_module
    end

    def channel(number)
      @channel_number = number - 1
    end

    def note
      @macros
    end

    def to_module
      instrument_name = @name
      macros = @macros

      Module.new do
        define_method instrument_name do |*args|
          note     = args.shift
          duration = args.shift || 1
          options  = args.shift || {}

          velocity = options[:v] || 100

          if note.is_a?(Hash) && note[:from]
            copy_from_part(note[:from], instrument_name)
            return
          end

          note = [note].flatten.map do |n|
            if note.is_a?(Fixnum)
              note
            else
              # Try to fetch the note from the symbol
              macros[note]
            end
          end

          note.push options[:base]

          register_note(instrument_name, note, duration, velocity)
        end
      end
    end
  end
end

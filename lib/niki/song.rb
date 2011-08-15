module Niki
  class Song
    attr_reader :tempo

    def initialize(options, &block)
      @clock = Archaeopteryx::Midi::Clock.new(options[:tempo] || 127)

      @midi = Archaeopteryx::Midi::PracticalRubyProjects::LiveMIDI.new(:clock => @clock )

      @parts = []
      @channel = {}
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

    def repeat(name, options = {})
      (options[:times] || 1).times do
        @parts << get_part(name)
      end
    end

    def play
      [
        Thread.start { play_instrument(:bass) },
        Thread.start { play_instrument(:chords) },
        Thread.start { play_instrument(:melodies) },
        Thread.start { play_instrument(:drums) },
      ].map { |t| t.join }
    end

    def play_instrument(instrument = :chords)
      @parts.each do |part|
        case instrument
        when :drums
          part.drums.each do |drum|
            notes = [drum.first].flatten.map do |note|
              Archaeopteryx::Midi::Note.create(:channel => @channel[:drums],
                       :number => note,
                       :duration => drum.last,
                       :velocity => 127)
            end
            notes.each do |note|
              @midi.note_on(note)
            end
            sleep(drum.last)
            notes.each do |note|
              @midi.note_off(note)
            end
          end

        when :bass
          part.basses.each do |bass|
            notes = bass.first.map do |note|
              Archaeopteryx::Midi::Note.create(:channel => @channel[:bass],
                       :number => note,
                       :duration => bass.last,
                       :velocity => 127)
            end
            notes.each do |note|
              @midi.note_on(note)
            end
            sleep(bass.last)
            notes.each do |note|
              @midi.note_off(note)
            end
          end

        when :melodies
          part.melodies.each do |melody|
            notes = melody.first.map do |note|
              Archaeopteryx::Midi::Note.create(:channel => @channel[:melodies],
                       :number => note,
                       :duration => melody.last,
                       :velocity => 127)
            end
            notes.each do |note|
              @midi.note_on(note)
            end
            sleep(melody.last)
            notes.each do |note|
              @midi.note_off(note)
            end
          end

        when :chords
          part.chords.each do |chord|
            notes = chord.first.compact.map do |note|
              Archaeopteryx::Midi::Note.create(:channel => @channel[:chords],
                       :number => note,
                       :duration => chord.last,
                       :velocity => 127)
            end
            notes.each do |note|
              @midi.note_on(note)
            end
            sleep(chord.last)
            notes.each do |note|
              @midi.note_off(note)
            end
          end
        end
      end
    end

    private

    def has_part?(name)
      !!@parts.map(&:name).detect {|part_name| part_name == name }
    end

    def get_part(name)
      @parts.detect {|p| p.name == name }
    end

  end
end

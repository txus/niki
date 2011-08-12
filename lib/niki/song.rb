require 'arch/archaeopteryx'
require 'pp'

module Niki
  class Song
    attr_reader :tempo

    def initialize(options, &block)
      @clock = Clock.new(options[:tempo] || 127)

      @midi = PracticalRubyProjects::LiveMIDI.new(:clock => @clock )

      @parts = []
      @tempo = options[:tempo]
      self.instance_eval &block
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

    def play(type = :chords)
      @parts.each do |part|
        case type
        when :drums
          part.drums.each do |drum|
            notes = [drum.first].flatten.map do |note|
              Note.create(:channel => 11,
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
              Note.create(:channel => 3,
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
              Note.create(:channel => 5,
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
              Note.create(:channel => 1,
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

module Niki
  module Chords

    (1..5).to_a.each do |octave|

      %w(c d e f g a b).each_with_index do |c, idx|
        rest = 0
        if idx > 2
          rest = 1
        end
        base = 24 + (12 * octave) + (idx * 2) - rest

        define_method("#{c}#{octave}") do
          base
        end

        define_method("#{c}#{octave}MAJ") do |*args|
          inversion = args.first || 1
          case inversion
          when 1
            [base, base + 4, base + 7]
          when 2
            [base + 4, base + 7, base + 12]
          when 3
            [base + 7, base + 12, base + 16]
          end
        end

        define_method("#{c}#{octave}MIN") do |*args|
          inversion = args.first || 1
          case inversion
          when 1
            [base, base + 2, base + 7]
          when 2
            [base + 3, base + 7, base + 12]
          when 3
            [base + 7, base + 12, base + 15]
          end
        end
      end

    end

    def kick
      c1
    end

    def snare
      d1
    end

    def hh
      e1
    end

    def ohh
      f1
    end

  end
end

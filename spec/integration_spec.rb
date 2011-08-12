require 'spec_helper'
require 'unimidi'

describe Niki do
  it 'rocks' do
    notes = [36, 40, 43, 48, 52, 55, 60, 64, 67] # C E G arpeggios
    duration = 0.1
    output = UniMIDI::Output.first
    puts UniMIDI::Output.all.inspect
    output.open do |output|

      notes.each do |note|

        output.puts(0x90, note, 100) # note on message
        sleep(duration)              # wait
        output.puts(0x80, note, 100) # note off message

      end

    end
  end
end
# describe Niki do
#   it 'rocks' do
#     Niki::Song.new :tempo => 127 do
#
#       part :intro do
#         chord A4MIN, 1, :base => F2
#         chord C4MAJ, 2
#         chord G4MAJ, 2
#         chord A4MIN
#         chord C4MAJ, 2
#         chord G4MAJ, 2
#       end
#
#       part :estrofa do
#         chord F4MAJII, 1, :base => F2
#         4.times do
#           chord G4MAJ, 16, :base => E2
#         end
#       end
#
#       repeat :estrofa
#
#       part :outro do
#         chord F4MAJII, 1
#       end
#
#     end
#
#   end
# end

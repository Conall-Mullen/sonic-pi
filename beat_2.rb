use_random_seed beat.to_i

sequenceLength = 16
numOfLoops = sequenceLength * 4
sequence = Array.new(sequenceLength) {rand_i(2)}

in_thread do
  live_loop :kicks do
    numOfLoops.times do
      if one_in(2)
        sample :drum_cymbal_closed, amp: rand(0.25), decay: 0.1, decay_level: 0, sustain_level: 0, rate: rrand(0.98,1)
      else
        sample :drum_cymbal_open, amp: rand(0.25), decay: 0.1, decay_level: 0, sustain_level: 0, rate: rrand(0.98,1)
      end
      if sequence.tick == 1
        sample :drum_heavy_kick, amp: rand(1), decay: 0.1, decay_level: 0, sustain_level: 0
      else
        if one_in(2)
          sample :drum_snare_soft, amp: rand(1), decay: 0.1, decay_level: 0, sustain_level: 0, rate: rrand(0.97,1)
        else
          sample :elec_hi_snare, amp: rand(1), decay: 0.25, decay_level: 0, sustain_level: 0, rate: rrand(0.97,1)
        end
      end
      sleep 0.25
    end
    newSequence = Array.new(sequenceLength) {rand_i(2)}
    sequence = newSequence
  end
end




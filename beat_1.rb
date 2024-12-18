use_random_seed beat.to_i

sequenceLength = 10
sequence = Array.new(sequenceLength) { rand_i(0...sequenceLength - 1) }
print sequence
sequenceIndex = (range 0, sequenceLength,1).to_a

in_thread do
  
  mySample = :loop_mehackit2
  repeats = sequenceLength * 4
  
  with_fx :echo, mix: 0.0 do |delay|
    
    live_loop :beat_slicer do
      
      repeats.times do
        rate =  (sequence.tick.to_f  + 1) / sequenceLength
        slices = chopSample sequence.length, sequence.tick
        sample mySample, start: slices[0], finish: slices[1],beat_stretch: 4, decay: 0.1, decay_level: 0,rate: rate, amp: 0.5
        control delay, phase: rate/4  * rrand(0.1,1), phase_slide: 1
        sleep sample_duration mySample, start: slices[0], finish: slices[1],beat_stretch: 4
      end
      
      newSequence = sequence.dup
      newSequence[picker sequenceIndex] = rand_i(sequenceLength)
      sequence = newSequence
      
    end
  end
end

live_loop :kicker do
  sample :drum_heavy_kick
  sleep 1
  sample :drum_heavy_kick
  sample :perc_impact2, decay: 0.1,decay_level: 0
  sleep 1
end

define :chopSample do |length,index|
  num_of_slices = length
  slice_index = index
  slice_size = 1 / num_of_slices.to_f
  slice_start = slice_index * slice_size
  slice_finish = slice_start + slice_size
  return slice_start, slice_finish
end

define :picker do |array|
  shuffled = []
  if shuffled.empty?
    shuffled = array.shuffle
  end
  return shuffled.pop
end






























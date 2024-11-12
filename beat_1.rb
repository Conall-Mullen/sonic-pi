use_random_seed beat.to_i

sequenceLength = 16
set :sequence, Array.new(sequenceLength) { rand_i(0...sequenceLength - 1) }

in_thread do
  mySample = :loop_industrial
  sequence = get[:sequence]
  repeats = sequenceLength * rrand(1,4)
  live_loop :beat_slicer do
    repeats.times do
      slices = chopSample sequence.length, sequence.tick
      sample mySample, start: slices[0], finish: slices[1],beat_stretch: 4
      sleep sample_duration mySample, start: slices[0], finish: slices[1],beat_stretch: 4
    end
    sequence = sequence.shuffle
    print sequence
  end
end

define :chopSample do |length,index|
  num_of_slices = length
  slice_index = index
  slice_size = 1 / num_of_slices.to_f
  slice_start = slice_index * slice_size
  slice_finish = slice_start + slice_size
  return slice_start, slice_finish
end


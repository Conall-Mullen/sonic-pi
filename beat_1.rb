beats = [1,2,3,0,2,3,0,1]

in_thread do
  live_loop :beat_slicer do
    mySample = :loop_amen
    slice_index = beats.tick
    slice_size = 1 / beats.length.to_f
    slice_start = slice_index * slice_size
    slice_finish = slice_start + slice_size
    sample mySample, start: slice_start, finish: slice_finish,beat_stretch: 4, amp: rand(0.5), pan: rrand(-1,1)
    sleep sample_duration mySample, start: slice_start, finish: slice_finish,beat_stretch: 4
  end
end

in_thread do
  
  live_loop :sampler do
    sync :beat_slicer
    samps = "/Users/conallomaolain/Documents/Ableton/Sample Packs/Sample Pack 5"
    sample samps , beats.tick, decay: 0.1,decay_level: 0, release: 0
    sleep 1 / beats.length.to_f
  end
end

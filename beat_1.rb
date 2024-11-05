live_loop :rec do
  steps = sync "/osc:127.0.0.1:63923/steps"
  set :steps, steps
end

in_thread do
  live_loop :beat_slicer do
    mySample = :guit_em9
    steps = get[:steps]
    slice_index = steps.tick
    slice_size = 1 / steps.length.to_f
    slice_start = slice_index * slice_size
    slice_finish = slice_start + slice_size
    sample mySample, start: slice_start, finish: slice_finish,beat_stretch: 4, amp: rrand(0.1,0.5),pan: rrand(-1,1),decay: 0.1, decay_level: 0
    sleep sample_duration mySample, start: slice_start, finish: slice_finish,beat_stretch: 4
  end
end

in_thread do
  live_loop :sampler do
    steps = get[:steps]
    phase_offset = rand(16)
    folder_index = steps.tick.to_i + phase_offset.to_i
    sync :beat_slicer
    samps = "/Users/conallomaolain/Documents/Ableton/Sample Packs/Sample Pack 2"
    sample samps , folder_index, decay: 0.1,decay_level: 0, release: 0, amp: 0
    sleep 1 / steps.length.to_f
  end
end

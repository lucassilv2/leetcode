def max_performance(n, speed, efficiency, k)
  better = -1
  mutex = Mutex.new
  threads = (1..k).map do |combination|
    puts "Combination #{combination}"
    Thread.new do
      new = performance(n, speed, efficiency, combination)
      mutex.synchronize do
        better = new if new > better
      end
    end
  end
  threads.each(&:join)
  return better
end

def performance(n, speed,efficiency,k)
  best_performance = -1
  Array.new(n){|i| i}.permutation(k).to_a.each do |positions|
    speed_arr,efficiency_arr = [],[]
    positions.each do |position|
      speed_arr << speed[position]
      efficiency_arr << efficiency[position]
    end
    new = speed_arr.sum * efficiency_arr.min

    best_performance = new if new > best_performance
    puts "Best performance #{best_performance}"
  end
  return best_performance
end

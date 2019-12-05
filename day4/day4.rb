candidate1 = []
candidate2 = []

for i in (158126..624574)
	input = i.to_s.split("").map(&:to_i)
	filter1 = input.map.with_index do |v,index|
		if (index != (input.size-1) )
			input[index+1] - v
		else
			1
		end
	end
	if ((filter1.select{ |v| v < 0 }.size == 0) && (filter1.select{ |v| v == 0 }.size >= 1)) # check criteria
		candidate1.push(i)
	end
end

candidate1.size  # PART 1 answer

for i in candidate1
	input = i.to_s.split("").map(&:to_i)
  numCount = input.inject(Hash.new(0)) { |count, num| count[num] += 1; count } # check additional criteria
	if (numCount.select{ |k, v| v >= 2 }.select{ |k,v| v == 2 }.size >= 1)
		candidate2 += [i]
	end
end

candidate2.size  # PART 2 answer

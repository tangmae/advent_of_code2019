# Day 1

def findFuel(mass, collection)
	if (mass/3.0).floor - 2 <= 0
		collection
	else
		res = (mass/3.0).floor - 2
		collection += [res]
		findFuel(res, collection)
	end
end

input = ""

massFuel = input.split("\n").map { |req| (req.to_i/3) - 2} # return Array of fuel required in each

totalFuel = massFuel.reduce(:+) # part 1 answer

recursiveFuel = massFuel.map { |fuel| findFuel(fuel,[]) } # return consequent fuel required for fuel we just got on above

(recursiveFuel.flatten + massFuel).reduce(:+) # part 2 answer

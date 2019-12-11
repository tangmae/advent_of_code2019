input=File.read("/Users/suppassara.k/projects/advent_of_code2019/day6/day6-input.txt")
# input = "COM)B
# B)C
# C)D
# D)E
# E)F
# B)G
# G)H
# D)I
# E)J
# J)K
# K)L
# K)YOU
# I)SAN"

orbitCol = {}


def countOrbit(mem, orbit, count)
	child = orbit[mem]
	puts "see #{mem} child is #{child}"
	if child.nil?
		return count
	else
		count += 1
		countOrbit(child[0], orbit, count)
	end
end

def travelOrbit(mem, orbit, route)
	child = orbit[mem]
	puts "see #{mem} child is #{child} route #{route}"
	if child.nil?
		return route
	else
		route += [child[0]]
		travelOrbit(child[0], orbit, route)
	end
end


input.split("\n").each do |orbit|
	orbitAssign = orbit.split(")")
	center = orbitAssign[0]
	mem = orbitAssign[1]
	# puts "#{center} ) #{mem}"
	if orbitCol[mem].nil?
		orbitCol[mem] = []
	end
	# puts "before #{center} => #{orbitCol[center].to_s}"
	# orbitCol[mem].push(center)
	orbitCol[mem].push(center)
	# puts "after #{center} => #{orbitCol[center].to_s}"
	# puts "------"
	# puts "#{orbitCol.to_s}"
end

total = 0
orbitCol.keys.each do |k|
	total += countOrbit(k, orbitCol, 0)
end

youRoute = travelOrbit("YOU",orbitCol,[])
sanRoute = travelOrbit("SAN",orbitCol,[])

meet = (youRoute - (youRoute & sanRoute)).size + (sanRoute - (youRoute & sanRoute)).size




### ABLE TO SOLVE BY STACK 

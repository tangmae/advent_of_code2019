def createMap(input)
	maps = {}
	asteriods = []
	row = 0
	input.split("\n").each do |line|
		col = 0
		line.split("").each do |value|
			maps[[col,row]] = value
			if (value == "#")
				asteriods += [[col,row]]
			end
			col += 1
		end
		row += 1
	end
	asteriods
end

def checkStations(asteriods)
	collection = asteriods.map do |st|
	 	countAst = Hash.new(nil)
		asteriods.each do |dest|
			next if st == dest
			angle = getAngle(st,dest)

			old = countAst[angle]
			if old.nil?
				countAst[angle] = dest
			elsif getDist(old,st) > getDist(dest,st)
				countAst[angle] = dest
			end
		end
		count = countAst.keys.size
		# puts "#{st.to_s} => #{count}"
		# puts "#{st.to_s} => #{count} => #{countAst.to_s}"
		# [count+1,st.to_s]
		[st,countAst]
	end

	collection.to_h
end

def getDist(start,dest)
	Math.sqrt((start[0] - dest[0])**2 + (start[1] - dest[1])**2)
end

def getActualRoute(start,route)
	actual = [start]
	route.each do |step|
		st = actual[-1]
		actual += [[st[0] + step[0], st[1] + step[1]]]
	end
	actual
end

def getAngle(start,dest)
	if (start[1] - dest[1]) == 0 && (start[0] - dest[0]) > 0
		return "inf"
	elsif (start[1] - dest[1]) == 0 && (start[0] - dest[0]) < 0
		return "-inf"
	end

	if (start[0] - dest[0]) == 0 && (start[1] - dest[1]) > 0
		return "0"
	elsif (start[0] - dest[0]) == 0 && (start[1] - dest[1]) < 0
		return "-0"
	end
	# puts "#{start[0] - dest[0]} / #{start[1] - dest[1]}"
	ratio = ((start[0] - dest[0]).to_f/(start[1] - dest[1]).to_f)
	directionX = start[0] <= dest[0] ? "+" : "-"
	directionY = start[1] <= dest[1] ? "+" : "-"
	return ratio, directionX, directionY
end

def printMap(asteriods, station, detected, bomb = nil)
	col = asteriods.map{ |a| a[0] }.max
	row = asteriods.map{ |a| a[1] }.max
	for i in 0..row do
		line = ""
		for j in 0..col do
			out = ". "
			if asteriods.include?([j,i])
				out = "O "
			end
			if [j,i] == station
				out = "X "
			elsif detected.include?([j,i])
				out = "0 "
			end
			if !bomb.nil? && [j,i] == bomb[1]
				out = "#{bomb[0]} "
			end
			line += out
		end
		puts line
	end
end

input = ".###.#...#.#.##.#.####..
.#....#####...#.######..
#.#.###.###.#.....#.####
##.###..##..####.#.####.
###########.#######.##.#
##########.#########.##.
.#.##.########.##...###.
###.#.##.#####.#.###.###
##.#####.##..###.#.##.#.
.#.#.#####.####.#..#####
.###.#####.#..#..##.#.##
########.##.#...########
.####..##..#.###.###.#.#
....######.##.#.######.#
###.####.######.#....###
############.#.#.##.####
##...##..####.####.#..##
.###.#########.###..#.##
#.##.#.#...##...#####..#
##.#..###############.##
##.###.#####.##.######..
##.#####.#.#.##..#######
...#######.######...####
#....#.#.#.####.#.#.#.##"

# input = ".#..##.###...#######
# ##.############..##.
# .#.######.########.#
# .###.#######.####.#.
# #####.##.#.##.###.##
# ..#####..#.#########
# ####################
# #.####....###.#.#.##
# ##.#################
# #####.##.###..####..
# ..######..##.#######
# ####.##.####...##..#
# .#####..#.######.###
# ##...#.##########...
# #.##########.#######
# .####.#.###.###.#.##
# ....##.##.###..#####
# .#.#.###########.###
# #.#.#.#####.####.###
# ###.##.####.##.#..##"


# . 0 O 0 . O . . . 0 . O . 0 O . 0 . O 0 O 0 . .
# . 0 . . . . 0 0 0 0 0 . . . 0 . 0 0 0 0 O 0 . .
# 0 . O . O 0 0 . O 0 0 . O . . . . . 0 . O 0 0 0
# O 0 . 0 0 O . . O 0 . . 0 0 O O . O . 0 O 0 0 .
# O 0 0 0 O 0 O 0 0 0 0 . O O O 0 O 0 O . O 0 . 0
# 0 0 0 0 0 0 0 O 0 0 . 0 0 0 0 0 0 0 0 0 . 0 0 .
# . 0 . 0 O . O 0 O 0 O O O 0 . 0 O . . . O 0 O .
# 0 0 0 . 0 . 0 0 . O 0 0 0 0 . 0 . 0 0 0 . 0 0 0
# O 0 . 0 O O 0 0 . 0 O . . 0 O O . 0 . 0 O . O .
# . 0 . 0 . O 0 0 0 0 . O 0 0 O . 0 . . 0 O 0 0 O
# . 0 O 0 . 0 O 0 O 0 . 0 . . 0 . . 0 0 . O . O 0
# 0 0 0 0 0 0 O 0 . 0 0 . 0 . . . 0 0 0 0 O 0 0 0
# . 0 O 0 0 . . 0 O . . O . 0 O 0 . O 0 0 . 0 . O
# . . . . 0 O 0 0 0 0 . 0 0 . 0 . 0 0 0 0 O 0 . 0
# O 0 O . O 0 0 0 . 0 O 0 O 0 O . O . . . . 0 0 0
# 0 0 0 0 0 O 0 0 O 0 0 O . 0 . 0 . 0 0 . O 0 0 O
# O 0 . . . 0 O . . 0 O 0 O . O 0 0 0 . 0 . . 0 0
# . 0 0 0 . 0 0 0 0 0 0 0 0 0 . 0 0 0 . . 0 . 0 0
# O . O O . O . O . . . O O . . . O O O 0 X . . 0
# 0 0 . 0 . . 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 . 0 0
# O 0 . 0 O 0 . 0 O 0 O 0 . 0 O . O 0 O 0 O 0 . .
# 0 0 . 0 0 O 0 0 . 0 . O . 0 O . . O 0 0 O 0 0 0
# . . . 0 O 0 O 0 O 0 . 0 O 0 O 0 O . . . O 0 O 0
# O . . . . O . 0 . 0 . 0 0 0 0 . 0 . 0 . O . 0 0

asteriods = createMap(input)
collection = checkStations(asteriods)
sortCol = collection.sort_by { |k,v| v.size }.reverse
station = sortCol.first[0]
# station = [11, 13]
puts "#{station} , count :  #{collection[station].map{ |k,v| v }.size}"

printMap(asteriods, station, collection[station].map{ |k,v| v })

######################## PART 2 ########################

# puts collection[station].each{ |k, det| puts k.to_s }

remainAsteriod = asteriods
queque = []
while remainAsteriod.size > 1
	collection = checkStations(remainAsteriod)

	aboveQ = collection[station].select{ |k, det| k == "0" }.map{ |k,v| v }
	q1 = collection[station].select{ |k, det| k[1] == "+" && k[2] == "+" }.sort_by{|k,v| k[0]}.map{ |k,v| v }.reverse
	rightQ = collection[station].select{ |k, det| k == "inf" }.map{ |k,v| v }
	q2 = collection[station].select{ |k, det| k[1] == "+" && k[2] == "-" }.sort_by{|k,v| k[0]}.map{ |k,v| v }.reverse
	belowQ = collection[station].select{ |k, det| k == "-0" }.map{ |k,v| v }
	q3 = collection[station].select{ |k, det| k[1] == "-" && k[2] == "-" }.sort_by{|k,v| k[0]}.map{ |k,v| v }.reverse
	leftQ = collection[station].select{ |k, det| k == "-inf" }.map{ |k,v| v }
	q4 = collection[station].select{ |k, det| k[1] == "-" && k[2] == "+" }.sort_by{|k,v| k[0]}.map{ |k,v| v }.reverse

	queque += aboveQ+q2+leftQ+q1+belowQ+q4+rightQ+q3
	remainAsteriod = remainAsteriod - queque
	# printMap(remainAsteriod, station, [])

end

puts queque[199][0] * 100 + queque[199][1]


# collection[station].select{ |k, det| k == "0" }.each { |k,v| puts "#{k} = #{v.to_s}" }

# aboveQ = collection[station].select{ |k, det| k == "0" }.map{ |k,v| v }
# Q1 = collection[station].select{ |k, det| k[1] == "+" && k[2] == "+" }.sort_by{|k,v| k[0]}.map{ |k,v| v }.reverse
# rightQ = collection[station].select{ |k, det| k == "inf" }.map{ |k,v| v }
# Q2 = collection[station].select{ |k, det| k[1] == "+" && k[2] == "-" }.sort_by{|k,v| k[0]}.map{ |k,v| v }.reverse
# belowQ = collection[station].select{ |k, det| k == "-0" }.map{ |k,v| v }
# Q3 = collection[station].select{ |k, det| k[1] == "-" && k[2] == "-" }.sort_by{|k,v| k[0]}.map{ |k,v| v }.reverse
# leftQ = collection[station].select{ |k, det| k == "-inf" }.map{ |k,v| v }
# Q4 = collection[station].select{ |k, det| k[1] == "-" && k[2] == "+" }.sort_by{|k,v| k[0]}.map{ |k,v| v }.reverse
#
# count = 1
#
# for qQueqe in (aboveQ+Q2+leftQ+Q1+belowQ+Q4+rightQ+Q3) do
# 	printMap(asteriods, station, collection[station].map{ |k,v| v },[count,b])
# 	count += 1
# 	puts "==================="
# end

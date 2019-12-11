input = "3,8,1001,8,10,8,105,1,0,0,21,38,59,84,93,110,191,272,353,434,99999,3,9,101,5,9,9,1002,9,5,9,101,5,9,9,4,9,99,3,9,1001,9,3,9,1002,9,2,9,101,4,9,9,1002,9,4,9,4,9,99,3,9,102,5,9,9,1001,9,4,9,1002,9,2,9,1001,9,5,9,102,4,9,9,4,9,99,3,9,1002,9,2,9,4,9,99,3,9,1002,9,5,9,101,4,9,9,102,2,9,9,4,9,99,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,99,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,99,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,99,3,9,1001,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,99,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,99"

def getOpcodeParamMode(start, instruction)
	value = instruction[start]
	puts "instruction[#{start}] = #{value}"
	if value < 99 # regular mode
		opcode = value
		params = getParams(opcode, start, instruction)
		modes = Array.new(params.size, 0)
	elsif value == 99
		opcode = value
		params = modes = []
	else # paramether mode
		# puts "param mode : #{value}"
		valueStr = value.to_s.reverse
		opcode = valueStr[0].to_i
		modes = valueStr[2..-1].split("").map(&:to_i)
		params = getParams(opcode, start, instruction)
		if (modes.size < params.size)
			modes = modes + Array.new(params.size - modes.size, 0)
			# puts "adjust modes"
		end
		# puts "moded => #{modes.to_s}"
	end
	return opcode, params, modes
end

def getParams(opcode, start, instruction) # return params
	if (opcode == 1 || opcode == 2 || opcode == 7 || opcode == 8)
		params = [instruction[start+1],instruction[start+2],instruction[start+3]]
	elsif (opcode == 3 || opcode == 4)
		params = [instruction[start+1]]
	elsif (opcode == 5 || opcode == 6)
		params = [instruction[start+1],instruction[start+2]]
	end
	return params
end

def paramMode(mode, param, instruction)
	if mode == 0
		puts "get value from #{param} => #{instruction[param]}"
		return instruction[param]
	elsif mode == 1
		puts "get value => #{param}"
		return param
	else
		puts "error unknown mode #{mode}"
	end
end


def processCommand(start, instruction, phaseSetting)
	puts "---------"
	opcode, params, modes = getOpcodeParamMode(start, instruction)
	# puts opcode
	puts "params => #{params.to_s}"
	puts "modes => #{modes.to_s}"
	case opcode
	when 1 # needs 3 params
		operant1 = paramMode(modes[0],params[0],instruction)
		operant2 = paramMode(modes[1],params[1],instruction)
		puts "instruction[#{params[2]}] = #{operant1} + #{operant2}"
		instruction[params[2]] = operant1 + operant2
		processCommand(start + 4, instruction, phaseSetting)
		# return start + 4
	when 2 # needs 3 params
		operant1 = paramMode(modes[0],params[0],instruction)
		operant2 = paramMode(modes[1],params[1],instruction)
		instruction[params[2]] = operant1 * operant2
		puts "instruction[#{params[2]}] = #{operant1} * #{operant2}"
		# return start + 4
		processCommand(start + 4, instruction, phaseSetting)
	when 3 # needs 1 params
		# puts "consume phase setting : #{phaseSetting.to_s} "
		instruction[params[0]] = phaseSetting.shift
		puts "consume phase setting instruction[#{params[0]}] : #{instruction[params[0]]} "
		processCommand(start + 2, instruction, phaseSetting)
		# return start + 2
	when 4 # needs 1 params
		outputValue = paramMode(modes[0],params[0],instruction)
		# output += [outputValue]
		puts "output : #{outputValue}"
		return outputValue
		# getOpcodeParamMode(start + 2, instruction)
		# return start + 2
	when 5 # needs 2 params
		judgeValue = paramMode(modes[0], params[0], instruction)
		jumpAddress = paramMode(modes[1], params[1], instruction)
		if (judgeValue != 0)
			puts "jump to position => #{instruction[jumpAddress]}"
			# return jumpAddress
			processCommand(jumpAddress, instruction, phaseSetting)
		end
		processCommand(start + 3, instruction, phaseSetting)
		# return start + 3
	when 6 # needs 2 params
		judgeValue = paramMode(modes[0], params[0], instruction)
		jumpAddress = paramMode(modes[1], params[1], instruction)
		if (judgeValue == 0)
			puts "jump to position => #{instruction[jumpAddress]}"
			return jumpAddress
		end
		processCommand(start + 3, instruction, phaseSetting)
		# return start + 3
	when 7 # needs 3 params
		operant1 = paramMode(modes[0],params[0],instruction)
		operant2 = paramMode(modes[1],params[1],instruction)
		outputAddress = params[2]
		if (operant1 < operant2)
			puts "input 1 at #{outputAddress}"
			instruction[outputAddress] = 1
		else
			puts "input 0 at #{outputAddress}"
			instruction[outputAddress] = 0
		end
		processCommand(start + 4, instruction, phaseSetting)
		# return start + 4
	when 8 # needs 3 params
		operant1 = paramMode(modes[0],params[0],instruction)
		operant2 = paramMode(modes[1],params[1],instruction)
		outputAddress = params[2]
		if (operant1 == operant2)
			puts "input 1 at #{outputAddress}"
			instruction[outputAddress] = 1
		else
			puts "input 0 at #{outputAddress}"
			instruction[outputAddress] = 0
		end
		processCommand(start + 4, instruction, phaseSetting)
		# return start + 4
	when 99
		puts " ==== END ==== "
	else
		puts "ERROR #{opcode} #{params.to_s} #{modes.to_s}"
		return -1
	end
end


# input="3,31,3,32,1002,32,10,32,1001,31,-2,31,1007,31,0,33,
# 1002,33,7,33,1,33,31,31,1,32,31,31,4,31,99,0,0,0"

instruction = input.split(",").map(&:to_i)


allOutput = []
(0..4).to_a.permutation.to_a.each do |phases|
	input = phases
	output = 0
	while input.size > 0
		input = [input[0]] + [output] + input[1..-1]
		puts "phase setting #{input.to_s}"
		output = processCommand(0, instruction , input)
		puts "==== get output #{output} ====="
	end
	allOutput.push(output)
	puts "==================="
end
puts allOutput.max

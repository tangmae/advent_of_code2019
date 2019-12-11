input = "3,225,1,225,6,6,1100,1,238,225,104,0,1102,91,92,225,1102,85,13,225,1,47,17,224,101,-176,224,224,4,224,1002,223,8,223,1001,224,7,224,1,223,224,223,1102,79,43,225,1102,91,79,225,1101,94,61,225,1002,99,42,224,1001,224,-1890,224,4,224,1002,223,8,223,1001,224,6,224,1,224,223,223,102,77,52,224,1001,224,-4697,224,4,224,102,8,223,223,1001,224,7,224,1,224,223,223,1101,45,47,225,1001,43,93,224,1001,224,-172,224,4,224,102,8,223,223,1001,224,1,224,1,224,223,223,1102,53,88,225,1101,64,75,225,2,14,129,224,101,-5888,224,224,4,224,102,8,223,223,101,6,224,224,1,223,224,223,101,60,126,224,101,-148,224,224,4,224,1002,223,8,223,1001,224,2,224,1,224,223,223,1102,82,56,224,1001,224,-4592,224,4,224,1002,223,8,223,101,4,224,224,1,224,223,223,1101,22,82,224,1001,224,-104,224,4,224,1002,223,8,223,101,4,224,224,1,223,224,223,4,223,99,0,0,0,677,0,0,0,0,0,0,0,0,0,0,0,1105,0,99999,1105,227,247,1105,1,99999,1005,227,99999,1005,0,256,1105,1,99999,1106,227,99999,1106,0,265,1105,1,99999,1006,0,99999,1006,227,274,1105,1,99999,1105,1,280,1105,1,99999,1,225,225,225,1101,294,0,0,105,1,0,1105,1,99999,1106,0,300,1105,1,99999,1,225,225,225,1101,314,0,0,106,0,0,1105,1,99999,8,226,677,224,102,2,223,223,1005,224,329,1001,223,1,223,1007,226,226,224,1002,223,2,223,1006,224,344,101,1,223,223,108,226,226,224,1002,223,2,223,1006,224,359,1001,223,1,223,107,226,677,224,102,2,223,223,1006,224,374,101,1,223,223,8,677,677,224,102,2,223,223,1006,224,389,1001,223,1,223,1008,226,677,224,1002,223,2,223,1006,224,404,101,1,223,223,7,677,677,224,1002,223,2,223,1005,224,419,101,1,223,223,1108,226,677,224,1002,223,2,223,1005,224,434,101,1,223,223,1108,226,226,224,102,2,223,223,1005,224,449,1001,223,1,223,107,226,226,224,102,2,223,223,1005,224,464,101,1,223,223,1007,677,677,224,102,2,223,223,1006,224,479,101,1,223,223,1007,226,677,224,102,2,223,223,1005,224,494,1001,223,1,223,1008,226,226,224,1002,223,2,223,1005,224,509,1001,223,1,223,1108,677,226,224,1002,223,2,223,1006,224,524,1001,223,1,223,108,677,677,224,1002,223,2,223,1005,224,539,101,1,223,223,108,226,677,224,1002,223,2,223,1005,224,554,101,1,223,223,1008,677,677,224,1002,223,2,223,1006,224,569,1001,223,1,223,1107,677,677,224,102,2,223,223,1005,224,584,1001,223,1,223,7,677,226,224,102,2,223,223,1005,224,599,1001,223,1,223,8,677,226,224,1002,223,2,223,1005,224,614,1001,223,1,223,7,226,677,224,1002,223,2,223,1006,224,629,101,1,223,223,1107,677,226,224,1002,223,2,223,1005,224,644,1001,223,1,223,1107,226,677,224,102,2,223,223,1006,224,659,1001,223,1,223,107,677,677,224,1002,223,2,223,1005,224,674,101,1,223,223,4,223,99,226"

def intepreteInst(start, instruction)
	if start.nil?
		puts "===== END ===="
		return
	end
	value = instruction[start]
	if value < 99 # regular mode
		opcode = value
		params = getParams(opcode, start, instruction)
		modes = Array.new(params.size, 0)
	elsif value == 99
		puts "====== END ======="
		return
	else # paramether mode
		puts "param mode : #{value}"
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
	nextIndex = processCommand(start, opcode, params, modes, instruction)
	puts "------"
	intepreteInst(nextIndex,instruction)
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
		return instruction[param]
	elsif mode == 1
		return param
	else
		puts "error unknown mode #{mode}"
	end
end


def processCommand(start, opcode, params, modes, instruction)
	puts opcode
	puts params.to_s
	puts modes.to_s
	case opcode
	when 1 # needs 3 params
		operant1 = paramMode(modes[0],params[0],instruction)
		operant2 = paramMode(modes[1],params[1],instruction)
		instruction[params[2]] = operant1 + operant2
		return start + 4
	when 2 # needs 3 params
		operant1 = paramMode(modes[0],params[0],instruction)
		operant2 = paramMode(modes[1],params[1],instruction)
		instruction[params[2]] = operant1 * operant2
		return start + 4
	when 3 # needs 1 params
		puts "please enter value : "
		instruction[params[0]] = gets.to_i
		return start + 2
	when 4 # needs 1 params
		puts "output : "
		puts paramMode(modes[0],params[0],instruction)
		return start + 2
	when 5 # needs 2 params
		judgeValue = paramMode(modes[0], params[0], instruction)
		jumpAddress = paramMode(modes[1], params[1], instruction)
		if (judgeValue != 0)
			# puts "jump to position => #{instruction[jumpAddress]}"
			return jumpAddress
		end
		return start + 3
	when 6 # needs 2 params
		judgeValue = paramMode(modes[0], params[0], instruction)
		jumpAddress = paramMode(modes[1], params[1], instruction)
		if (judgeValue == 0)
			# puts "jump to position => #{instruction[jumpAddress]}"
			return jumpAddress
		end
		return start + 3
	when 7 # needs 3 params
		operant1 = paramMode(modes[0],params[0],instruction)
		operant2 = paramMode(modes[1],params[1],instruction)
		outputAddress = params[2]
		if (operant1 < operant2)
			# puts "input 1 at #{outputAddress}"
			instruction[outputAddress] = 1
		else
			# puts "input 0 at #{outputAddress}"
			instruction[outputAddress] = 0
		end
		return start + 4
	when 8 # needs 3 params
		operant1 = paramMode(modes[0],params[0],instruction)
		operant2 = paramMode(modes[1],params[1],instruction)
		outputAddress = params[2]
		if (operant1 == operant2)
			# puts "input 1 at #{outputAddress}"
			instruction[outputAddress] = 1
		else
			# puts "input 0 at #{outputAddress}"
			instruction[outputAddress] = 0
		end
		return start + 4
	when 99
		puts " ==== END ==== "
		return -1
	else
		puts "ERROR #{opcode} #{params.to_s} #{modes.to_s}"
		return -1
	end
end


input="3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0"

instruction = input.split(",").map(&:to_i)

intepreteInst(0,instruction)

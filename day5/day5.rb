input = "3,225,1,225,6,6,1100,1,238,225,104,0,1102,91,92,225,1102,85,13,225,1,47,17,224,101,-176,224,224,4,224,1002,223,8,223,1001,224,7,224,1,223,224,223,1102,79,43,225,1102,91,79,225,1101,94,61,225,1002,99,42,224,1001,224,-1890,224,4,224,1002,223,8,223,1001,224,6,224,1,224,223,223,102,77,52,224,1001,224,-4697,224,4,224,102,8,223,223,1001,224,7,224,1,224,223,223,1101,45,47,225,1001,43,93,224,1001,224,-172,224,4,224,102,8,223,223,1001,224,1,224,1,224,223,223,1102,53,88,225,1101,64,75,225,2,14,129,224,101,-5888,224,224,4,224,102,8,223,223,101,6,224,224,1,223,224,223,101,60,126,224,101,-148,224,224,4,224,1002,223,8,223,1001,224,2,224,1,224,223,223,1102,82,56,224,1001,224,-4592,224,4,224,1002,223,8,223,101,4,224,224,1,224,223,223,1101,22,82,224,1001,224,-104,224,4,224,1002,223,8,223,101,4,224,224,1,223,224,223,4,223,99,0,0,0,677,0,0,0,0,0,0,0,0,0,0,0,1105,0,99999,1105,227,247,1105,1,99999,1005,227,99999,1005,0,256,1105,1,99999,1106,227,99999,1106,0,265,1105,1,99999,1006,0,99999,1006,227,274,1105,1,99999,1105,1,280,1105,1,99999,1,225,225,225,1101,294,0,0,105,1,0,1105,1,99999,1106,0,300,1105,1,99999,1,225,225,225,1101,314,0,0,106,0,0,1105,1,99999,8,226,677,224,102,2,223,223,1005,224,329,1001,223,1,223,1007,226,226,224,1002,223,2,223,1006,224,344,101,1,223,223,108,226,226,224,1002,223,2,223,1006,224,359,1001,223,1,223,107,226,677,224,102,2,223,223,1006,224,374,101,1,223,223,8,677,677,224,102,2,223,223,1006,224,389,1001,223,1,223,1008,226,677,224,1002,223,2,223,1006,224,404,101,1,223,223,7,677,677,224,1002,223,2,223,1005,224,419,101,1,223,223,1108,226,677,224,1002,223,2,223,1005,224,434,101,1,223,223,1108,226,226,224,102,2,223,223,1005,224,449,1001,223,1,223,107,226,226,224,102,2,223,223,1005,224,464,101,1,223,223,1007,677,677,224,102,2,223,223,1006,224,479,101,1,223,223,1007,226,677,224,102,2,223,223,1005,224,494,1001,223,1,223,1008,226,226,224,1002,223,2,223,1005,224,509,1001,223,1,223,1108,677,226,224,1002,223,2,223,1006,224,524,1001,223,1,223,108,677,677,224,1002,223,2,223,1005,224,539,101,1,223,223,108,226,677,224,1002,223,2,223,1005,224,554,101,1,223,223,1008,677,677,224,1002,223,2,223,1006,224,569,1001,223,1,223,1107,677,677,224,102,2,223,223,1005,224,584,1001,223,1,223,7,677,226,224,102,2,223,223,1005,224,599,1001,223,1,223,8,677,226,224,1002,223,2,223,1005,224,614,1001,223,1,223,7,226,677,224,1002,223,2,223,1006,224,629,101,1,223,223,1107,677,226,224,1002,223,2,223,1005,224,644,1001,223,1,223,1107,226,677,224,102,2,223,223,1006,224,659,1001,223,1,223,107,677,677,224,1002,223,2,223,1005,224,674,101,1,223,223,4,223,99,226"

def operateValue(opcode, oprant1, operant2)
	if opcode == 1
		puts "then #{oprant1} + #{operant2}"
		return oprant1 + operant2
	elsif opcode == 2
		puts "then #{oprant1} * #{operant2}"
		return oprant1 * operant2
	else
		puts "unknown opcode"
	end
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

def process(instruction, startIndex)
	opcode = instruction[startIndex]
	puts "------"
	puts "opcode #{opcode} at #{startIndex}"
	# puts instruction.to_s
	if opcode > 99
		actualOp = opcode.to_s[-1].to_i
		if actualOp <= 2
			modeOpr1 = opcode.to_s[-3].to_i
			modeOpr2 = opcode.to_s[-4].to_i
			resultAdd = instruction[startIndex + 3]
			param1 = instruction[startIndex+1]
			param2 = instruction[startIndex+2]
			puts "#{opcode}, #{param1}, #{param2}, #{resultAdd}"
			puts "    , #{modeOpr1}, #{modeOpr2}"
			operant1 = paramMode(modeOpr1,param1,instruction)
			operant2 = paramMode(modeOpr2,param2,instruction)
			instruction[resultAdd] = operateValue(actualOp,operant1,operant2)
			process(instruction, startIndex + 4)
		elsif actualOp == 3
			modeOpr = opcode.to_s[-3].to_i
			param1 = instruction[startIndex+1]
			resultAdd = paramMode(modeOpr,param1,instruction)
			instruction[resultAdd] = gets.to_i
			process(instruction, startIndex + 2)
		elsif actualOp == 4
			modeOpr = opcode.to_s[-3].to_i
			param1 = instruction[startIndex+1]
			resultAdd = paramMode(modeOpr,param1,instruction)
			puts "!!!!!!!!!!! output #{resultAdd} !!!!!!!!!!!!!!!"
			puts "----------------------------------------------------"
			process(instruction, startIndex + 2)
		elsif actualOp == 5
			modeOpr1 = opcode.to_s[-3].to_i
			modeOpr2 = opcode.to_s[-4].to_i
			value1 = instruction[startIndex + 1]
			value2 = instruction[startIndex + 2]
			judgeValue = paramMode(modeOpr1, value1, instruction)
			jumbAdd = paramMode(modeOpr2, value2, instruction)
			puts "#{opcode}, #{value1}, #{value1}"
			puts "    , #{modeOpr1}, #{modeOpr2}"
			if (judgeValue != 0)
				puts "jump to position => #{instruction[jumbAdd]}"
				process(instruction, jumbAdd)
			else
				process(instruction, startIndex + 3)
			end
		elsif	actualOp == 6
			modeOpr1 = opcode.to_s[-3].to_i
			modeOpr2 = opcode.to_s[-4].to_i
			value1 = instruction[startIndex + 1]
			value2 = instruction[startIndex + 2]
			judgeValue = paramMode(modeOpr1, value1, instruction)
			jumbAdd = paramMode(modeOpr2, value2, instruction)
			puts "#{opcode}, #{value1}, #{value2}"
			puts "    , #{modeOpr1}, #{modeOpr2}"
			if (judgeValue == 0)
				puts "jump to position => #{instruction[jumbAdd]}"
				process(instruction, jumbAdd)
			else
				process(instruction, startIndex + 3)
			end
		elsif	actualOp == 7
			modeOpr1 = opcode.to_s[-3].to_i
			modeOpr2 = opcode.to_s[-4].to_i
			modeOpr3 = opcode.to_s[-5].to_i
			param1 = instruction[startIndex + 1]
			param2 = instruction[startIndex + 2]
			# param3 = instruction[startIndex + 3]
			value1 = paramMode(modeOpr1, param1, instruction)
			value2 = paramMode(modeOpr2, param2, instruction)
			resAdd = instruction[startIndex + 3]
			puts "#{opcode}, #{param1}, #{param2}, #{resAdd}"
			puts "    , #{modeOpr1}, #{modeOpr2}, #{modeOpr3}"
			puts "#{param1} < #{param2}"
			if (value1 < value2)
				puts "input 1 at #{resAdd}"
				instruction[resAdd] = 1
			else
				puts "input 0 at #{resAdd}"
				instruction[resAdd] = 0
			end
			process(instruction, startIndex + 4)
		elsif	actualOp == 8
			modeOpr1 = opcode.to_s[-3].to_i
			modeOpr2 = opcode.to_s[-4].to_i
			modeOpr3 = opcode.to_s[-5].to_i
			param1 = instruction[startIndex + 1]
			param2 = instruction[startIndex + 2]
			# param3 = instruction[startIndex + 3]
			value1 = paramMode(modeOpr1, param1, instruction)
			value2 = paramMode(modeOpr2, param2, instruction)
			resAdd = instruction[startIndex + 3]
			puts "#{opcode}, #{param1}, #{param2}, #{resAdd}"
			puts "    , #{modeOpr1}, #{modeOpr2}, #{modeOpr3}"
			puts "#{value1} == #{value2}"
			if (value1 == value2)
				puts "input 1 at #{resAdd}"
				instruction[resAdd] = 1
			else
				puts "input 0 at #{resAdd}"
				instruction[resAdd] = 0
			end
			process(instruction, startIndex + 4)
		end
	elsif opcode < 99
		if( opcode == 1 || opcode == 2)
			oprantAdd1 = instruction[startIndex + 1]
			oprantAdd2 = instruction[startIndex + 2]
			resultAdd3 = instruction[startIndex + 3]
			puts "#{opcode}, #{oprantAdd1}, #{oprantAdd2}, #{resultAdd3}"
			instruction[resultAdd3] = operateValue(opcode, instruction[oprantAdd1], instruction[oprantAdd2])
			process(instruction, startIndex + 4)
		elsif opcode == 3
			puts "please enter input"
			inputAdd = instruction[startIndex + 1]
			instruction[inputAdd] = gets.to_i
			puts "input #{instruction[inputAdd]} at #{inputAdd}"
			process(instruction, startIndex + 2)
		elsif opcode == 4
			outputAdd = instruction[startIndex + 1]
			puts "!!!!!!!!!!! output #{instruction[outputAdd]} from #{outputAdd}!!!!!!!!!!!!!!!"
			puts "----------------------------------------------------"
			process(instruction, startIndex + 2)
		elsif opcode == 5
			judgeValue = instruction[startIndex + 1]
			jumbAdd = instruction[startIndex + 2]
			if (judgeValue != 0)
				process(instruction, jumbAdd)
			else
				process(instruction, startIndex + 3)
			end
		elsif	opcode == 6
			judgeValue = instruction[startIndex + 1]
			jumbAdd = instruction[startIndex + 2]
			puts "#{judgeValue} == 0"
			if (judgeValue == 0)
				puts "jump to position => #{jumbAdd}"
				process(instruction, jumbAdd)
			else
				process(instruction, startIndex + 3)
			end
		elsif	opcode == 7
			param1 = instruction[startIndex + 1]
			param2 = instruction[startIndex + 2]
			resAdd = instruction[startIndex + 3]
			puts "#{judgeValue} == 0"
			if (instruction[param1] < instruction[param2])
				instruction[resAdd] = 1
			else
				instruction[resAdd] = 0
			end
			process(instruction, startIndex + 4)
		elsif	opcode == 8
			param1 = instruction[startIndex + 1]
			param2 = instruction[startIndex + 2]
			resAdd = instruction[startIndex + 3]
			if (instruction[param1] == instruction[param2])
				instruction[resAdd] = 1
			else
				instruction[resAdd] = 0
			end
			process(instruction, startIndex + 4)
		end
	elsif opcode == 99
		puts "=== ends ==="
	else
		puts "unknown opcode #{startIndex} => #{opcode}"
	end
end

# input="3,23,3,24,1002,24,10,24,1002,23,-1,23,
# 101,5,23,23,1,24,23,23,4,23,99,0,0"

instruction = input.split(",").map(&:to_i)

process(instruction,0)

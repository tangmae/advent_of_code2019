def intCode(stack, startIndex)
	optcode = stack[startIndex]
	if optcode == 1
		position1 = stack[startIndex+1]
		position2 = stack[startIndex+2]
		resPosition = stack[startIndex+3]
		puts "position #{position1} #{position2} #{resPosition}"
		puts "result #{stack[position1]} + #{stack[position2]} = #{stack[resPosition]}"
		stack[resPosition] = stack[position1] + stack[position2]
		puts stack.to_s
		intCode(stack, startIndex+4)
	elsif optcode == 2
		position1 = stack[startIndex+1]
		position2 = stack[startIndex+2]
		resPosition = stack[startIndex+3]
		puts "position #{position1} #{position2} #{resPosition}"
		puts "result #{stack[position1]} * #{stack[position2]} = #{stack[resPosition]}"
		stack[resPosition] = stack[position1] * stack[position2]
		puts stack.to_s
		intCode(stack, startIndex+4)
	elsif optcode == 99
		puts stack[0]
		return
	else
		puts "error !! at #{startIndex} #{stack[startIndex..startIndex+4]}"
	end
end


def explain(stack, startIndex, resultStack)
	optcode = stack[startIndex]
	if optcode == 1
		position1 = stack[startIndex+1]
		position2 = stack[startIndex+2]
		resPosition = stack[startIndex+3]
		puts "position #{position1} #{position2} #{resPosition}"
		puts "result #{resultStack[position1]} + #{resultStack[position2]} = #{resultStack[resPosition]}"
		resultStack[resPosition] = resultStack[position1] + resultStack[position2]
		puts stack.to_s
		intCode(stack, startIndex+4, resultStack)
	elsif optcode == 2
		position1 = stack[startIndex+1]
		position2 = stack[startIndex+2]
		resPosition = stack[startIndex+3]
		puts "position #{position1} #{position2} #{resPosition}"
		puts "result #{resultStack[position1]} * #{resultStack[position2]} = #{resultStack[resPosition]}"
		resultStack[resPosition] = resultStack[position1] * resultStack[position2]
		puts stack.to_s
		intCode(stack, startIndex+4, resultStack)
	elsif optcode == 99
		puts stack[0]
		return
	else
		puts "error !! at #{startIndex} #{stack[startIndex..startIndex+4]}"
	end
end




input = "1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,13,1,19,1,6,19,23,2,23,6,27,1,5,27,31,1,10,31,35,2,6,35,39,1,39,13,43,1,43,9,47,2,47,10,51,1,5,51,55,1,55,10,59,2,59,6,63,2,6,63,67,1,5,67,71,2,9,71,75,1,75,6,79,1,6,79,83,2,83,9,87,2,87,13,91,1,10,91,95,1,95,13,99,2,13,99,103,1,103,10,107,2,107,10,111,1,111,9,115,1,115,2,119,1,9,119,0,99,2,0,14,0"

inputStack = input.split(",").map(&:to_i)

inputStack[1] = 12
inputStack[2] = 2

intCode(inputStack, 0)

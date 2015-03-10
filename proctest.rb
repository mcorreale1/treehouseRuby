class Array
	def iterate!(&code)
		self.each_with_index do |n, i|
			self[i] = code.call(n)
		end
	end
end

array = [1, 2, 3, 4]

array.iterate! do |n|
  n ** 2
end


def what_am_i(&block)
  block.class
end

numbers = []
number = 0

loop do
	numbers << number
	number+=1
	if numbers.length >= 3
		break
	else
		puts number 
	end


end

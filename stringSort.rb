#!/usr/bin/env ruby

class StringSort
	#Initializer
	def initialize(str)
		@raw_string = str
		@sorted_string
		@array_string = @raw_string.split ""
		#Turn array values into ascii
		i = 0
		#.each gets each value of a list
		#do loops through each
		#|c| is the instance variable that theyre saved in
		@raw_string.each_byte do |c|
			@array_string[i] = c
			i+=1
		end
	end
	#returns values
	def raw_string
		return @raw_string
	end
	def sorted_string
		return @sorted_string
	end
	def array_string
		return @array_string
	end
end
test = StringSort.new("test")
puts(test.array_string)

#!/usr/bin/env ruby

class StringSort
	#Initializer
	def initialize(str)
		@raw_string = str
		@array_string = @raw_string.split('').map(&:ord)
		@sorted_string = ""
		sort_string
		#.split('') splits into array
		#.map Lambda expression (not enough space to explain)
		#& has to do with procs, :ord is the method
	end

	def sort_string
		@sorted_string = @array_string.sort.map{ |c|
			c = c.to_i.chr
		}.join(" ")
		puts sorted_string
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
test = StringSort.new("AdsCv").sorted_string
puts test
#test = test.split(" ").map{|c|}

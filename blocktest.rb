class Array
	def iterate!
		self.each_with_index do |n, i|
			#yield applys a block of code to each
			#element of the array
		self[i] = yield(n)
		end
	end
end

array = [1, 2, 3, 4]

array.iterate! do |c|
	c * 3
end

#lambdas are rigid in their arugements
#procs dont require all of them to be filled

def hello(&block)
	if block.lambda? 
		block.call("lambda")
	elsif !block.lambda?
		block.call
	end
end


# def hello(&block)
# 	block.call
# end

blah = proc { |n| puts "proc#{n}"}
test = lambda { |n| puts "#{n}"}

# hello(&blah)
# hello(&test)


# Procs are code snipits, not actual methods
# lambdas are actually methods

def proc_return
	# cannot pass procs with return in them around
	Proc.new { return "Proc.new"}.call
	return "proc_return method finished"
end

def lambda_return
	lambda { return "lambda" }.call
	return "lambda_return method finished"
end

# puts proc_return
# puts lambda_return

# identicle to the ones above

def proc_ret 
	return "Proc.new"
	return "proc_return method finished"
end

def lambda_ret
	def lamb 
		return "lambda" 
	end
		lamb
	return "lambda_return method finished"
end

# puts proc_ret
# puts lambda_ret

# Procs cannot have return in them, causes jumperror
# Lambdas are methods so its allowed
def generic_return(code)
	one, two    = 1, 2
	puts code.call(one,two).class
	three, four = code.call(one, two)
	return "Give me a #{three} and a #{four}"
end

# will work because passes return in a method
# puts generic_return(lambda { |x, y| return x + 2, y + 2 })

# wont work due to passing return as a proc
# puts generic_return(Proc.new { |x, y| return x + 2, y + 2 })

# will work but Second arguement wont get passed
# puts generic_return(Proc.new { |x, y| x + 2; y + 2 })

# will work and both arguements will be passed
# args sit in an array and it works because ruby
# puts generic_return(Proc.new { |x, y| [x + 2, y + 2] })




=begin
def module_split(module_path, separator = "::")
	#splits string into array
	modules = module_path.split(separator)
	modules.length.downto(1).map { |n|
		modules.first(n).join(separator) 
	}

end

puts module_split("X::Y::Z").inspect

str1= String.new
enumerator = %w(one two three).each
enumerator.map{|c| str1+=c+' '} # => Enumerator
puts str1
=end


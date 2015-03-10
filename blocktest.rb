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

hash = {'test' => []}
hash['adsa'] = 5
puts hash

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


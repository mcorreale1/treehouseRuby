# def myMethod(test, message="This is a default value", word)
#   puts message + " " + test + " " + word
# end
# # Last parameter takes the place of the default, otherwise in order
# myMethod("Test", "word" , "more")
# myMethod("Where has the default value gone?", "Test")

require_relative('../cssReader/cssReader.rb')

test = Proc.new do |n| 
	n**2
end

powers = Hash.new
1000.times do |n|
	powers["pwr#{n}".to_sym] = Proc.new do |i| i**n end
end
puts powers[:pwr5].call(5)

ary = Array.new

(0..9).each { |n|
ary << n
}
range = (2..-1)
newary = ary[range]


range.each { |n|
	puts n
}




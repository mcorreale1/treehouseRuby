num1 = Random.new.rand(100)
num2 = Random.new.rand(100)
num3 = 10

array = Array.new(10)


array.map!{ |c|
	c = Random.new.rand(100)
}
#puts array.inspect

array = %w[@media
	@char
	@dasdas
	@
	adasdsa
	@dasdasd
]
# array.each_with_index { |c, i|
# 	if c.include?("@media")
# 		puts "#{i} @media"
# 	elsif c.include?("@")
# 		puts "#{i} @"
# 	else
# 		puts "#{i} none"
# 	end
# }
input = ""
File.open("css/style1.css").each {|line|
	input = input + line
}
puts input

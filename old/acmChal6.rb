max = 1000
number = 5
times_found = 0

# input = ""
# File::open('css/raw_google.css').each { |c|
# 	input = input + c
# }
# output = ""
# input.scan(/[^}]*}/) { |c|
# 	output = output + c + "\n"
# }
# File::write('css/google.css', output)

for i in 0..max-1 do 
	array = i.to_s.split('').map(&:to_i)
	for n in 0...array.length do
		if array[n] == number
			times_found += 1
			break
		end
	end
end

def add_array!
	self.map!{|c|
		c+=1
	}
end
public :add_array!

ary = [1,2,3,4,5]
ary.add_array!
puts ary

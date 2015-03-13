max = 1000
number = 5
times_found = 0

for i in 0..max-1 do 
	array = i.to_s.split('').map(&:to_i)
	for n in 0...array.length do
		if array[n] == number
			times_found += 1
			break
		end
	end
end

will_is = %w[gay
fag
bag
dumb
]


will_is.each { |c|
	puts "Hey will ur #{c}"
}
str1 = "Hello World"
str2 = str1.split('')

#.map() is a lambda expression that copys elements
#into new array
# & is each element that is copied to new array
#:function is whats ran on each function
str2 = str2.map(&:upcase).join('')


test = false
ary1 = [1, 2, 3, 4, 5]
#.each runs through each element but doesnt save
#elements, just tests
ary1 = ary1.each{|c| c**2 
	if c == 25
		test = true
	end
}

#same thing as previous lambda but |c| is the 
#variable for each element of array
#map! saves the array in the original place
ary2 = ary1.map{|c| c**c}

#will return last reference variable
def num_stuff(a,b)
	a*b
end

line = "first_name=mickey;last_name=mouse;country=usa" 
	puts Hash[*line.split( /=|;/ )]















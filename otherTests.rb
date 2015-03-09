=begin
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
=end
input = "body{background-color: #f4f4f4;}

.header {
height: 100px;
width: 100%;
}

/*
tester
*/
.header .title {
	height: 80px;
	width: 200px;
	display: inline-block;/*sda*/
}

.header .container-fluid h1 a{
	text-align: left;
	color: #FFF;
}
/*
test
*/
.header .nav.nav-pills {
	margin-top: 50px;
	float: right;
	padding: 0 20px;
}"




# input.gsub!("\n", " ")

# input.gsub!(/\/\*[^\*]*\*+([^\/\*][^\*]*\*+)*\//m, "").strip!

# puts input

css_hashes = []
lines = input
lines.gsub!(/\/\*[^\*]*\*+([^\/\*][^\*]*\*+)*\//m, "").strip!
lines = lines.delete("\n").delete("\t")

lines = lines.split('}')

lines.each_with_index{ |c, n|
	css = c.split( /;|{/)
	css_hashes << { "element" => css.shift.strip}
	css.each{ |w|
		attributes = w.split(':').map(&:strip)
		css_hashes[n][attributes[0]] = attributes[1]
	}
}

puts css_hashes












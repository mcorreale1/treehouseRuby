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
@media (max-width: 600px){
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
	}
}
.header .title {
	height: 80px;
	width: 200px;
	display: inline-block;/*sda*/
}"

def hash_css(css_array)
	raw_hash = {'selector' => css_array.shift, 'contents' => []}
	css_array.each{ |i| 
		props = i.split(':').map(&:strip)
		raw_hash['contents'].push({props[0] => props[1]})
	}
	return raw_hash
end

def query_range()
end


css_hashes = []
lines = input
lines.gsub!(/\/\*[^\*]*\*+([^\/\*][^\*]*\*+)*\//m, "").strip!
lines.delete!("\n").delete!("\t")
puts lines.split(/\}/).map{|c| c = c + '}'}
lines.each_with_index{ |c, n|
	css_selectors = {}
	css = c.split( /;|{/).map(&:strip)
	if css[0].include?("@media") then
		css_selectors = {"query" => css.shift[6..-1].strip, 'contents' => [hash_css(css)] }
	else
		css_selectors = hash_css(css)
	end
	css_hashes << css_selectors
}




# lines = lines.split(/\}/).map{|s| s +'}'}
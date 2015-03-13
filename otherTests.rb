input = "
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
@media (max-height: 600px) {
	.header .title {
		height: 80px;
		width: 200px;
		display: inline-block;/*sda*/
	}
}
body {
	background-color: #f4f4f4;
}
.header .nav.nav-pills {
	margin-top: 50px;
	float: right;
	padding: 0 20px;
}
"

input2 = "body{background-color: #f4f4f4;}
.header {
height: 100px;
width: 100%;
}
.header .title {
	height: 80px;
	width: 200px;
	display: inline-block;
}

.header .container-fluid h1 a{
	text-align: left;
	color: #FFF;
}

.header .nav.nav-pills {
	margin-top: 50px;
	float: right;
	padding: 0 20px;
}
.header .nav.nav-pills li{
	height: 50px;
	width:122px;
}
"

def hash_css(css_array)
	raw_hash = {'selector' => css_array.shift, 'contents' => []}
	css_array.pop
	css_array.each{ |i| 
		props = i.split(':').map(&:strip)
		raw_hash['contents'].push({props[0] => props[1]})
	}
	return raw_hash
end

#Gets how long the media query is
def query_length(css_array)
	length = 0
	css_array.each_with_index{ |c, n|
		if c.include?("}}")
			length = n
			break
		end
	}
	return length
end


css_hashes = []
lines = input2
media_length = 0
lines.strip!.gsub!(/\/\*[^\*]*\*+([^\/\*][^\*]*\*+)*\//m, "")
lines.delete!("\n").delete!("\t")
lines = lines.scan(/[^}]*}/)


#check for media query formating
for i in 0..lines.length 
	if lines[i] == "}"
		lines.delete_at(i)
		lines[i-1] << "}"
	end
end
pos = 0
while pos < lines.length do
	css_selectors = {}
	css = lines[pos].split( /;|{/).map(&:strip)

	if css[0].include?("@media") then
		media_length = query_length(lines[pos..-1])
		css_selectors = {"query" => css.shift[6..-1].strip, 'contents' => []  }
	else
		css_selectors = hash_css(css)
	end

	if media_length > 0
		media_length-=1
	end
	css_hashes << css_selectors
	pos+=1
end
puts css_hashes






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
	body {
		background-color: #f4f4f4;
	}
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

.header .nav.nav-pills li{
	height: 50px;
	width:122px;
}
"

def hash_css(css_array)
	raw_hash = {'selector' => css_array.shift, 'contents' => []}
	css_array.each{ |i| 
		props = i.split(':').map(&:strip)
		raw_hash['contents'].push({props[0] => props[1]})
	}
	return raw_hash
end

def query_range()
	#WRITE THIS
end

css_hashes = []
lines = input2
lines.strip!.gsub!(/\/\*[^\*]*\*+([^\/\*][^\*]*\*+)*\//m, "")
lines.delete!("\n").delete!("\t")
lines.scan(/[^}]*}/).each_with_index{ |c, n|
	css_selectors = {}
	css = c.split( /;|{/).map(&:strip)
	if css[0].include?("@media") then
		css_selectors = {"query" => css.shift[6..-1].strip, 'contents' => [hash_css(css)] }
	else
		css_selectors = hash_css(css)
	end
	css_hashes << css_selectors
}
puts css_hashes



# lines = lines.split(/\}/).map{|s| s +'}'}
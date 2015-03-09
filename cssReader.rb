input = "body{background-color: #f4f4f4;}

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
}"

css_hashes = []
lines = input
lines.delete!("\n").delete!("\t")
lines = input.split('}')
lines.each_with_index{ |c, n|
	css = c.split( /;|{/)
	css_hashes << { "element" => css.shift.strip}
	css.each{ |w|
		attributes = w.split(':').map(&:strip)
		css_hashes[n][attributes[0]] = attributes[1]
	}
}
puts css_hashes
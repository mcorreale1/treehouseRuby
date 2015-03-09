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


class Css_Reader
	def initialize(css_input)
		@raw_css = css_input
		@css_hash = []
		self.split_css

	end

	def split_css
		css_hashes = []
		lines = @raw_css
		lines.gsub!(/\/\*[^\*]*\*+([^\/\*][^\*]*\*+)*\//m, "")
		lines.delete!("\n").delete!("\t")


		lines.split('}').each_with_index{ |c, n|
			css = c.split( /;|{/)
			css_hashes << { "element" => css.shift.strip }
			css.each{ |w|
				attributes = w.split(':').map(&:strip)
				css_hashes[n][attributes[0]] = attributes[1]
			}
		}
		@css_hash = css_hashes
	end

	def css_hash 
		@css_hash
	end
	def to_s
		@css_hash
	end
end
reader = Css_Reader.new(input)
puts reader.to_s




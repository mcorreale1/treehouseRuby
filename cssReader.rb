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
@media (max-width:600px){
	.header .nav.nav-pills {
		margin-top: 50px;
		float: right;
		padding: 0 20px;
	}
	.header .nav.nav-pills li{
		height: 50px;
		width:122px;
	}
}"


class Css_Reader
	def initialize(css_input)
		@raw_css = css_input
		@css_hashes = []
		split_css
	end
	
	def hash_css(css_array)
		raw_hash = {'selector' => css_array.shift, 'contents' => []}
		css_array.each{ |i| 
			props = i.split(':').map(&:strip)
			raw_hash['contents'].push({props[0] => props[1]})
		}
		return raw_hash
	end

	def split_css
		lines = @raw_css
		lines.gsub!(/\/\*[^\*]*\*+([^\/\*][^\*]*\*+)*\//m, "")
		lines.delete!("\n").delete!("\t")
		lines.split('}').each_with_index{ |c, n|
			css_selectors = {}
			css = c.split( /;|{/).map(&:strip)
			if css[0].include?("@media") then
				css_selectors = {"query" => css.shift[6..-1].strip, 'contents' => [hash_css(css)] }
			else
				css_selectors = hash_css(css)
			end
			@css_hashes << css_selectors
		}
	end
	attr_accessor :raw_css
	attr_accessor :css_hashes
	def to_s
		output = ""

		@css_hashes.map { |css|
			hash = css
			repeat = 1
			if hash.keys[0] == 'query'
				output =  output + "#{hash.keys[0]}: #{hash.values[0]}\n\t"
				repeat = 2
				hash = hash['contents'][0]
			end
			output =  output + "#{hash.keys[0]}: #{hash.values[0]}\n"

			hash['contents'].each { |prop|
				output = output + ("\t" * repeat) + "#{prop.keys[0]}: #{prop.values[0]}\n"
			}
		}
		output
	end
end
reader = Css_Reader.new(input)
# puts reader.to_s
puts reader.css_hashes




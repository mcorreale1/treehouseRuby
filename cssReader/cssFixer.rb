#fixes CSS errors
#starting with making sure ; is added to everything
require_relative 'cssReader'
class Css_Fixer
	def initialize(css_reader)
		@reader = css_reader
		@raw_css = @reader.raw_css
		@fixed_css = ""
		fix_css
	end

	def fix_css
		lines = @reader.pre_format_css
		lines.map!{ |c|
			if @reader.get_rule_type(c) == "selector"
				if c[-2..-1] == "}}"
					if c[-3] != ";"
						c.insert(-3, ";")
					end
				elsif c[-1] == "}"
					if c [-2] != ";"
						c.insert(-2, ";")
					end
				end
			end
			c
		}
		@fixed_css = lines
	end
	attr_accessor :fixed_css
end

input = "
a{	
	text-decoration: none;
 	color: inherit
}
p{
	display: inline-block; 
	margin: 0;
	font-size: .725em
}
h1,h2{ 
	display: block; 
	margin: 0;
	padding: 10px 0px
}

@media screen and (min-width:500px){
.off{
	display: none !important;
}
li{ 
	display: inline-block;	
	list-style-type: none
}
}
"
fixer = Css_Fixer::new(input)

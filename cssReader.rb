## Michael Correale, "Finished" 3/12/15
## Version 1.0
## Description:
## 	Reads CSS files and formats rules into a hash
##  Media query rules are formatted into an array of hashes
##  at-rules are formatted into a hash
##  First hash key will always be either 'at-rule', 'query', or 'selector'
##
## Syntax:
##  standard rule:
##   key = 'selector'
##    value = selector for rule
##   key = 'contents'
##    value = array of hashes that contain declarations
##     key = property of css rule
##      value = value of css
##   ex: a{	text-decoration: none; color: inherit;}
##       {"selector"=>"a", "contents"=>[{"text-decoration"=>"none"}, {"color"=>"inherit"}]}
##
##  at-rules:
##   key = 'at-rule'
##    value = rule
##   key = 'command'
##    value = what rule is doing
##   ex: @char-set "test"; 
##	     {"at_rule"=>"@char-set", "command"=>"\"test\""}

##  nested at-rules (@media, @print):
##   key = 'at-rule'
##    value = rule
##   key = 'command'
##    value = what rule is doing
##   key = 'contents'
##    value = array of standard CSS rules that fall into this query
##     (see standard at-rule syntax)
##   ex  @media screen and (min-width:500px){
##			.header{
##			height: 120px;
##			max-height: 160px;
##			-webkit-transition: height .5s;
##			}
##			.login {
##				float: right;
##				padding:7px;
##			}
##    }
## FIX THIS
class Css_Reader
	@@single_atrule = %w[@char-set @import @namespace]
	def initialize(css_input)
		@raw_css = css_input
		@css_hashes = []
		split_css
	end


	#Takes an array that contains the css elements
	#returns a formatted hash
	def hash_css(css_array)
		raw_hash = {'selector' => css_array.shift, 'contents' => []}
		css_array.pop
		css_array.each{ |i| 
			props = i.split(':').map(&:strip)
			raw_hash['contents'].push({props[0] => props[1]})
		}
		return raw_hash
	end

	#takes an at rule array
	#returns true if nested, false if not
	def at_rule?(css_string)

		if css_string.include?('@')

			@@single_atrule.each{ |rule|
				if css_string.include?(rule)
					return "single"
				end
			}
			if css_string.include?('keyframes')
				return 'keyframes'
			end
			return "nested"
		else
			return false
		end
	end

	#takes an array that starts at a media query
	#returns how far ahead that query ends
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

	#Formats the CSS file to be read
	def pre_format_css(css_lines)

		#Removes comments
		css_lines.gsub!(/\/\*[^\*]*\*+([^\/\*][^\*]*\*+)*\//m, "")
		css_lines.gsub!(/\n|\t/, "")

		#Splits at each }
		css = css_lines.scan(/[^}]*}/)

		#check for media query formating by adding back a }
		#to the previous line
		for i in 0..css.length 
			if css[i] == "}"
				css.delete_at(i)
				css[i-1] << "}"
			end
		end
		css.each_with_index{ |c,i|
			if at_rule?(c) == "single"
				pos = i
				c = c.split(";")
				c.map!{|n| n << ";"}
				c.reverse
				c.each{ |n| css.unshift}

			else
				c
			end

		}	

		#puts css[0]
		exit
		return css
	end

	#formats the CSS into hashes
	#media query 
	def split_css
		lines = @raw_css
		lines = pre_format_css(lines)

		pos = 0
		while pos < lines.length do
			css_selectors = {}
			css = lines[pos].split( /;|{/).map(&:strip)
			is_at_rule = at_rule?(css[0])
			if is_at_rule == "nested"
				media_length = 0
				media_array = []
				media_length = query_length(lines[pos..-1])

				css_selectors = {'at_rule' => css[0][0..6].strip, 'command' => css[0][6..-1].strip}
				for i in 0..media_length
					css = lines[pos+i].split( /;|{/)
					if i == 0 
						css.shift
					end
					media_array << hash_css(css)
				end
				css_selectors['contents'] = media_array
				pos+=media_length
				
			elsif is_at_rule == "single"
				rule = css.shift.split(" ", 2).map(&:strip)
				css_selectors = {'at_rule' => rule[0], 'command' => rule[1]}
				@css_hashes.unshift(css_selectors)
				css_selectors = hash_css(css)

			#for standard css rule
			elsif is_at_rule == "keyframes"
				#puts css
			else
				css_selectors = hash_css(css)
			end
			@css_hashes << css_selectors
			pos+=1
		end

	end



	#Printing functions
	attr_accessor :raw_css
	attr_accessor :css_hashes
	def to_s
		output = ""
		repeat = 1
		@css_hashes.each_with_index { |hash, i|
			output =  output + "#{hash.keys[0]}: #{hash.values[0]}\n"
			if hash.keys[0] == 'query'	
				repeat = 2
				hash = hash['contents']
				hash.each{ |c| 
					output =  output + "\t#{c.keys[0]}: #{c.values[0]}\n"
					contents = c['contents']
					contents.each { |prop| 
						output = output + ("\t" * repeat) + "#{prop.keys[0]}: #{prop.values[0]}\n"
					}
				}
			elsif hash.keys[0] == 'at_rule'
				output = output + "\t #{hash.keys[1]}: #{hash.values[1]}\n"
			else 
				hash['contents'].each { |prop|
					output = output + "\t#{prop.keys[0]}: #{prop.values[0]}\n"
				}
			end
		}
		output
	end
end
input = ""
File.open("css/style1.css").each { |line|
	input = input + line
}
# input = "
# a{	
# 	text-decoration: none;
#  	color: inherit;
# }
# p{
# 	display: inline-block; 
# 	margin: 0;
# 	font-size: .725em;
# }
# h1,h2{ 
# 	display: block; 
# 	margin: 0;
# 	padding: 10px 0px;
# }
# li{ 
# 	display: inline-block;	
# 	list-style-type: none; 
# }
# .off{
# 	display: none !important;
# }
# "
reader = Css_Reader::new(input)
#puts reader.css_hashes





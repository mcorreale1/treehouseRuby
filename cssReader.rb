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
##
class Css_Reader
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
	#Takes an array that starts at a media query
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
	#formats the CSS into hashes
	#media query 
	def split_css
		lines = @raw_css
		#accounts for comments
		lines.gsub!(/\/\*[^\*]*\*+([^\/\*][^\*]*\*+)*\//m, "")
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
			media_length = 0
			if css[0].include?('@media') then
				media_array = []
				media_length = query_length(lines[pos..-1])
				css_selectors = {'query' => css.shift[6..-1].strip}
				for i in 0..media_length
					css = lines[pos+i].split( /;|{/)
					if i == 0 
						css.shift
					end
					media_array << hash_css(css)
				end
				css_selectors['contents'] = media_array
				pos+=media_length
				
			elsif css[0].include?('@')
				rule = css.shift.split(" ", 2).map(&:strip)
				css_selectors = {'at_rule' => rule[0], 'command' => rule[1]}
				@css_hashes.unshift(css_selectors)
				css_selectors = hash_css(css)

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

reader = Css_Reader.new(input)
puts reader.css_hashes
# reader.css_hashes.each { |line|
# 	puts line['selector']
#}






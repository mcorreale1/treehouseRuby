#!/usr/bin/env ruby 
def sortString(st)
	str = st
	i = 0
#
#	While loop
#	while i < str.length do
#		puts("test")
#		i+=1
#	end
	st.each_byte do |c|
		puts(c)
	end
	return str
end
sortString(ARGV[0])
def isChar(char)
end

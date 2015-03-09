input = "4
1 1 2 3 4 5 6 7 8 9 1000
2 338 304 619 95 343 496 489 116 98 127
3 931 240 986 894 826 640 965 833 136 138
4 940 955 364 188 133 254 501 122 768 408"
#input = $stdin.read
raw_line= input.split("\n")[1..-1]
raw_line.map!{ |c|
	c = c.split(" ").map(&:to_i)
	num = c.shift
	c.sort.reverse.uniq.push(num) }
raw_line.each {|c| 
	puts c[-1].to_s+ " " + c[3].to_s+"\n"}

# while i < refined.lines.count do
# 	raw_line = refined.split("\n")[i]
# 	raw_line[0..1]= ""
# 		ary = raw_line.split(" ").map(&:to_i).uniq
# 		big_array[i]=ary
# 		i+=1
# end

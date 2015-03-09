input="1
374
1634
8208
94974"
num_ary = input.split("\n")
added_nums = Array.new
num_ary.each{|c|
	sum = 0
	each_num = c.split("").map(&:to_i).each{|d| sum += d**c.size }
	added_nums << sum
}
num_ary.map!(&:to_i).zip(added_nums).each{|c, d|
	puts((c==d).to_s)
}


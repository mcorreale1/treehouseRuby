# def do_interval(secs)
# 	last_tick = Time.now
# 	loop do
# 		sleep 0.1
# 		if Time.now - last_tick >= secs
# 			last_tick += secs
# 			yield
# 		end
# 	end
# end

# do_interval(1) do
# 	puts Time.now
# end

ary = []
ary[0] = 1
ary << 2
hash = {}
hash['test'] = "test"
hash.merge!({"array" => ary})
puts hash.inspect
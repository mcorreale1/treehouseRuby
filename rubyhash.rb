num1 = 5
num2 = 6
num3 = 10

array = Array.new(20)

array.map!{ |c|
	c = Random.new.rand(100)
}

array[0] = 5
hash = { "name" => 6}

puts hash['name']
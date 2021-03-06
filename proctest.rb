class Array
	def iterate!(&code)
		self.each_with_index do |n, i|
			self[i] = code.call(n)
		end
	end
end

array = [1, 2, 3, 4]

array.iterate! do |n|
  n ** 2
end


def what_am_i(&block)
  block.class
end


# Forms a struct with a :chain parameter
DNA = Struct.new(:chain) do
  def triples
    chain.split(//).each_slice(3).to_a
  end

  def &(dna)
  	puts triples.inspect
  	puts dna.triples.inspect
    (triples & dna.triples).map{ |triple| triple.join }
  end
end


test = DNA.new('AGGTTACCA') & DNA.new('TTAAGGCCC')
puts test.inspect






# ary1 = [1, 2, 3, 4]
# ary2 = [5, 6, 7, 8]
# ary3 = [9, 10, 11 ,12]

# ary1.each_with_index{ |c, n|
# 	ary2.insert(n, c)
# }
# puts ary2.inspect
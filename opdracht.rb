def shift(letter, number_of_places)
  alphabet   = Array('a'..'z')
  encrypter  = Hash[alphabet.zip(alphabet.rotate(number_of_places))]
  letter.chars.map { |c| encrypter.fetch(c, " ") }
end

  print "wat wil je encrypten/decrypten?"
  letters = gets.chomp
  print("hoeveel schuift it op in de alfabet?")
  number_of_places = gets.chomp.to_i

  puts shift( letters, number_of_places )

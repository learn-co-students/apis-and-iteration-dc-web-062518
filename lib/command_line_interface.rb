def welcome
  # puts out a welcome message here!
  puts "Welcome to Star Wars!!  Who is your favorite character?"
end

def get_character_from_user
  puts "Please enter your favorite character's name"
  input = gets.strip
  return input
  # use gets to capture the user's input. This method should return that input, downcased.
end

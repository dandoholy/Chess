# PHASE 2
def convert_to_int(str)
  Integer(str)
rescue TypeError
  nil
  
end

class CoffeeError < StandardError
  def message
    "THANKS FOR COFFEE"
  end
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == "coffee"
    raise CoffeeError
  else 
    raise StandardError 
  end 
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"

  puts "Feed me a fruit! (Enter the name of a fruit:)"
  maybe_fruit = gets.chomp
  reaction(maybe_fruit) 
rescue CoffeeError => e
  puts e.message
  retry
rescue
  
  
  
end  

# PHASE 4
class NotBFFError < StandardError
  def message
    "idk my bff jill"
  end
end
class NoPastimeError < StandardError 
  def message
    "don't you have any hobbies?"
  end
end
class NoNameError < StandardError
  def message
    "what's your name, buddy?"
  end
end

class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    @name = name
    @yrs_known = yrs_known
    @fav_pastime = fav_pastime
    raise NotBFFError if @yrs_known < 5
    raise NoNameError if @name.empty?
    raise NoPastimeError if @fav_pastime.empty?
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me." 
  end
end



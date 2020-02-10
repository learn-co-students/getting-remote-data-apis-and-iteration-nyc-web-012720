require 'awesome_print'
require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  response_hash = make_a_request_return_json('http://www.swapi.co/api/people/')
  character = response_hash["results"].find{|character| character["name"].downcase == character_name}
  if character
    films_hash = character["films"].map{|film| make_a_request_return_json(film)}
  else
    puts "Character doesn't exist"
  end
end

def print_movies(films)
  if films
    ap films.map{|film| film["title"]}
  else
    puts "You put in the wrong character"
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS
### HELPER METHODS ####
def make_a_request_return_json(url)
  response_string = RestClient.get(url)
  JSON.parse(response_string)
end
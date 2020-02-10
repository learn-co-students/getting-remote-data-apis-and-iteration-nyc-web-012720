require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request

  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)



  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
  film_arr = []

  response_hash['results'].each do |attributes|
    if attributes['name'].downcase == character.downcase
      attributes['films'].each do |title_url|
        films_string = RestClient.get(title_url)
        films_json = JSON.parse(films_string)
        film_arr << films_json
      end
    end
  end
  film_arr
end

def parse_character_movies(character)
  puts get_character_movies_from_api(character)[0]["title"]
end

def print_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each_with_index do |attribute, index|
    puts "#{index + 1}. #{attribute["title"]}"
  end
end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  print_movies(films_array)
end
## BONUS
# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

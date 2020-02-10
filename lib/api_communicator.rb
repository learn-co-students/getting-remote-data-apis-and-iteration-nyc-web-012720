require 'rest-client'
require 'json'
require 'pry'
def get_character_movies_from_api(character_name)
  #make the web request
  # response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = get_my_hash_dangit
  # iterate over the response hash to find the collection of films for the given
  #   character
  character_movie_array = []
  response_hash["results"].each do |people|
    people["films"].each do |film_urls|
      film_string = RestClient.get(film_urls)
      film_hash = JSON.parse(film_string)
      character_movie_array << {name: people["name"], film: film_hash} if people["name"] == character_name
    end
  end
  return character_movie_array
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to print_movies
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  films.each do |film|
    puts film[:name] + "|" + film[:film]["title"]
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

def get_my_hash_dangit
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  return JSON.parse(response_string)
end
## BONUS
# that get_character_movies_from_api method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
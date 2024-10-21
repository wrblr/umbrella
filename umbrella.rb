require "http"
require "json"
require "dotenv/load"

# Hidden variables:
pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER_KEY")
gmaps_key = ENV.fetch("GMAPS_KEY")

# User interaction:
pp "Where are you located?"

user_location = gets.chomp.gsub(" ", "%20")

#user_location = "Chicago"
pp user_location

# Use user response:
maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + ENV.fetch("GMAPS_KEY")

resp = HTTP.get(maps_url)
raw_resp = resp.to_s

parsed_resp = JSON.parse(raw_resp)

results = parsed_resp.fetch("results")
first_result = results.at(0)
geo = first_result.fetch("geometry")
loc = geo.fetch("location")
pp latitude = loc.fetch("lat").to_s
pp longitude = loc.fetch("lng").to_s


# Assemble the full URL string by adding the first part, the API token, and the last part together
pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + "/" + latitude + "," + longitude

# Place a GET request to the URL
raw_response = HTTP.get(pirate_weather_url)

# Parse response to JSON format
parsed_response = JSON.parse(raw_response)

# Extract current weather hash
currently_hash = parsed_response.fetch("currently")

# Extract current temperature
current_temp = currently_hash.fetch("temperature")

puts "The current temperature is " + current_temp.to_s + "."

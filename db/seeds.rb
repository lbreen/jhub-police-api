require 'rest-client'

Neighbourhood.destroy_all
Force.destroy_all

# Fetch a list of police forces from the api and parse the results into an array
forces = JSON.parse(RestClient.get("https://data.police.uk/api/forces"))

# Iterate over each array element, extract the id and name, and create a new Force instance.
forces.each do |force|
  Force.create!({
    api_id: force["id"],
    name: force["name"]
  })
end
puts "Created #{Force.count} new police forces"

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

#Confirm creation of force instances
puts "Created #{Force.count} new police forces"


i = 0 # Init API limit counter
# Iterate over each police force to grab specific data
Force.all.each do |force|
  puts "Fetching data for #{force.name}" # User confirmation the api call is progressing

  force_data = JSON.parse(RestClient.get("https://data.police.uk/api/forces/#{force.api_id}"))
  force.update({
    description: force_data["description"] || "",
    telephone: force_data["telephone"] || "",
    url: force_data["url"]|| "",
  })

  # Iterate through engagement methods to extract relevant methods - data differs between forces
  force_data["engagement_methods"].each do |method|
    if method["title"] == "facebook"
      force.update(facebook_url: method["url"])
    elsif method["title"] == "twitter"
      force.update(twitter_url: method["url"])
    elsif method["title"] == "youtube"
      force.update(youtube_url: method["url"])
    end
  end

  if i % 15 == 0
    sleep(2) # Delay for 2 seconds every 15 API calls to prevent exceeding limit
  end

  i += 1 # Increment API limit counter (see line 21)
end

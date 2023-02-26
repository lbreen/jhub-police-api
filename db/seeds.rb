require 'rest-client'

Neighbourhood.destroy_all
Force.destroy_all

def sanitise_description(data)
  return if data.nil? || data.empty?

  data.gsub(/<\/li>/, ",") # Replace </li> tags with a comma.
      .gsub(/<\/\w*>/, " ") # Replace closing HTML tags with a space.
      .gsub(/<[^<>]+>/, "") # Remove all remaining HTML tags
end

total_start_time = Time.now # Record overall start time

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
  start_time = Time.now

  puts "Fetching data for #{force.name}" # User confirmation the api call is progressing

  force_data = JSON.parse(RestClient.get("https://data.police.uk/api/forces/#{force.api_id}"))

  description = sanitise_description(force_data["description"])

  force.update({
    description: description || "",
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

  neighbourhood_list = JSON.parse(RestClient.get("https://data.police.uk/api/#{force.api_id}/neighbourhoods"))

  # List all neighbourhoods in the police force and create neighbourhood instances
  neighbourhood_list.each do |neighbourhood|
    n = Neighbourhood.new({
      api_id: neighbourhood["id"],
      name: neighbourhood["name"],
    })

    n.force = force # Assign the neighbourhood to a force
    n.save
  end
  finish_time = Time.now

  puts "#{force.name} has been updated. It took #{(finish_time - start_time).round(2)} seconds."
  puts "--------"
  if i % 7 == 0
    # Delay for 1 second every 15 API calls to prevent exceeding limit
    # Delay every 7 iterations as 2 x API calls per iteration
    sleep(1)
  end

  i += 1 # Increment API limit counter (see line 21)
end

total_finish_time = Time.now

puts"-----------------------"
puts "DB seeding complete. "
puts "#{Force.count} Police Forces and #{Neighbourhood.count} Neighbourhoods have been seeded."
puts "Seeding took #{(total_finish_time - total_start_time).round(2)} seconds"
# Update list of neighbourhoods - 4763 neighbourhoods! need to implement a quicker method.
# i = 0 # Init API limit counter
# Neighbourhood.all.each do |neighbourhood|
#   puts "Fetching data for the #{neighbourhood.name} neighbourhood within the #{neighbourhood.force.name}"
#   neighbourhood_data = JSON.parse(RestClient.get("https://data.police.uk/api/#{neighbourhood.force.api_id}/#{neighbourhood.api_id}"))

#   neighbourhood.update({
#     url: neighbourhood_data["url"],
#     lat: neighbourhood_data["centre"]["latitude"],
#     long: neighbourhood_data["centre"]["longitude"],
#     description: neighbourhood_data["description"]
#   })

#   if i % 15 == 0
#     # Delay for 1 second every 15 API calls to prevent exceeding limit
#     # Delay every 7 iterations as 2 x API calls per iteration
#     sleep(1)
#   end

#   i = 0
# end
















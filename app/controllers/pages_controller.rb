class PagesController < ApplicationController
  def home
    @category_array = [
      {
        url_path: 'senior_leadership',
        image_path: "senior_police",
        description: "Find out about Senior Leadership in your area",
        button: "Find out more"
      },
      {
        url_path: 'neighbourhood_policing',
        image_path: "neighbourhood_policing",
        description: "Get to know your local officers",
        button: "Find out more"
      },
      {
        url_path: 'crime_data',
        image_path: "crime_data",
        description: "Discover local crime statistics",
        button: "Find out more"
      },
    ]
  end

  def senior_leadership
  end

  def neighbourhood_policing
  end

  def crime_data
  end
end

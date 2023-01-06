class PagesController < ApplicationController
  def home
    @category_array = [
      {
        image_path: "senior_police",
        description: "Find out about Senior Leadership in your area",
        button: "Find out more"
      },
      {
        image_path: "neighbourhood_policing",
        description: "Get to know your local officers",
        button: "Find out more"
      },
      {
        image_path: "crime_data",
        description: "Discover local crime statistics",
        button: "Find out more"
      },
    ]
  end
end

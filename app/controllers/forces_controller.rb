class ForcesController < ApplicationController

  def index
    @forces = Force.all.each do |f|
      if f.description.length > 250
        f.description = f.description.chars.each_slice(250).map(&:join)[0] + "..."
      end
    end
  end

  def show

  end
end

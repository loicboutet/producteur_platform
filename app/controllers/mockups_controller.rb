class MockupsController < ApplicationController
  layout "mockups/application"

  def index
    # Main index page that lists all mockup journeys
  end

  def styleguide
    # Brand style guide mockup
    render layout: "mockup_styleguide"
  end
end

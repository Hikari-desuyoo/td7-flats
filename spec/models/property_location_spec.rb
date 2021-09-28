require 'rails_helper'

RSpec.describe PropertyLocation, type: :model do
  it "successfully register property location" do
    rio = PropertyLocation.create!(name: 'rio')
    expect(rio.name).to eq 'rio'
  end
end

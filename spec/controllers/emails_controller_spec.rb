require 'rails_helper'

RSpec.describe EmailsController, type: :controller do
  it "renders the #get_email" do
    get :get_email, name: "Arun Jay", domain: "google.com"
    expect(response).to be_success
  end

  it "returns email of employee" do
    get :get_email, name: "Arun Jay", domain: "google.com", format: :json
    parsed_response = JSON.parse(response.body)
    expect(parsed_response['email']).to_not be_nil
  end

  it "returns an error if the name does not exist" do
    get :get_email, domain: "google.com", format: :json
    parsed_response = JSON.parse(response.body)
    expect(parsed_response['error']).to eq("Please send employee name")
  end

  it "returns an error if the domain does not exist" do
    get :get_email, name: "Arun Jay", format: :json
    parsed_response = JSON.parse(response.body)
    expect(parsed_response['error']).to eq("Please send domain")
  end

end

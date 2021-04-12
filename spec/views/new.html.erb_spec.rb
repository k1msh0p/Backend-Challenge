require "rails_helper"

RSpec.describe "member/new" do
  it "infers the controller action" do
    expect(controller.request.path_parameters[:action]).to eq("new")
    expect(controller.controller_path).to eq("member")
  end
end
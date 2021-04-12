require "rails_helper"

RSpec.describe "rendering the show template" do
  it "displays the member" do
 		assign(:member,
    		Member.create!(name: "Tester1 John", website: "https://www.wikipedia.org"))

    render :template => "members/show.html.erb"

    expect(rendered).to match /Tester1 John/
  end
end
require "rails_helper"

RSpec.describe "rendering the search expert template" do
  it "displays the search expert result" do
 		assign(:member,
    		Member.create!(name: "Tester1 John", website: "https://www.wikipedia.org"))
    assign(:result, ['Expert is "Expert 2". Your connecting path(s): ( "Expert 2" -> "Tester1 John" -> "Tester 3")'])		
    render :template => "members/search_expert.erb"

    expect(rendered).to match /Expert 2/
  end
end
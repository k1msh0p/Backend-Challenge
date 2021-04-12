require "rails_helper"

RSpec.describe "members/index" do
  it "displays all the members" do
    assign(:members, [
    	Member.create!(name: "Tester1 John", website: "https://www.wikipedia.org"),
    	Member.create!(name: "Tester2 John", website: "https://en.wiktionary.org/wiki/-pedia")
    ])

    render

    expect(rendered).to match /Tester1 John/
    expect(rendered).to match /Tester2 John/
  end
end
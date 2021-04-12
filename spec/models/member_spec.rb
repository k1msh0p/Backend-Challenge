require 'rails_helper'

RSpec.describe Member, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
	subject { 
   described_class.new(name: "John Doe", 
                       website: "https://www.example.com")  
  }

  describe "Validations" do

  	it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

 		it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end
    
 		it "is not valid without a website" do
      subject.website = nil
      expect(subject).to_not be_valid
    end

  end

  describe "Callbacks" do
     it 'should have a shorten url' do
			subject.website = "https://www.wikipedia.org"
			subject.save
			expect(subject.url_short).not_to be_empty
		end

    it 'should have a heading1' do
			subject.website = "https://www.wikipedia.org"
			subject.save
			expect(subject.heading1).to include("Wikipedia")
		end

	end
 	describe "Search" do

    it 'should find expert of marathon' do
			subject.website = "https://www.wikipedia.org"
			subject.save
	  	member1 = Member.create(name: "Tester1 Marathon", website: "https://en.m.wikipedia.org/wiki/Marathon")
	  	member2 = Member.create(name: "Tester2 John", website: "https://en.wiktionary.org/wiki/-pedia")
			friend = Friend.create(member_id: member1.id, friend_id: subject.id)
			result = Friend.where(member_id: subject.id, friend_id: member2.id)

			search_result = member2.search_for_expert("marathon")
			expect(search_result[0].has_key?("Tester1 Marathon")).to be true
		end
	end

	

end

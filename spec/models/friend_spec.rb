require 'rails_helper'

RSpec.describe Friend, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  describe "Callbacks" do
    it 'should create an inverse friend' do
    	member = Member.create(name: "Tester1 John", website: "https://www.wikipedia.org")
    	member2 = Member.create(name: "Tester2 John", website: "https://en.wiktionary.org/wiki/-pedia")
			friend = Friend.create(member_id: member.id, friend_id: member2.id)
			result = Friend.where(member_id: member2.id, friend_id: member.id)

			expect(result).not_to be_empty
		end
	end

end

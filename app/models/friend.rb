class Friend < ActiveRecord::Base
	
	belongs_to :member, class_name: "Member", :foreign_key => :member_id
	after_create :create_inverse_friend, unless: Proc.new {|record| Friend.where(member_id: record.friend_id, friend_id: record.member_id).exists?}

	private

	#Callback to create inverse friendship
	def create_inverse_friend
		friend = Friend.new({member_id: self.friend_id, friend_id: self.member_id})
		friend.save!
	end

end

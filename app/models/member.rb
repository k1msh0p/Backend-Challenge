class Member < ActiveRecord::Base

	has_many :friends, class_name: 'Friend', foreign_key: :member_id

	validates :name, :presence => true
	validates :website, :presence => true
	validates :website, format: URI::regexp(%w[http https])

	before_create :set_headings, :shorten


	# Find all member's friends and return Members RecordSet
	def friends
		members = Member.joins(:friends).where("friends.friend_id = ?", id).distinct
    return members
	end

	# Find all members that are not member's friend and return Members resultset
	def non_friends
		members = Member.joins("left outer join friends ON friends.friend_id = members.id and friends.member_id = #{id}").where("friends.id is null and members.id != ? ", id).distinct
	end


	#1. Find all the members with heading1 or heading2 or heading3 that contains the string "headings" input param
	#2. Loop thru each expert
	# => 3. Check if user is a friend of expert
	# => 4. If yes, add search to expert_hash{"Claudia" => ["Alan"]}. Continue with next Expert.
	# => 5. If not, 
	# 		=> loop thru user's friends and find if anyone is a friend of the expert 
	# 		=> eg: expert_hash{"Claudia" => [["Alan","Bart","Claudia"],["Alan","Joe","Claudia"]}
	# Return results is an array of hash
	# eg: [{"Claudia" => [["Alan","Bart","Claudia"],["Alan","Joe","Claudia"]}, {"Expert2" => [[...],[...]}]
	def search_for_expert(headings)
		#1 Query to find expert
		experts = Member.where('members.id != ? and (lower(heading1) like ? or lower(heading2) like ? or lower(heading3) like ?)', id, "%#{headings.downcase}%", "%#{headings.downcase}%", "%#{headings.downcase}%").distinct
		expert_paths_array = Array.new
		experts.each do |expert| #2
			expert_hash = Hash.new
			paths_to_current_expert = []
			found = self.friends.where("friends.member_id = ?", expert).exists? #3 Check if user is a friend of expert
			path = Array.new
			if found #4
				path << self.name
				path << expert.name
				paths_to_current_expert << path
			else #5
				#5 loop thru user's friends and find if anyone is a friend of the expert 
				expert.friends.each do |friend_of_expert|
					friends_with_expert = self.friends.select{ |f| f.id == friend_of_expert.id }
					friends_with_expert.each do |f|
						path = Array.new
						path << self.name
						path << f.name
						path << expert.name
						paths_to_current_expert << path
					end
				end
			end
			expert_hash[expert.name] = paths_to_current_expert
			expert_paths_array << expert_hash
		end
		return expert_paths_array
	end

	private

	
		# Shorten the website link
		def shorten
			if !self.website.blank?
				#Initialise the client with the access token
				client = Bitly::API::Client.new(token: '6f41c471139ad3328c6bb2227aebbed73a78876e')
				#shorten the website link 
				bitlink_shorten = client.shorten(long_url: self.website)
				self.url_short = bitlink_shorten.link
			end
		end

		#Extract the h1, h2, and h3 from the given website. Populate heading1, heading2 and heading3
		def set_headings
			begin
		    agent = Mechanize.new
		    page = agent.get(self.website)
		    self.heading1 = page.at('h1').try(:content)
		    self.heading2 = page.at('h2').try(:content)
		    self.heading3 = page.at('h3').try(:content)
		  rescue Mechanize::ResponseCodeError => e
		  	Rails.logger.error e
		  rescue Exception => e
		  	Rails.logger.error e
  		end
		end
end

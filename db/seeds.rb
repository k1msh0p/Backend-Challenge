# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Loading some dummy data
member = Member.create(name: "Tester1 John", website: "https://techcrunch.com/")
member2 = Member.create(name: "Tester2 John", website: "https://kottke.org/")
member3 = Member.create(name: "Tester3 John", website: "https://en.m.wikipedia.org/wiki/Marathon")
member4 = Member.create(name: "Tester4 John", website: "https://www.sidehustlenation.com/")
member5 = Member.create(name: "Tester5 John", website: "https://smittenkitchen.com/")
member6 = Member.create(name: "Tester6 John", website: "https://www.styleanderror.co.uk/")

friend = Friend.create(member_id: member.id, friend_id: member4.id)
friend = Friend.create(member_id: member.id, friend_id: member6.id)
friend = Friend.create(member_id: member6.id, friend_id: member4.id)


    # member = Member.new
    # member.name = 'Tester1'
    # member.website = 'https://techcrunch.com/'
    # member.save!

    # member2 = Member.new
    # member2.name = 'Tester2'
    # member2.website = 'https://kottke.org/'
    # member2.save!

    # member3 = Member.new
    # member3.name = 'Tester3'
    # member3.website = 'https://en.m.wikipedia.org/wiki/Marathon'
    # member3.save!

    # member4 = Member.new
    # member4.name = 'Tester4'
    # member4.website = 'https://www.sidehustlenation.com/'
    # member4.save!

    # member5 = Member.new
    # member5.name = 'Tester5'
    # member5.website = 'https://smittenkitchen.com/'
    # member5.save!

    # member6 = Member.new
    # member6.name = 'Tester6'
    # member6.website = 'https://www.styleanderror.co.uk/'
    # member6.save!



    # friend = Friend.new
    # friend.member_id = member.id
    # friend.friend_id = member4.id
    # friend.save!

    # friend = Friend.new
    # friend.member_id = member.id
    # friend.friend_id = member6.id
    # friend.save!


    # friend = Friend.new
    # friend.member_id = member6.id
    # friend.friend_id = member4.id
    # friend.save!
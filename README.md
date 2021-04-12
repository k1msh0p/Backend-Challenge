== README

# EverlyWell Backend Challenge

### Overview

Using Ruby on Rails, we'd like you to create a simple experts directory search tool. The tool can either be a full featured application or API only.

* Spend no more than 4 hours coding for the project. Do not include any initial application setup in this time limit.

### Completed list

* A member can be created using their name and a personal website address.
	- Name
	- Website

* When a member is created, all the heading (h1-h3) values are pulled in from the website to that members profile.
	Using Mechanize gem to scrape h1-h3 
	- Heading 1
	- Heading 2
	- Heading 3

* The website url is shortened (e.g. using http://goo.gl) by calling Bitly API

* After the member has been added, I can define their friendships with other existing members. Friendships are bi-directional i.e. If David is a friend of Oliver, Oliver is always a friend of David as well.

* The interface should list all members with their name, short url and the number of friends.

* Viewing an actual member should display the name, website URL, shortening, website headings, and links to their friends' pages.

* Now, looking at Alan's profile, I want to find experts in the application who write about a certain topic and are not already friends of Alan.
	- Page contain a search field

* Results should show the path of introduction from Alan to the expert e.g. Alan wants to get introduced to someone who writes about 'Dog breeding'. Claudia's website has a heading tag "Dog breeding in Ukraine". Bart knows Alan and Claudia. An example search result would be Alan -> Bart -> Claudia ("Dog breeding in Ukraine").

	- Sample output is  "Expert is Claudia. Your connecting path(s): ( Alan -> Bart -> Claudia )"


* Ruby version
2.7.2

### Setup
$ docker-compose build 

$ docker-compose run --rm web bundle exec rails db:reset

### Tests
$ docker-compose run --rm web bundle exec rspec

### Start
$ docker-compose up -d

### Run
open http://localhost:3000






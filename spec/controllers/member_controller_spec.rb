require 'rails_helper'

RSpec.describe MembersController, :type => :controller do
  subject { 
    Member.new(name: "John Doe", 
                       website: "https://www.example.com")  
  }

  describe "index" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
      expect(response.body).to eq ""
    end
  end

  describe "GET new" do
    it "has a 200 status code" do
      get :new
      expect(response.status).to eq(200)
    end
  end

  describe 'POST /members' do
    it "responds to html by default" do
      post :create, :params => { :member => { :name => "Tester6", :website => "https://www.wikipedia.org" } }
      expect(response.content_type).to eq "text/html"
    end
  end

  describe "GET #define_friend" do

    it "has a 200 status code" do
      subject.save
      get :define_friend, params: { id: subject.id }
      expect(response.status).to eq(200)
    end
  end

  describe "GET #save_friend" do
    
    it "has a 200 status code" do
      subject.save
      member2 = Member.create(name: "Tester2 John", website: "https://en.wiktionary.org/wiki/-pedia")
      get :define_friend, params: { id: subject.id, friend_id: member2.id }
      expect(response.status).to eq(200)
    end
  end

  describe "GET #search_expert" do
    before(:each) { 
      subject.save
      get :search_expert, params: { id: subject.id }
    }

    it "has a 200 status code" do
      expect(response.status).to eq(200)
    end

    it "renders the search_expert template" do
      expect(response).to render_template("search_expert")
      expect(response.body).to eq ""
    end
  end


  describe "POST #search_expert_result" do
    before(:each) { 
      subject.save
      member2 = Member.create(name: "Tester2 John", website: "https://www.wikipedia.org")
      post :search_expert_result, params: { id: subject.id, :search => "wikipedia" }
    }

    it "responds to html by default" do
      expect(response.content_type).to eq "text/html"
    end

    it "has 'wikipedia' expert named Tester2 John" do
      expect(response).to render_template("search_expert")
      expect(response.body).to eq ""
      expect(assigns(:result)).to include(match(/.Tester2 John./)) 
    end
  end


  describe "GET #show" do
    before(:each) { 
      subject.save
      get :show, params: { id: subject.id }
    }

    it "renders the #show view" do
      expect(response).to  render_template :show
    end
  end
end

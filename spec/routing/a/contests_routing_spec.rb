require "spec_helper"

describe A::ContestsController do
  describe "routing" do

    it "routes to #index" do
      get("/a/contests").should route_to("a/contests#index")
    end

    it "routes to #new" do
      get("/a/contests/new").should route_to("a/contests#new")
    end

    it "routes to #show" do
      get("/a/contests/1").should route_to("a/contests#show", :id => "1")
    end

    it "routes to #edit" do
      get("/a/contests/1/edit").should route_to("a/contests#edit", :id => "1")
    end

    it "routes to #create" do
      post("/a/contests").should route_to("a/contests#create")
    end

    it "routes to #update" do
      put("/a/contests/1").should route_to("a/contests#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/a/contests/1").should route_to("a/contests#destroy", :id => "1")
    end

  end
end

require 'spec_helper'

describe NdlBooksController do
  fixtures :all

  it "should be a kind of enju_ndl" do
    assert_kind_of Module, EnjuNdl
  end

  describe "GET index" do
    login_fixture_admin
    use_vcr_cassette "enju_ndl/search", :record => :new_episodes

    it "should get index" do
      get :index, :query => 'library'
      assigns(:books).should_not be_empty
    end

    it "should be empty if a query is not set" do
      get :index
      assigns(:books).should be_empty
    end
  end
end

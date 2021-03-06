require 'spec_helper'
describe Ishapi::ReportsController do
  render_views
  routes { Ishapi::Engine.routes }
  before :each do
    do_setup
    allow(controller).to receive(:current_user).and_return( User.new({ profile: ::IshModels::UserProfile.new }) )
    @report.photo = Photo.create :photo => File.open( Rails.root.join 'data', 'photo.png' ) 
    @report.save.should eql true
  end

  context '#index' do
    it 'renders' do
      get :index, :format => :json
      response.should be_success
    end

    it 'shows all the images, not just thumb' do
      get :index, :format => :json
      results = JSON.parse response.body
      results[0]['photos']['thumb_url'].should_not eql nil
    end
  end

  context '#show' do
    it 'renders' do
      get :show, :params => { :name_seo => @report.name_seo }
      response.should be_success
      response.should render_template 'show'
    end

    it 'shows all images' do
      get :show, :params => { :name_seo => @report.name_seo }
      results = JSON.parse response.body
      results['photo']['large_url'].should_not eql nil
    end
  end

end

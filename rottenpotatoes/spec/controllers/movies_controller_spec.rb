require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
    
    fixtures :movies
    
    
    describe 'when the specified movie has a director' do
        
        it 'routes to same_director view' do
            get :same_director, id: 1
            expect(response).to render_template('same_director')
        end
    
        it "should contain movies with same director" do
          movies = Movie.find(1).with_same_director
          get :same_director, id: 1
          expect(assigns(:movies)).to eq(movies)
        end
        
    end


    describe 'when the specified movie has no director' do
        
        it 'routes to movies list' do
            get :same_director, id: 3
            expect(response).to redirect_to(action: 'index', controller: 'movies')
        end
        
        
        it "should contain movies with same director" do
          get :same_director, id: 3
          expect(flash[:notice]).to be_present
        end
        
        
        
    end
    
end

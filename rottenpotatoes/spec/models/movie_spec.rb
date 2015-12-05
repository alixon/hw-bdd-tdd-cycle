require 'rails_helper'

RSpec.describe Movie, type: :model do
  
  fixtures :movies
  
  describe 'movies with same director' do
      
      it 'should find movies with same director' do
          
        expect( Movie.find(1).with_same_director.length ).to eq(2) 
          
      end
      
      it 'should not find movies with diffrent director' do
          
        expect( Movie.find(3).with_same_director.length ).to eq(0)
          
      end
      
  end
  
end

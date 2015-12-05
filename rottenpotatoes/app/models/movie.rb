class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  
  def with_same_director
    unless self.director.nil?
      Movie.where director: self.director
    else
      []
    end
  end
  
end

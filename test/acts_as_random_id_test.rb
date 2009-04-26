#require 'test/unit'
require File.dirname(__FILE__) + '/test_helper.rb'

class ActsAsRandomIdTest < Test::Unit::TestCase
  load_schema

  class Comment < ActiveRecord::Base
    acts_as_random_id
  end
  
  class Group < ActiveRecord::Base
    acts_as_random_id :generator => :auto_increment
  end
  
  class Article < ActiveRecord::Base
    acts_as_random_id :generator => Proc.new { Time.now.to_i }
  end

  def test_should_empty
    assert_equal [], Comment.all
  end
  
  def test_type_random_id
    assert Comment.generate_random_id
    assert Comment.create
  end
  
  def test_type_auto_incriment
    assert Group.generate_random_id
    g1 = Group.create
    g2 = Group.create
    
    assert g1.id < g2.id 
  end
  
  def test_generator_proc
    puts Article.generate_random_id
    assert Article.generate_random_id
  end

end

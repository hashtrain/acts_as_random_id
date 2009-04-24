#require 'test/unit'
require File.dirname(__FILE__) + '/test_helper.rb'

class ActsAsRandomIdTest < Test::Unit::TestCase
  load_schema

  class Comment < ActiveRecord::Base
    acts_as_random_id
  end

  def test_should_empty
    assert_equal [], Comment.all
  end

  def test_shouul_create_with_rundom_id
    last_id = 0
    
    9.times do |i|
      c = Comment.create(:comment => "comment_text_#{i}")
      assert false unless c.id > last_id
      last_id = c.id
    end
    assert true
  end

end

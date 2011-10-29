#require 'test/unit'
require File.dirname(__FILE__) + '/test_helper.rb'

class ActsAsRandomIdTest < Test::Unit::TestCase
  load_schema

  class Comment < ActiveRecord::Base
    acts_as_random_id
  end

  class Payment < ActiveRecord::Base
    acts_as_random_id :field => :secure_identifier do
      Time.now.to_i
    end
  end

  class Group < ActiveRecord::Base
    acts_as_random_id do
      rand(9) + 1
    end
  end

  class Article < ActiveRecord::Base
    acts_as_random_id do
      Time.now.to_i
    end
  end

  def test_random_id
    assert Comment.create
  end

  def test_generator_rand_9
    9.times do
      g = Group.create
      assert g.id <= 9 && g.id > 0
    end
  end

  def test_generator_with_time_now
    a = Article.create
    assert_equal Time.now.to_i, a.id
  end

  def test_should_assign_custom_field
    p = Payment.create
    assert_equal Time.now.to_i, p.secure_identifier
  end
end

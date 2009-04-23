#require 'test/unit'
require File.dirname(__FILE__) + '/test_helper.rb'

class ActAsRandomIdTest < Test::Unit::TestCase
  load_schema

  class Comment < ActiveRecord::Base
    act_as_random_id
  end
  class Group < ActiveRecord::Base
  end

  def test_should_empty
    assert_equal [], Comment.all
    assert_equal [], Group.all
  end

  def test_shouul_create_with_rundom_id
    ActiveRecord::Base.connection.execute("ALTER TABLE `comments` CHANGE `id` `id` BIGINT( 20 ) NOT NULL AUTO_INCREMENT")

    9999.times do |i|
    c = Comment.create(:comment => "comment_text_#{i}")
    c = Comment.create(:comment => "comment_text_#{i}")
    end
  end
end

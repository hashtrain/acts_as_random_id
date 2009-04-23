# ActsAsRandomId
# Generate unique ID: XXXXXXYYYYY
#
# where
# - XXXXXX - result returned on request SELECT max (primary_key) FROM table_name minus 5 right numbers (YYYYY) plus rand (20) - get the next increment value
# - YYYYY - the result of the function rand (first 5 or last 5 numbers)
#
# So we will always have 1 extra SQL and a unique id of the object
# The model will look like this:
#
# class Comment <ActiveRecord:: Base
#   Act_as_random_id # this plugin
# end
#
# When a pattern is not broken at the connection object and it will work with all known me DB

module ActsAsRandomId
  def self.included(base)
    base.send :extend, ClassMethods 
  end

  module ClassMethods 
    def acts_as_random_id
      before_create :generate_random_id
      
      def get_new_random_id
        max_id                 = ActiveRecord::Base.connection.select_value("SELECT max(#{self.primary_key}) FROM #{self.table_name}")
        max_id_size            = max_id.to_s.size
        current_auto_incriment = (max_id_size > 5) ? max_id.to_s.first(max_id_size - 5).to_i : max_id.to_i
        new_auto_incriment     = (current_auto_incriment + rand(19) + 1).to_i
        new_id                 = (new_auto_incriment.to_s + rand.to_s.last(5).to_s).to_i
        new_id
      end
      
      send :include, InstanceMethods
    end
  end

  module InstanceMethods
    protected
    def generate_random_id
      self.id = self.class.get_new_random_id
    end
  end
end

ActiveRecord::Base.send :include, ActsAsRandomId
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
    def acts_as_random_id(options = {})
      cattr_accessor :random_id_type, :random_id_step
      before_create  :generate_random_id

      self.random_id_type = (options[:type] || :auto_increment)
      self.random_id_step = (options[:step] || 10).to_i
      self.random_id_step = 1 if self.random_id_step <= 0

      def generate_random_id
        case self.random_id_type
        when :auto_increment
          auto_increment
        else
          indentation_right
        end
      end
      
      def auto_increment
        max_id = ActiveRecord::Base.connection.select_value("SELECT max(#{self.primary_key}) FROM #{self.table_name}").to_i
        max_id + self.random_id_step
      end
      
      def indentation_right
        max_id                 = ActiveRecord::Base.connection.select_value("SELECT max(#{self.primary_key}) FROM #{self.table_name}")
        max_id_size            = max_id.to_s.size
        current_auto_incriment = (max_id_size > 5) ? max_id.to_s.first(max_id_size - 5).to_i : max_id.to_i
        new_auto_incriment     = (current_auto_incriment + rand(self.random_id_step) + 1).to_i
        new_id                 = (new_auto_incriment.to_s + rand.to_s.last(5).to_s).to_i
        new_id
      end
      
      send :include, InstanceMethods
    end
  end

  module InstanceMethods
    protected
    def generate_random_id
      self.id = self.class.generate_random_id
    end
  end

end

ActiveRecord::Base.send :include, ActsAsRandomId
module ActsAsRandomId
  def self.included(base)
    base.send :extend, ClassMethods 
  end

  module ClassMethods 
    def acts_as_random_id(options = {})
      cattr_accessor :random_id_generator 
      before_create  :generate_random_id

      self.random_id_generator = (options[:generator] || :random_id)

      def generate_random_id
        if self.random_id_generator.is_a?(Proc)
          self.random_id_generator.call
        elsif self.random_id_generator == :auto_increment
          self.auto_increment
        else
          self.random_id
        end
      end

      protected
      def auto_increment
        current_id  = ActiveRecord::Base.connection.select_value("SELECT max(#{self.primary_key}) FROM #{self.table_name}").to_i
        current_id += rand(10) + 1
      end

      def random_id
        begin
          rand_id = rand(2_147_483_647) + 1 #- mysql type "int 4 bytes"
        end until ActiveRecord::Base.connection.select_value("SELECT #{self.primary_key} FROM #{self.table_name} WHERE #{self.primary_key} = #{rand_id}").blank?
        rand_id
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
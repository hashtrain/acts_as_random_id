module ActsAsRandomId

  def self.included(base)
    base.send :extend, ClassMethods
    
    def ensure_unique_id
      begin
        self.id = yield
      end while self.class.exists?(:id => self.id)
    end
  end

  module ClassMethods
    def acts_as_random_id(options={}, &block)
      before_create do |record|
        if block
          record.ensure_unique_id(&block)
        else
          record.ensure_unique_id do
            rand(2_147_483_647) + 1 # mysql and SQLite type integer
          end
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, ActsAsRandomId
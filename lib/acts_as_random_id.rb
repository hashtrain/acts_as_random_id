module ActsAsRandomId

  def self.included(base)
    base.send :extend, ClassMethods
    
    def ensure_unique_id(options)
      begin
        self.send "#{options[:field]}=", yield
      end while self.class.exists?(options[:field] => self.send(options[:field]))
    end
  end

  module ClassMethods
    # Default options:
    # :field => :id
    def acts_as_random_id(options={:field => :id}, &block)
      before_create do |record|
        if block
          record.ensure_unique_id(options, &block)
        else
          record.ensure_unique_id(options) do
            rand(2_147_483_647) + 1 # mysql and SQLite type integer
          end
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, ActsAsRandomId
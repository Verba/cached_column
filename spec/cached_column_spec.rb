require 'cached_column'
require 'nulldb'

ActiveRecord::Base.establish_connection :adapter => :nulldb,
                                        :schema  => File.expand_path("../schema.rb", __FILE__)

describe CachedColumn do
  let :model do
    Class.new(ActiveRecord::Base) do
      self.table_name = 'test'

      def cached_column(value = 42)
        value
      end

      def calculating_method
        43
      end
    end
  end

  describe "when saving" do
    it "sets the attribute value to the result of the method of the same name" do
      model.cached_column :cached_column
      instance = model.new
      instance.save
      instance[:cached_column].should == 42
    end

    it "sets the attribute value to the result of the specified method" do
      model.cached_column :cached_column, :method => :calculating_method
      instance = model.new
      instance.save
      instance[:cached_column].should == 43
    end

    it "sets the attribute value to the result of instance evaluating the block" do
      model.cached_column(:cached_column) { calculating_method }
      instance = model.new
      instance.save
      instance[:cached_column].should == 43
    end

    it "allows the original method to be called" do
      model.cached_column :cached_column
      instance = model.new
      instance.save
      instance.cached_column(44).should == 44
    end

    it "caches false" do
      model.cached_column(:boolean) { false }
      instance = model.new
      instance.save!
      instance[:boolean].should == false
    end
  end
end

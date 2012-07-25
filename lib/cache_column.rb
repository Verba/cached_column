require 'active_record'

class CacheColumn
  attr_accessor :column, :options, :instance_method

  def initialize(column, instance_method, options = {})
    @column          = column
    @options         = options
    @instance_method = instance_method
  end

  def before_save(record)
    record.send("#{column}=", instance_method.bind(record).call)
  end
end

class ActiveRecord::Base
  def self.cache_column(column, options = {})
    before_save CacheColumn.new(column, instance_method(options[:method] || column), options)
    define_method_attribute(column.to_s)
  end
end

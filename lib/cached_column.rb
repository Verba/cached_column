require 'active_record'

class CachedColumn
  attr_accessor :column, :options, :block

  def initialize(column, options = {}, &block)
    @column  = column
    @options = options
    @block   = block
  end

  def before_save(record)
    record.send("#{column}=", computed_value(record))
  end

  def computed_value(record)
    if block
      record.instance_eval(&block)
    else
      record.send(options[:method] || column)
    end
  end
end

class ActiveRecord::Base
  def self.cached_column(column, options = {}, &block)
    before_save CachedColumn.new(column, options, &block)
  end
end

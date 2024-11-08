require 'date'

class Entry
  attr_accessor :content
  attr_reader :date

  def initialize(content, date = Date.today)
    @content = content
    @date = date
  end
end

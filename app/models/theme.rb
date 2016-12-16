class Theme
  attr_accessor :id, :name

  def initialize(options = {})
    @id = options[:id]
    @name = options[:name]
  end
end

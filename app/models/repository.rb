class Repository
  attr_reader :name, :owner, :description, :url, :stars

  def initialize(**attrs)
    @name = attrs[:name]
    @owner = attrs[:owner]

    @description = attrs[:description]
    @stars = attrs[:stars]
    @url = attrs[:url]

    validate_present_attributes!
  end

  private

  def validate_present_attributes!
    attrs = instance_variables.map(&method(:instance_variable_get))

    raise "Repository attributes cannot be empty!" if attrs.any?(&:nil?)
  end
end

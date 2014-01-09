require "dotenv"

Dotenv.load

require "vinery"
require "minitest/autorun"

class Object
  def attributes
    instance_variables.map { |iv| iv.to_s.gsub(/^@/, "") }
  end
end

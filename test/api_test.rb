require "test_helper"

class ApiTest < MiniTest::Unit::TestCase
  def test_invalid_login
    assert_raises Vinery::InvalidCredentialsError do
      Vinery::API.new("", "")
    end
  end

  def test_tagged
    vine = Vinery::API.new(ENV["VINE_USERNAME"], ENV["VINE_PASSWORD"])
    refute_nil vine.tagged("funny") # TODO: make this better
  end
end

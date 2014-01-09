require "test_helper"

class RecordTest < MiniTest::Unit::TestCase
  def setup
    @vinery = Vinery::API.new(ENV["VINE_USERNAME"], ENV["VINE_PASSWORD"])
    @record = @vinery.tagged("funny").first
  end

  def test_to_h
    record_hash = @record.to_h
    @record.attributes.each do |attribute|
      assert_equal @record.send(attribute), record_hash[attribute]
    end
  end

  def test_to_json
    record_json = JSON.parse(@record.to_json)
    
    @record.attributes.each do |attribute|
      assert_equal @record.send(attribute), record_json[attribute]
    end
  end
end

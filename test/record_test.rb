require "test_helper"

class RecordTest < MiniTest::Unit::TestCase
  def setup
    @vinery = Vinery::API.new(ENV["VINE_USERNAME"], ENV["VINE_PASSWORD"])
    @record = @vinery.tagged("funny").first
  end

  def test_to_h
    record_hash = @record.to_h
    record_attributes.each do |attribute|
      assert_equal @record.send(attribute), record_hash[attribute]
    end
  end

  def test_to_json
    record_json = JSON.parse(@record.to_json)
    
    record_attributes.each do |attribute|
      assert_equal @record.send(attribute), record_json[attribute]
    end
  end

  private

  def record_attributes
    @record.instance_variables.map { |iv| iv.to_s.gsub(/^@/, "") }
  end
end

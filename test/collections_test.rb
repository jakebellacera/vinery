require "test_helper"

class CollectionsTest < MiniTest::Unit::TestCase
  def test_to_json
    vinery = Vinery::API.new(ENV["VINE_USERNAME"], ENV["VINE_PASSWORD"])
    records = vinery.tagged("funny")
    records_json = records.to_json
    assert_equal records[0].thumbnail_url, JSON.parse(records_json)[0]["thumbnail_url"]
  end
end

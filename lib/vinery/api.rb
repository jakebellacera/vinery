require "httparty"

module Vinery
  # Public: The unofficial interface for the Vine API. Vine requires all
  # requests to be authenticated when accessing the API.
  # 
  # Examples
  # 
  #   vine = Vine.new("username", "password")
  #   funny_vines = vine.tagged("funny")
  class API
    include HTTParty
    base_uri "https://api.vineapp.com"

    # Public: Initializes a new Vine API instance.
    # 
    # username - The String Vine username.
    # password - The String Vine password.
    # 
    # Examples
    # 
    #   Vine.new("username", "password")
    #   # => #<Vine:0x007fe052036670>
    # 
    # Returns the new Vine instance.
    def initialize(username, password)
      login(username, password)
    end

    # Public: fetches a list of Vines that are tagged with a certain tag.
    # 
    # tag   - The String tag to search for.
    # query - The Hash options used to refine the selection (default: {}).
    #         :page - The Integer page number to paginate results (default: 1).
    #         :size - The Integer number of results to display (default: 20).
    # 
    # Examples
    # 
    #   tagged("funny")
    #   
    #   tagged("funny", { page: 2, size: 10 })
    # 
    # Returns a Hash of Vines.
    def tagged(tag, query = {})
      query = {
        page: 1,
        size: 20 
      }.merge!(query)

      Collection.new(get_parsed("/timelines/tags/#{tag}", query)["records"].map { |r| Record.new(r) })
    end

    private

    # Private: authenticates a Vine user with the Vine API. This method only needs
    # to be ran once per Vine instance.
    # 
    # username - The String Vine username.
    # password - The String Vine password.
    # 
    # Returns nothing.
    def login(username, password)
      response = self.class.post("/users/authenticate", {
        body: {
          username: username,
          password: password
        }
      })

      body = parse_json(response.body)

      @auth = {
        user_id: body["data"]["userId"],
        key: body["data"]["key"]
      }
    end

    # Private: performs an HTTP GET request with required headers.
    # 
    # url     - The String URL that we would GET. The URL should be relative to the
    #           Vine API's domain.
    # query   - The Hash of query key/value pairs (default: {}).
    # headers - The Hash of additional HTTP request headers (default: {}).
    #
    # Returns an instance of HTTParty::Response.
    def get(url, query = {}, headers = {})
      headers.merge!({
        "User-Agent" => "com.vine.iphone/1.0.3 (unknown, iPhone OS 6.0.1, iPhone, Scale/2.000000)",
        "Accept-Language" => "en, sv, fr, de, ja, nl, it, es, pt, pt-PT, da, fi, nb, ko, zh-Hans, zh-Hant, ru, pl, tr, uk, ar, hr, cs, el, he, ro, sk, th, id, ms, en-GB, ca, hu, vi, en-us;q=0.8",
        "vine-session-id" => @auth[:key]
      })

      self.class.get(url, { query: query, headers: headers })
    end

    # Private: perfoms the get method and parses the response.
    # 
    # Returns a Hash of the HTTP GET response body.
    def get_parsed(*get_args)
      response = send(:get, *get_args)
      parse_json(response.body)["data"]
    end

    # Private: parses a JSON String.
    # 
    # string - The String of JSON.
    # 
    # Returns a the parsed JSON as a Hash.
    def parse_json(string)
      JSON.parse(string)
    end
  end
end

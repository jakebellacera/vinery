module Vinery
  # Public: A Vine post. Contains attributes and helper methods for working with
  # a specific post.
  class Record
    attr_reader :description, :id, :raw, :share_url, :thumbnail_url, :user_id, :venue, :video_url

    # Public: Initializes a new Record instance.
    # 
    # data - A Hash that contains the posting's attributes. Typically this is
    #        a record from a parsed JSON response.
    # 
    # Returns the new Vine instance.
    def initialize(data)
      @description = data["description"]
      @id = data["postId"]
      @raw = data
      @share_url = data["shareUrl"]
      @thumbnail_url = data["thumbnailUrl"]
      @user_id = data["userId"]
      @venue = data["venue_name"]
      @video_url = data["videoUrl"]
    end

    # Public: Converts the Record into a Hash.
    # 
    # Returns the String representation of the Record.
    def to_h
      h = {}
      attributes.each do |attribute|
        h[attribute] = send(attribute)
      end
      h
    end

    # Public: Converts the Record into JSON.
    # 
    # Returns the String raw JSON data of the record.
    def to_json(*a)
      to_h.to_json(*a)
    end

    # Public: Produces a human-readable representation of the Record.
    # 
    # Returns the String representation of the Record.
    def inspect
      "<#{self.class} @id=\"#{@id}\" @video_url=\"#{@video_url}\" @description=\"#{@description}\">"
    end

    # Public: Produces a HTML iframe embed tag.
    # 
    # type       - A Symbol that specifies the type of embed layout to display.
    #              Possible types are :simple and :postcard (default: :simple).
    #              If the type is not allowed, it will revert to :simple.
    # html_attrs - A Hash of HTML attributes for the iframe tag (default: {}).
    #              Any keys with an underscore ("_") will be replaced with a 
    #              hyphen ("-").
    # 
    # Examples
    #   
    #   record.embed_tag
    #   # => '<iframe src=".../embed/simple"></iframe>'
    #   
    #   record.embed_tag(:postcard)
    #   # => '<iframe src=".../embed/postcard"></iframe>'
    #   
    #   record.embed_tag(:simple, {
    #     width: 600,
    #     height: 600,
    #     id: "vine-video",
    #     class: "class1 class2",
    #     data_foo: "bar"
    #   })
    #   # => '<iframe src="..." width="600" height="600" id="vine-video"
    #        class="class1 class2" data-foo="bar"></iframe>'
    def embed_tag(type = :simple, html_attrs = {})
      allowed_types = [:simple, :postcard]
      type = :simple unless allowed_types.include?(type)
      attrs = ""
      html_attrs = attrs.each do |attr, val|
        attrs << " #{attr.to_s.replace('_', '-')}=\"#{val}\""
      end

      "<iframe src=\"#{@share_url}/embed/#{type}\"#{attrs}></iframe>"
    end
  end
end

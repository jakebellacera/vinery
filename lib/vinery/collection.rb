module Vinery
  # Public: An array-like object that contains Records. This class inherits from
  # Array.
  # 
  # Examples
  # 
  #   collection = Collection.new
  #   collection.add(record1)
  #   collection << record2
  #   
  #   collection = Collection.new([record1, record2, record3])
  class Collection < Array
    # Public: Appends a new Record to the end of a Collection.
    # 
    # record - The Record to be appended to the end of the Collection.
    # 
    # Examples
    # 
    #   collection.push(record)
    # 
    # Returns the array of Records.
    def add(record)
      raise TypeError, "the object you're tyring to add is not a Record" unless record.is_a? Record
      super(record)
    end
    alias_method :<<, :add
  end
end

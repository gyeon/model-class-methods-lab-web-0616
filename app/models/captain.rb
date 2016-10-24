class Captain < ActiveRecord::Base
  has_many :boats
  has_many :boat_classifications, through: :boats
  has_many :classifications, through: :boat_classifications

  def self.catamaran_operators
    self.joins(:classifications).where("classifications.name = 'Catamaran'")
  end

  def self.sailors
    # binding.pry
    # returns captains with sailboats
    self.joins(:classifications).where("classifications.name = 'Sailboat'").uniq
  end

  def self.motorboats
    self.joins(:classifications).where("classifications.name = 'Motorboat'").uniq
  end

  def self.talented_seamen
    # returns captains of motorboats and sailboats
    sailboat_captains = self.sailors.pluck(:name)
    #this returns all the sailboat captains names
    motorboat_captains = self.motorboats.pluck(:name)
    #this returns all the motorboat captains names
    # binding.pry
    #now to get both, map through sailboat captains and motorboat captains and find the names that are repeated?
    combined = sailboat_captains + motorboat_captains
    talented_seamen = combined.select {|name| combined.count(name) > 1}.uniq
  end

  def self.non_sailors
    # returns people who are not captains of sailboats
    non = self.all - sailors
    captains = []
    non.map{|non_sailors| captains << non_sailors.name}
    # binding.pry
    captains
  end

end

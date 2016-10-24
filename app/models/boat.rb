class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    boat = Boat.limit(5)
  end

  def self.dinghy
    boat = Boat.where("length < 20")
  end

  def self.ship
    boat = Boat.where("length > 20")
  end

  def self.last_three_alphabetically
    boat = Boat.limit(3).order('name desc') #OR (name: :desc)
  end

  def self.without_a_captain
    boat = Boat.where(captain_id: nil)
  end

  def self.sailboats
    Classification.find_by_name('Sailboat').boats
  end

  def self.with_three_classifications
   self.joins(:boat_classifications).group("boat_classifications.boat_id").having("count(boat_id) = 3")
  end


end

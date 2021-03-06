class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride
    case
    when !user_has_enough_tickets && !user_tall_enough
      "Sorry. You do not have enough tickets to ride the #{attraction.name}. You are not tall enough to ride the #{attraction.name}."
    when user_has_enough_tickets && !user_tall_enough
      "Sorry. You are not tall enough to ride the #{attraction.name}."
    when !user_has_enough_tickets && user_tall_enough
      "Sorry. You do not have enough tickets to ride the #{attraction.name}."
    else
      user.tickets -= attraction.tickets
      user.happiness += attraction.happiness_rating
      user.nausea += attraction.nausea_rating
      user.save
    end
  end

  private
  
  def user_tall_enough
    user.height.to_i >= attraction.min_height.to_i
  end

  def user_has_enough_tickets
    user.tickets.to_i >= attraction.tickets.to_i
  end
end

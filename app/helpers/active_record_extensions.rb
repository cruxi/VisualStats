class ActiveRecord::Base
  def equal_values(other)
    (attributes.keys - ["id","created_at","updated_at"]).each do |attr|
     unless self.send(attr).activerecord_equality( other.send(attr))
       puts "====#{self.class} #{self.id} ==== missmatch #{attr} #{self.send(attr)} <=> #{other.send(attr)}  (#{self.send(attr).class}) (#{other.send(attr).class})"
       return false
     end
    end
    return true
   end
   def diff_attributes(other,ignore =[])
    result = []
    (attributes.keys - ["id","created_at","updated_at"]- ignore).each do |attr|
     unless self.send(attr).activerecord_equality( other.send(attr))
       result << "====#{self.class} #{self.id} ==== missmatch #{attr} #{self.send(attr)} <=> #{other.send(attr)}  (#{self.send(attr).class}) (#{other.send(attr).class})"
     end
    end
    result
   end
end

class Object
  def activerecord_equality(other_object)
    self == other_object
  end
end
class ActiveSupport::TimeWithZone
  #2012-09-23T15:35:31Z <=> 2012-09-23 15:35:31 UTC
  def activerecord_equality(other_object)
    if (other_object.class == String)
      return self == Time.zone.parse(other_object)
    else
      return self.to_i == other_object.to_i
    end
  end
end
class String
  def activerecord_equality(other_object)
    return self == other_object unless other_object.class == ActiveSupport::TimeWithZone
    Time.zone.parse(self) == other_object
  end
end

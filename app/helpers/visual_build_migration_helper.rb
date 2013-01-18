module VisualBuildMigrationHelper
	class VisualBuild <  ActiveRecord::Base
		def self.webhook_json(build)
			json = Travis::Api.data(build, :for => 'webhook', :type => 'build/finished', :version => 'v1')
		end

    def self.create_from_build_via_json(build)
      json = VisualBuild.webhook_json(build)
      vb = VisualBuild.create_from_json(json)
      VisualBuild.cross_check(vb,build)
      vb
    end

    def self.cross_check(visual_build,build,message ="")
      s = build.matrix.size
      build.logger.warn("matrix size unequal #{build.id} / #{message}") unless s == visual_build.jobs.size
      unless s == 0
        unless (l1 = build.matrix.first.config[:language]) == (l2 = visual_build.jobs.first.language)
          build.logger.warn("languages unequal #{build.id} / #{message} / #{l1} / #{l2}")
        end
      end
    end
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

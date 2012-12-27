class VisualJob < ActiveRecord::Base
  belongs_to :build, class_name: "VisualBuild"
  has_many :dimensions, class_name: "VisualDimension", foreign_key: :job_id

  def init_from_json(json)
    #repository_id build_url
#:id,
      f = [:number,:state,:finished_at,:result,:allow_failures]
      f.each do | field |
      #  puts "======== field #{field}nil #{json[field.to_s]}" unless json[field.to_s]
        self.send( "#{field}=",json[field.to_s])
        #puts ".send( #{field}= #{json[field.to_s]})"
      end

      config = json["config"]
      self.language = config["language"]
      dimension_keys = config.keys & VisualBuild::ENV_KEYS
      self.allow_failures = extract_allow_failures(dimension_keys,config)

      self.save


      dimension_keys.each do | key |
        self.dimensions.create!(key: key, value: config[key])
      end

      return self
  end
  def extract_allow_failures(keys,config)
    allowed_to_fail = false
     # "matrix":{"allow_failures":[{"rvm":     "2.0.0"}]},
     config["matrix"]["allow_failures"].each do | allowed_to_fail |
        allowed_to_fail.each_pair do | k,v|
          allowed_to_fail = true if config[k] == v
        end
      end
  end

end

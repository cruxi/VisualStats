class VisualJob < ActiveRecord::Base
  belongs_to :build, class_name: "VisualBuild"
  has_many :dimensions, class_name: "VisualDimension", foreign_key: :job_id, dependent: :destroy


  def init_from_json(json)
      f = [:number,:state,:finished_at,:result,:allow_failure]
      f.each do | field |
        self.send( "#{field}=",json[field.to_s])
      end
      self.travis_id = json["id"]

      config = json["config"]
      self.language = config[:language] || config["language"]

      dimension_keys = config.keys.map(&:to_s) & VisualBuild::ENV_KEYS
      self.allow_failure = extract_allow_failure(dimension_keys,config)
      dimension_keys.each do | key |
        value = config[key.to_s]
        value = config[key.to_sym] unless value
        self.dimensions.build(key: key, value: value)
      end

      return self
  end



  def extract_allow_failure(keys,config)
     # e.g. failures allowed if ruby 2.0.0:
     # "matrix":{"allow_failures":[{"rvm":     "2.0.0"}]},
     # this is how it looks with more lines in .travis.yml
     #{"allow_failures":[{"rvm":"2.0.0"},{"rvm":"2.0.1"},{"env":"DB=XYZ"}]},
     if (config["matrix"]!=nil)
       config["matrix"]["allow_failures"].each do | allowed_to_fail |
          allowed_to_fail.each_pair do | k,v|
            return true if config[k] == v
          end
        end
      end
      return false
  end

end

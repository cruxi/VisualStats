class VisualRepository < ActiveRecord::Base

  attr_accessible :name, :owner_name, :url

  has_many :builds, class_name: "VisualBuild", foreign_key: :repository_id

  def self.get_or_create_from_json(json)
    existing = self.find_by_travis_id(json["id"])
    return existing if existing
    self.create_from_json(json)
  end
  def self.create_from_json(json)
    r = self.new(json)
    r.travis_id = json["id"]
    r.save
    r
  end
end

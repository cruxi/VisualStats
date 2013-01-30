class VisualRepository < ActiveRecord::Base

  attr_accessible :name, :owner_name, :url

  has_many :builds, class_name: "VisualBuild", foreign_key: :repository_id, dependent: :destroy

#CLASS METHODS

  def self.get_or_create_from_repository(repository)
    if existing = self.find_by_travis_id(repository.id)
      return existing
    else
      self.create_from_repository(repository)
    end
  end
  def create_from_repository(repository)
    r = self.new
    r.name = repository.name
    r.owner_name = repository.owner_name
    r.save
    r
  end


  def self.get_or_create_from_json(build,json)
    existing = self.find_by_travis_id(json["id"])
    if existing
      build.repository = existing
      return existing
    else
      r = self.build_from_json(build,json)
      r.save
      r
    end
  end

  def self.build_from_json(build,json)
    travis_id = json["id"]
    json.delete("id")
    r = build.build_repository(json)
    r.travis_id = travis_id
    r
  end

  # name: pos / neg
  # x: dates
  # y: fail / success
  def self.getRepositoryDrawData(id)
  
  data = Array.new
  names = ['fail', 'success']

  builds = VisualBuild.where(repository_id: id).where("finished_at IS NOT NULL").order(:finished_at)
  
  for i in 0..1 do

    data[i] = Hash.new 
    singleEntry = data[i]
    singleEntry['name'] = names[i]

    finishedAtDateTimes = Array.new
    results             = Array.new
    builds.each do |build|
      if build.result == i        # result 1 -> success
        results << 1
        finishedAtDateTimes << build.finished_at
      end
    end

    singleEntry['x'] = finishedAtDateTimes
    singleEntry['y'] = results

  end

  return data
  end

  def self.getUser
    owners =  VisualRepository.select(:owner_name).uniq.order(:owner_name)
    user = Array.new

    owners.each do |owner|
      user << owner.owner_name
      puts owner.owner_name
    end 

    return user
  end 
end

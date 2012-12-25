namespace :db do
  desc "Fill compact tables with sample data"
  task populateMore: :environment do
    require 'populator'
    require 'faker'
    
    [RepositoryCompact, BuildCompact, JobCompact].each(&:delete_all)
    
    30.times do |r|
     repository = RepositoryCompact.create!(
      name: Faker::Name.name,
      description: Populator.sentences(1),
      owner_name: Faker::Name.name,
      url: Faker::Internet.url)

      1..20.times do |b|
         build = repository.build_compacts.create!(
            config: Faker::Config,
            result: rand(0..1),
            number: b,
            finished_at: rand(-200..200).days.ago)

        1..5.times do |j|
           job = build.job_compacts.create!(
              allow_failure: rand(0..1),
              finished_at: build.finished_at-rand(10..150),
              language: ["ruby", "php", "java", "c", "python", "rubinius", "jruby"].sample,
              version: rand(1.0 .. 2.0),
              result: rand(0..1))
        end
      end
    end

  end
end
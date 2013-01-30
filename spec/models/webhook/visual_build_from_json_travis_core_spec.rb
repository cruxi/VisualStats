require 'spec_helper'
require 'support/utilities'

describe VisualBuild do
  # there are strange things in VisualDimension
  # => [#<VisualDimension id: 2628520, job_id: 1928843, key: "rvm", value: "jruby-head">, #<VisualDimension id: 2628521, job_id: 1928843, key: "jdk", value: "---\n- oraclejdk7\n- openjdk6\n">, #<VisualDimension id: 2628522, job_id: 1928843, key: "env", value: "JRUBY_OPTS=\"--server -Xcext.enabled=false -Xcompile...">]
  # d.h. value "---\n- oraclejdk7\n- openjdk6\n" scheint falsch zu sein

  # der fehler kommt aber von travis und ist auch
  # auf der seite zu sehen - siehe
  # https://travis-ci.org/travis-ci/travis-core/builds/2224302

  # insgesamt gibt es 699 VD. mit diesem Fehler:
  #1.9.3-p362 :078 > VisualDimension.where("value like ?","%\n%").count
  # => 699

  # some tests to start to analyse this:
  describe "initialization from json" do
    let(:visual_build_core){ VisualBuild.create_from_json_str(read_file_to_s(__FILE__,"json/build_core.json")) }

    describe "strange thing for travis-core" do
      subject{ visual_build_core }
      it "has 8 jobs in matrix" do
        subject.jobs.count.should == 8
      end
      it "has the right stuff in the dimensions" do
        #puts subject.jobs.inject([]){|s,job| s << job.dimensions}.flatten.map(&:value).inspect
      end

    end
  end
end


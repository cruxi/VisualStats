require 'spec_helper'
require 'support/utilities'

describe VisualRepository do
  let(:rep_json) { read_file_to_json(__FILE__,"json/single_repository.json")}
  subject{ VisualRepository.build_from_json(VisualBuild.new,rep_json)}
  its(:travis_id) { should ==          366197}
  its(:name) { should ==       "VisualStats"}
  its(:owner_name) { should == "bkleinen"}
  its(:url) { should ==        "https://github.com/bkleinen/VisualStats"}
end

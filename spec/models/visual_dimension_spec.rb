require 'spec_helper'

describe VisualDimension do
  describe "equality" do
      d1 = VisualDimension.kv(:rvm,"1.9.3")
      d2 = VisualDimension.kv(:rvm,"1.9.3")
      d1.save
      d2.save
      d1.equalsDimension(d2).should == true
   end
   describe "equality ignores symbols" do
      d1 = VisualDimension.kv(:rvm,"1.9.3")
      d2 = VisualDimension.kv("rvm","1.9.3")
      d1.save
      d2.save
      d1.equalsDimension(d2).should == true
   end
end

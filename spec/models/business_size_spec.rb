require 'spec_helper'

describe BusinessSize do
  it "should not allow the same name within the same competition" do
    size1 = BusinessSize.new :name => 'test', :lower_bound => 9, :upper_bound => 12, :competition_id => 999
    size1.save
    size2 = BusinessSize.new :name => 'test', :lower_bound => 13, :upper_bound => 15, :competition_id => 999
    size2.save
    size2.should have(1).error_on(:name)
  end
  
  it "should allow the same name on different competitions" do
    size1 = BusinessSize.new :name => 'test', :lower_bound => 9, :upper_bound => 12, :competition_id => 999
    size1.save
    size2 = BusinessSize.new :name => 'test', :lower_bound => 13, :upper_bound => 15, :competition_id => 998
    size2.save
    size2.should have(0).error_on(:name)
  end
  
  it "should not allow lower bound greater than upper bound" do
    subject.upper_bound = 1
    subject.lower_bound = 5
    subject.should have(1).error_on(:upper_bound)
  end
  
  it "should not allow upper bound in range of another size" do
    size1 = BusinessSize.new :name => 'test', :lower_bound => 9, :upper_bound => 12, :competition_id => 999
    size1.save
    size2 = BusinessSize.new :name => 'overlap', :lower_bound => 5, :upper_bound => 10, :competition_id => 999
    size2.save
    size2.should have(1).error_on(:upper_bound)
  end
  
  it "should not allow lower bound in range of another size" do
    size1 = BusinessSize.new :name => 'test', :lower_bound => 9, :upper_bound => 12, :competition_id => 999
    size1.save
    size2 = BusinessSize.new :name => 'overlap', :lower_bound => 10, :upper_bound => 15, :competition_id => 999
    size2.save
    size2.should have(1).error_on(:lower_bound)
  end
  
end

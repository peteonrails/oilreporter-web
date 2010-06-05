require File.dirname(__FILE__) + '/../spec_helper'

describe ApplicationHelper do
  it 'should return the current year' do
    helper.current_year.should == Time.now.year
  end
end
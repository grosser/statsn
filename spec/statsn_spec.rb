require "spec_helper"

describe Statsn do
  it "has a VERSION" do
    Statsn::VERSION.should =~ /^[\.\da-z]+$/
  end
end

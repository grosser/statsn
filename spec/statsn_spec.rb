require "spec_helper"

module Foobar
  class TestClass
  end
end

describe Statsn do
  it "has a VERSION" do
    Statsn::VERSION.should =~ /^[\.\da-z]+$/
  end

  describe ".increment" do
    it "calls count api with 1" do
      NewRelic::Agent::Stats.any_instance.should_receive(:record_data_point).with(1)
      Statsn.increment("xxx")
    end

    it "calls count api with given number" do
      NewRelic::Agent::Stats.any_instance.should_receive(:record_data_point).with(3)
      Statsn.increment("xxx", 3)
    end
  end

  describe ".time" do
    it "returns block result" do
      Statsn.time("xxx"){ 4 }.should == 4
    end

    it "raises errors" do
      expect{
        Statsn.time("xxx"){ raise EOFError }
      }.to raise_error(EOFError)
    end

    it "records used time" do
      NewRelic::Agent::Stats.any_instance.should_receive(:record_data_point).with{|x| x.should be_within(0.05).of(0.1) }
      Statsn.time("xxx"){ sleep 0.1 }
    end
  end

  describe ".data" do
    it "returns data for metrics" do

    end
  end

  describe ".key" do
    it "builds with a string" do
      Statsn.send(:key, "xxx").should == "xxx"
    end

    it "builds with a class and name" do
      Statsn.send(:key, [Foobar::TestClass, "xxx"]).should == "Custom/Foobar/TestClass/xxx"
    end

    it "builds with an instance and name" do
      Statsn.send(:key, [Foobar::TestClass.new, "xxx"]).should == "Custom/Foobar/TestClass/xxx"
    end

    it "ignores nil" do
      Statsn.send(:key, [Foobar::TestClass, nil, nil, "xxx"]).should == "Custom/Foobar/TestClass/xxx"
    end
  end
end

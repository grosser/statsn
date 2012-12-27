require "spec_helper"

describe "statsn-calls" do
  let(:argv){ File.read("#{Bundler.root}/spec/argv.txt").strip }

  before do
    pending "create a spec/argv.txt" unless (argv rescue nil)
  end

  it "gives us some numbers" do
    result = run("#{argv} Controller/api/v2/users/update")
    result.should =~ /^call_count: \d+/
    result.should =~ /^total_call_time: \d+/
    result.should =~ /^response time: \d+/
    result.should =~ /^call per second: \d+/
  end

  it "gives us some numbers for a prefix call" do
    result = run("#{argv} Controller/api/v2/users/*")
    result.should =~ /^call_count: \d+/
    result.should =~ /^total_call_time: \d+/
    result.should =~ /^response time: \d+/
    result.should =~ /^call per second: \d+/
  end

  it "shows help" do
    result = run("--help")
    result.should include("statsn-calls API-KEY")
  end

  it "shows help and fail with invalid args" do
    result = run("asdadsasdasd", :fail => true)
    result.should include("statsn-calls API-KEY")
  end

  it "tell us if the metric is missing" do
    result = run("#{argv} Controller/xxxxxxx", :fail => true)
    result.should include("No data found for Controller/xxxxxxx")
  end

  private

  def run(argv, options={})
    result = `ruby -I #{Bundler.root}/lib #{Bundler.root}/bin/statsn-calls #{argv} 2>&1`
    raise "FAILED: #{result}" if $?.success? == !!options[:fail]
    result
  end
end

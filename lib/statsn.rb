require "statsn/version"
require "newrelic_rpm"

module Statsn
  PREFIX = "Custom"

  class << self
    attr_accessor :api_key

    # Increments the count of the key by the given amount, default 1
    def increment(who, amount = 1)
      stat(key(who)).record_data_point(amount)
    end

    # Times the given block and returns the output of the block
    def time(who, &block)
      trace_execution_unscoped(key(who), {}, &block)
    end

    private

    def stat(key)
      NewRelic::Agent.agent.stats_engine.get_stats_no_scope(key)
    end

    def key(who)
      if who.is_a?(Array)
        model = who.first
        model = case model
        when String then model
        when Class then model.name
        else
          model.class.name
        end
        [PREFIX, model.gsub("::", "/"), *who[1..-1]].compact.join("/")
      else
        who
      end
    end
  end
end

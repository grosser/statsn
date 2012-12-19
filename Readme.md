StatsN: Aggregate statistics using NewRelic's custom metrics.

Install
=======

    gem install statsn

Usage
=====

### Track

    require "statsn"

    Statsn.increment("Custom/Xyz") -> tracked as "Custom/Xyz"
    Statsn.increment([Abc::Xyz, "update"]) -> tracked as "Custom/Abc/Xyz/update"
    Statsn.increment([self, "update"]) -> tracked as "Custom/<class-you-are-in>/update"

    Statsn.increment("Custom/Xyz", 5) -> increment by 5

    Statsn.time("Custom/Abc") do
      sleep 1
    end

### Analyze

    # show all metrics and fields
    curl -H "x-api-key:API_KEY" https://api.newrelic.com/api/v1/applications/12345/metrics.json -> list of all metrics and fields

    # data e.g. with Faraday
    def stats(account_id, application_id, options)
      response = Faraday.new(
        :url => "https://api.newrelic.com/api/v1/accounts/#{account_id}/applications/#{application_id}/data.json",
        :params => options,
        :headers => {"x-api-key" => API_KEY}
      )
      raise response.body unless response.status == 200
      JSON.parse(response.body)
    end

    stats(183, 80164, :metrics => ["ActiveRecord/save"], :field => "average_response_time", :begin => 1.day.ago, :end => Time.now)

Author
======
Original version by [Morten Primdahl](https://github.com/morten)<br/>

[Michael Grosser](http://grosser.it)<br/>
michael@grosser.it<br/>
License: MIT<br/>
[![Build Status](https://travis-ci.org/grosser/statsn.png)](https://travis-ci.org/grosser/statsn)

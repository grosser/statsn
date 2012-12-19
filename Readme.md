StatsN: Aggregate statistics using NewRelic's custom metrics.

Install
=======

    gem install statsn

Usage
=====

# Setup
    require 'statsn'
    Statsn.api_key = "<your new-relic api key>"

# Track
    Statsn.increment("Custom/Xyz") -> tracked as "Custom/Xyz"
    Statsn.increment(Abc::Xyz) -> tracked as "Custom/Abc/Xyz"
    Statsn.time("Custom/Abc") do
      sleep 1
    end

# Analyze

    # show all metrics and fields
    Statsn.info(account_id, application_id)

    # data
    Statsn.data(account_id, application_id, :metrics => ["Custom/Xyz"], :fields => "average_response_time", :begin => 1.day.ago, :end => Time.now)

# TODO
 - support single/multiple :metrics in .data
 - list instructions / command
 - optional :end

Author
======
Inspired by [Morten Primdahl](https://github.com/morten)

[Michael Grosser](http://grosser.it)<br/>
michael@grosser.it<br/>
License: MIT<br/>
[![Build Status](https://travis-ci.org/grosser/statsn.png)](https://travis-ci.org/grosser/statsn)

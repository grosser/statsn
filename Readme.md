StatsN: Aggregate statistics using NewRelic's custom metrics.

Install
=======

```Bash
gem install statsn
```

Usage
=====

### Track

```Ruby
require "statsn"

Statsn.increment("Custom/Xyz") -> tracked as "Custom/Xyz"
Statsn.increment([Abc::Xyz, "update"]) -> tracked as "Custom/Abc/Xyz/update"
Statsn.increment([self, "update"]) -> tracked as "Custom/<class-you-are-in>/update"

Statsn.increment("Custom/Xyz", 5) -> increment by 5

Statsn.time("Custom/Abc") do
  sleep 1
end
```

### Analyze

```
# show all metrics and fields
curl -H "x-api-key:API_KEY" https://api.newrelic.com/api/v1/applications/12345/metrics.json -> list of all metrics and fields

gem install faraday json

# statsn-calls API-KEY ACCOUNT-ID APPLICATION-ID METRIC-NAME
statsn-calls asdhgjasdgjhdasjgahsdasdjghsdjhg 123 1234567 Controller/users/index

call_count: 274909.0
total_call_time: 37585.77862974794
response time: 0.1367208008095331
call per second: 3.18181712962963

# statsn-calls API-KEY ACCOUNT-ID APPLICATION-ID METRIC-NAME-PREFIX
statsn-calls asdhgjasdgjhdasjgahsdasdjghsdjhg 123 1234567 Controller/users/*

call_count: 287300.0
total_call_time: 39330.15688060733
response time: 0.13689577751690682
call per second: 3.3252314814814814
```

Author
======
Original version by [Morten Primdahl](https://github.com/morten)<br/>

[Michael Grosser](http://grosser.it)<br/>
michael@grosser.it<br/>
License: MIT<br/>
[![Build Status](https://travis-ci.org/grosser/statsn.png)](https://travis-ci.org/grosser/statsn)

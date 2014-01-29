blitz.io
========

Performance tests using Blitz.io

This is a very simple script using the Blitz.io Ruby Gem to load up specific
endpoints in supporter.

Setup
-----

`blitz api:init`

Enter api key for EHD Blitz.io account.

`bundle install`

Running
-------

`ruby blitz.rb`

This runs all tests. Note the running tests uses credits from our Blitz.io
account. To run a subset, comment out some lines at the bottom of script.

Modify the script where required to:
  - Run against one environment
  - Run a sprint rather than a rush (sprint method exists already)
  - Update load pattern
  - etc

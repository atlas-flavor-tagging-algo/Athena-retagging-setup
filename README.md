# Athena Retagging Setup

#### Purpose of these scripts:

Setting up Athena with retagging including DL1 in the
FlavourTagPerformance framework according to [recommendations][1]
in one go.

#### How to use it:

1. Start from a new lxplus session.
1. To create a Athena test area, run

   `source create_TestArea.sh <trunk-or-branch> [<path-to-test-area>]`

   where the first argument specifies whether you want to use the
   FlavourTaggingPerformance framework with branch package combination
   setup or using the JetTagTols and BTaggging trunk setup.
   Optionally, you can add the name of the directory in which you want
   your test area to be set up as a second argument. Otherwise,
   you'll be asked to specify it.

1. **Once the test area is already set up**,

    `source setup_TestArea.sh <trunk-or-branch> [<path-to-test-area>]`

    will, when starting another time from a new lxplus session, set up
    Athena in your previously created test area.
    Rules for the arguments remain the same.

That's it.


###### What this will do:

This will get all the packages required to run retagging with the DL1
tagger using the flavourtagging performance framework, whether using
the setup in the trunk or the branches as described in aforementioned
[recommendations][1].
The packages will automatically be compiled and the work area will
be set up.


###### Details on the provided job options (JO):

Retagging will be [switched on][2] and an xAOD which can be used for a
test run is [defined in a public directory][3] as well.  The JO also
define the number of events to run over with the argument given in

``` jp.AthenaCommonFlags.EvtMax.set_Value_and_Lock(10) ```

Setting the argument to `-1` would corresponds to using all events in
the xAOD. The JOs currently set the number of events to 10.  With the
current Athena settings it is also possible to switch to using a local
NN configuration file (in JSON format with special syntax!) that will
be used by DL1 by [defining it][4].


###### About actually using it in a test run:

In order to run the job, go to `$TestArea/run/` and run `athena
jobOptions_Tag.py`.  The ROOT output file where the retagging ouput is
stored in branches is stored as `$TestArea/run/flav_Akt4EMTo.root`.


###### In case of problems:

For feedback, contact me at `marie.christine.lanfermann@cern.ch`.

[1]:https://svnweb.cern.ch/trac/atlasperf/browser/CombPerf/FlavorTag/FlavourTagPerformanceFramework/trunk/xAODAthena/README
[2]:https://github.com/Marie89/ATHENA-retagging-setup/blob/master/jobOptions_Tag.py#L114
[3]:https://github.com/Marie89/ATHENA-retagging-setup/blob/master/jobOptions_Tag.py#L27
[4]:https://github.com/Marie89/ATHENA-retagging-setup/blob/master/jobOptions_Tag.py#L115

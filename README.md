# Athena Retagging Setup

#### Purpose of these scripts:

Setting up Athena with retagging, according to
[Valerio's recommendations][1].

#### How to use:

 1. Start from a new lxplus session.
 2. To create a Athena test area, run

    `. setup-and-build-all.sh <path-to-test-area>`

    This will create a subdirectory and build the required
    packages. If anything goes wrong (i.e. the compilation will
    randomly segfault, the best known solution is to try again), you
    can rerun the individual executables from the
    `<path-to-test-area>` directory.


 3. **If the test area has already been built**,

    `. setup-environment.sh <path-to-test-area>`

    will set up Athena in your previously created test area.  Rules
    for the arguments remain the same.

 4. The Athena Job Options files will be linked under
    `<path-to-test-area>/run`. Go there and run

    `athena {jobOptions_tagdl1.py, jobOptions_tagbb.py}`

That's it.


#### What this will do:

This will get all the packages required to run retagging using the
flavour tagging performance framework. The packages will automatically
be compiled and the work area will be set up.

#### Submitting Grid Jobs

Several scripts are included in `grid-submit-scripts`, the most
important being `simple-grid-sub.sh`. Run with `-h` to get more
information.

#### Details for specific job options (JO):

The `run` currently contains links to two sets of job options. Use
`jobOptions_tagdl1.py` to run DL1 and single-b tagging,
`jobOptions_tagbb.py` for double-b tagging.

##### DL1 job options:

Retagging will be [switched on][2] and an xAOD which can be used for a
test run is [defined in a public directory][3] as well.  The JO also
define the number of events to run over with the argument given in

``` jp.AthenaCommonFlags.EvtMax.set_Value_and_Lock(10) ```

Setting the argument to `-1` would corresponds to using all events in
the xAOD. The JOs currently set the number of events to 10.  With the
current Athena settings it is also possible to switch to using a local
NN configuration file (in JSON format with special syntax!) that will
be used by DL1 by [defining it][4].

#### Outputs:

The ROOT output file with retagged jets is stored as
`$TestArea/run/flav_<jet collection name>.root`.


#### In case of problems:

For feedback, contact me at `marie.christine.lanfermann@cern.ch`.

[1]:https://svnweb.cern.ch/trac/atlasperf/browser/CombPerf/FlavorTag/FlavourTagPerformanceFramework/trunk/xAODAthena/README
[2]:https://github.com/Marie89/ATHENA-retagging-setup/blob/master/jobOptions_Tag.py#L114
[3]:https://github.com/Marie89/ATHENA-retagging-setup/blob/master/jobOptions_Tag.py#L27
[4]:https://github.com/Marie89/ATHENA-retagging-setup/blob/master/jobOptions_Tag.py#L115

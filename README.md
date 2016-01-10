Docker-based test environment for a set of SWI-Prolog packs. The
purpose of the project is to ensure that the packs keep working
on the new SWI-Prolog releases.

Running tests:

    make docker-test

This creates a new docker container based on the mndrix/swipl base image,
clones pack repositories from GitHub, installs dependencies and runs
all tests.

The base image version is contained in the Dockerfile. Needs to be updated
when the new SWI-Prolog releases come out.

Copyright 2016 Raivo Laanemets

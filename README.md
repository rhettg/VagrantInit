# VagrantInit Provisioner

This is a demo / template for a bash-based provisioning using vagrant.

Provisioning can be decomposed into a sequence of steps written in Bash.  As
steps are successfully executed, they are `chmod -x` so they will not run
again.  Fix your script, run again with `vagrant provision`.


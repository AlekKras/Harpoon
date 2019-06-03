# Harpoon

Harpoon allows you to scan your Docker containers for common vulnerabilities using RedLock.

## Use Cases

Let's see if we want to prevent Docker images from being built if they have vulnerabilities?

Sure, we can do that like this:
```
 FROM redmine:4.0.1
 ARG rl_args
 RUN apt-get update && apt-get install -yq curl
 RUN SCAN_CMD=$(eval "curl https://vscanapidoc.redlock.io/scan.sh 2>/dev/null") && echo "$SCAN_CMD" | sh
 ```

 If we build it with `docker build -t redmine -f Dockerfile .` we will get:

 ```
 {
   "Report": {
     "Summary": {
       "high_cve_count": 39,
       "medium_cve_count": 324,
       "low_cve_count": 103,
       "unknown_cve_count": 12,
       "total_cve_count": 478,
       "total_packages_count": 147,
       "failure_reason": "threshold_exceeded"
     }
   }
 }
 The command '/bin/sh -c SCAN_CMD=$(eval "curl https://vscanapidoc.redlock.io/scan.sh 2>/dev/null") && echo "$SCAN_CMD" | sh' returned a non-zero code: 1
 ```

So that means we are building an image that is vulnerable and our build will fail (as expected).

You can find an example of how it works within a folder `ansible-test` where we use Ansible to write a playbook that would do just that.

You can also run the following:
```
./scan.sh image
```
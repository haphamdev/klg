# klg
Viewing logs of Kubernetes pods using [lnav](https://lnav.org/).
This is written in bash script.

# WORK IN PROGRESS
This project is still under development. Hopefully, I can finish it within this week (or maybe two weeks)

# DEPENDENCIES

This tool depends on `lnav` and `kubectl`. Please make sure that you installed [lnav](https://lnav.org/) and your `kubectl` works.

# IT WORKS FOR NOW
You can try it by running the file `./klg.sh`
Usage:
```
./klg.sh [options]
```

Available option:
- `-n`: Keyword to fuzzy search for k8s namespace
- `-p`: Keyword to fuzzy search for k8s pod
- `-c`: Keyword to fuzzy search for container

Example:
```
./klg.sh -n my-namespace -p my-pod -c my-container
```

# GOALS
Finish following features:
- [x] Fuzzy search for k8s namespace/pod/container
- [ ] Using default namespace `default` or `$K8S_DEFAULT_NS`
- [ ] Handle error cases and return error code (e.g. pod not found, namespace not found)


# ALTERNATIVE FOR FISH SHELL
If you are a *fisher* (as I am), please refer to [this file](https://github.com/haphamdev/dot-files/blob/master/fish/functions/klg.fish).

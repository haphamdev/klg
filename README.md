# klg
Viewing logs of Kubernetes pods using [lnav](https://lnav.org/)

# WORK IN PROGRESS
This project is still under development. Hopefully, I can finish it within this week (or maybe two weeks)

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
[] Using default namespace `default` or `$K8S_DEFAULT_NS`
[] Handle error case and return error code (e.g. pod not found, namespace not found)


# ALTERNATIVE FOR FISH SHELL
If you are a *fisher* (as I am), please refer to [this file](https://github.com/haphamdev/dot-files/blob/master/fish/functions/klg.fish).

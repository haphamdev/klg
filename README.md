# klg
Viewing logs of Kubernetes pods using [lnav](https://lnav.org/).
This is written in bash script.
### Why this?
- I am sick of copying long auto-generated pod name before pasting into `kubectl logs` command. K9s can help here.
- My eyes hurt when looking at the wall of log text in the terminal
- I want to filter/search the logs in a professional log viewer
- I want to play with shell script

# DEMO

https://user-images.githubusercontent.com/6322508/200557797-497d9291-2e8d-4bbb-9cb9-9d8f193771ba.mp4


# DEPENDENCIES

This tool depends on `fzf`, `lnav` and `kubectl`. 
- Please make sure that you installed [lnav](https://lnav.org/) 
- Your `kubectl` must work
- Please install [fzf](https://github.com/junegunn/fzf) for fuzzy search

# HOW TO USE

Usage:
```
./klg.sh [options]
```

Available option:
- `-n`: Keyword to fuzzy search for k8s namespace. Ignored when `-N` is specified.
- `-p`: Keyword to fuzzy search for k8s pod. Ignored when `-P` is specified.
- `-c`: Keyword to fuzzy search for container. Ignored when `-C` is specified.
- `-N`: Exact namespace (no searching)
- `-P`: Exact pod name (no searching)
- `-C`: Exact container name (no searching)

Example:
```
./klg.sh

./klg.sh -n my-namespace -p my-pod -c my-container
```

# GOALS
Finish following features:
- [x] Fuzzy search for k8s namespace/pod/container
- [x] Viewing logs in lnav
- [x] Using default namespace `default` or `$K8S_DEFAULT_NS`
- [x] Handle error cases and return error code (e.g. pod not found, namespace not found)


# ALTERNATIVE FOR FISH SHELL
If you are a *fisher* (as I am), please refer to [this file](https://github.com/haphamdev/dot-files/blob/master/fish/functions/klg.fish).

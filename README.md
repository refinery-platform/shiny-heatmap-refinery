# shiny-heatmap-refinery
A simple containerized Shiny App heatmap

## Development

During development, it's easiest to run just the app from inside R Studio:
Bring up `app.R` and hit "Run App" at the top of the editor. Or, from the commandline:

```
$ R -e 'shiny::runApp("context/shiny-app", 8888, host="0.0.0.0")'
```

To exercise the Docker container, use the same scripts as Travis:

```
$ ./test.sh
```


## Release process

Successful Github tags and PRs will prompt Travis to push the built image to Dockerhub. For a new version number:

```
$ git tag v0.0.x && git push origin --tags
```
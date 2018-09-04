# shiny-heatmap-refinery
A simple containerized Shiny App heatmap

## Release process

Successful Github tags and PRs will prompt Travis to push the built image to Dockerhub. For a new version number:

```
$ git tag v0.0.x && git push origin --tags
```
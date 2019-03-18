# scala-base-image
baseimage for scala apps using sbt and universal plugin (zip)

Base layer is the first layer for application images to be built on top.
Since base layer changes are rare and happens only in long term updates it needs to build as own layer to
avoid unnecessary downloads and time consuming installations during build of application layer. Only difference to AdoptOpenJDK's image is that zip is installed to handle app artifacts

[image in dockerhub](https://hub.docker.com/r/dryseawind/java-for-scala)

# Building a new version

``` ./build.sh ```

# Current JDK version

AdoptOpenJKD: jdk8u202

# Backgroud of OpenJDK after January 2019

* The situation of JDK's so far:
[Free Java](https://docs.google.com/document/d/1nFGazvrCvHMZJgFstlbzoHjpAVwv5DEdnaBr_5pKuHo/edit)


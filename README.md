# AWS Lambda Java Base Images

This project provides the missing AWS Lambda base image for Java 17. The base images are publicly available [in the ECR Public Gallery](https://gallery.ecr.aws/m6n4d7c2/sigpwned/aws-lambda-java-base-image). You should be able to use them directly in your builds. I expect to use these base images for production lambda functions reasonably soon, but in the meantime please consider them to be *very experimental*.

## Approach

This project uses the following process to create new Lambda base images:

1. Define a Java maven POM that includes all the [Java Lambda support libraries](https://github.com/aws/aws-lambda-java-libs) as provided scope. This roundabout approach is used to coax @dependabot into flagging new versions as they are published.
2. Also teach maven to collect these dependencies and build the appropriate docker images using the Dockerfile using the excellent [fabric8io/docker-maven-plugin](https://github.com/fabric8io/docker-maven-plugin).
3. Use GitHub Actions to do perform CI/CD and release new images to the ECR Public Gallery.

## Known Issues and Future Plans

* I have built a (very) simple Lambda function using this base image. I will release it as an example soon.
* This image is in no way optimized for cold start time, size, etc.
* For now, only Java 17 is supported. I hope to provide base images for additional versions soon.
* For now, only x86_64 is supported. I hope to publish multiarch builds including arm64 soon.
* I suspect I will also clean up the ECR public gallery presence, but this gets the images out for now.
* Of course, as soon as there *is* an offically-supported AWS Lambda base image for Java 17, everyone should use that instead! But this project should hopefully fill the gap in the meantime, and will (hopefully) support non-LTS Java versions that will never receive an officially-supported AWS Lambda base image by that time.

## Acknowledgements

Many thanks to [@rieckpil](https://github.com/rieckpil) for [his outstanding writeup of custom Lambda runtimes](https://rieckpil.de/java-aws-lambda-container-image-support-complete-guide/). That tutorial was the foundation and basis for this build. Cheers!

Also, thank you to [@msailes](https://github.com/msailes) for [the example Java 17 Lambda layer](https://github.com/msailes/lambda-java17-layer). This prior art was also critically important to understanding how best to integrate a new Java version into Lambda.

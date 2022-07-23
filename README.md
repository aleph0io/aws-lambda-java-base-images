# AWS Lambda Java Base Images

This project provides AWS Lambda function base images for Java 17. I hope to soon provide base images for additional versions.

The base images are publicly available available [in the ECR Public Gallery](https://gallery.ecr.aws/m6n4d7c2/sigpwned/aws-lambda-java-base-image). You should be able to use them directly in your builds.

## Approach

This 


## Acknowledgements

Many thanks to @rieckpil for [his outstanding writeup of custom Lambda runtimes](https://rieckpil.de/java-aws-lambda-container-image-support-complete-guide/). That tutorial was the foundation and basis for this build. Cheers!

Also, thank you to @msailes for [the example Java 17 Lambda layer](https://github.com/msailes/lambda-java17-layer). This prior art was also critically important to understanding how best to integrate a new Java version into Lambda.
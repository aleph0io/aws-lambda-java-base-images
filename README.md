# AWS Lambda Java Base Images

This project provides the missing [AWS Lambda base image](https://docs.aws.amazon.com/lambda/latest/dg/runtimes-images.html) for Java 17, 18, 19, and 20. The base images are publicly available [in the ECR Public Gallery](https://gallery.ecr.aws/aleph0io/lambda/java). You should be able to use them directly in your builds. I use these images in production for personal and commercial projects today, but per the license, they are "use at your own risk."

## Approach

This project uses the following process to create new Lambda base images:

1. Define a Java maven POM that includes all the [Java Lambda support libraries](https://github.com/aws/aws-lambda-java-libs) as provided scope. This roundabout approach is used to coax @dependabot into flagging new versions as they are published.
2. Also teach maven to collect these dependencies and build the appropriate docker images using the Dockerfile using the excellent [fabric8io/docker-maven-plugin](https://github.com/fabric8io/docker-maven-plugin).
3. Use GitHub Actions to do perform CI/CD and release new images to the ECR Public Gallery.

## Example Lambda Function

You can find an example Lambda function using these base images at [aleph0io/example-java-lambda-function](https://github.com/aleph0io/example-java-lambda-function). It's just like building any container lambda function. For ease of use, find the `Dockerfile` below. Note the `FROM` image. Java versions 18-20 are also supported.

    FROM public.ecr.aws/aleph0io/java/lambda:17.0.4-al2
    
    COPY target/hello-lambda.jar "${LAMBDA_TASK_ROOT}/lib/"
    
    CMD [ "com.sigpwned.lambda.hello.HelloLambda::handleRequest" ]

## Testing Lambda Functions Locally

The [Lambda RIE](https://github.com/aws/aws-lambda-runtime-interface-emulator) is not currently built into these lambda base images, so to test your lambda function implementations locally, you will need to [use the standalone RIE server](https://docs.aws.amazon.com/lambda/latest/dg/images-test.html#images-test-add).

## Known Issues and Future Plans

* This image is in no way optimized for cold start time, size, etc. PRs welcome!
* Java 17, 18, 19, and 20 are all supported.
* For now, only x86_64 is supported. I hope to publish multiarch builds including arm64 soon.
* Java 17 preview base images have been released to [lambda/java](https://gallery.ecr.aws/lambda/java). Java 17 users should strongly consider moving to the officially-supported base images, especially once they leave preview.
* This project will continue to support non-LTS Java versions that will never receive an officially-supported AWS Lambda base image.

## More Information

You can find writeups of the [Java 17](https://sigpwned.com/2022/07/23/aws-lambda-base-images-for-java-17/), [18](https://sigpwned.com/2022/08/31/aws-lambda-base-images-for-java-18-too/), [19](https://sigpwned.com/2022/09/21/aws-lambda-base-images-for-java-19/), and [20](https://sigpwned.com/2023/03/24/community-managed-aws-lambda-base-images-for-java-20/) on [my blog](https://sigpwned.com/).

## Acknowledgements

Many thanks to [@rieckpil](https://github.com/rieckpil) for [his outstanding writeup of custom Lambda runtimes](https://rieckpil.de/java-aws-lambda-container-image-support-complete-guide/). That tutorial was the foundation and basis for this build. Cheers!

Also, thank you to [@msailes](https://github.com/msailes) for [the example Java 17 Lambda layer](https://github.com/msailes/lambda-java17-layer). This prior art was also critically important to understanding how best to integrate a new Java version into Lambda.

Managed by [@sigpwned](https://github.com/sigpwned).

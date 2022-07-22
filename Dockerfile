# https://rieckpil.de/java-aws-lambda-container-image-support-complete-guide/

ARG JAVA_VERSION=17.0.3
ARG AWS_LAMBDA_JAVA_CORE_VERSION=1.2.1
ARG AWS_LAMBDA_JAVA_SERIALIZATION_VERSION=1.0.0
ARG AWS_LAMBDA_JAVA_RUNTIME_INTERFACE_CLIENT_VERSION=1.0.0
ARG ORG_CRAC_VERSION=0.1.3

FROM public.ecr.aws/docker/library/eclipse-temurin:${JAVA_VERSION}-jammy

RUN apt-get update \
    && apt-get upgrade -y

ADD https://search.maven.org/remotecontent?filepath=com/amazonaws/aws-lambda-java-core/${AWS_LAMBDA_JAVA_CORE_VERSION}/aws-lambda-java-core-${AWS_LAMBDA_JAVA_CORE_VERSION}.jar /var/runtime/lib/aws-lambda-java-core-${AWS_LAMBDA_JAVA_CORE_VERSION}.jar
ADD https://search.maven.org/remotecontent?filepath=com/amazonaws/aws-lambda-java-serialization/${AWS_LAMBDA_JAVA_SERIALIZATION_VERSION}/aws-lambda-java-serialization-${AWS_LAMBDA_JAVA_SERIALIZATION_VERSION}.jar /var/runtime/lib/aws-lambda-java-serialization-${AWS_LAMBDA_JAVA_SERIALIZATION_VERSION}.jar
ADD https://search.maven.org/remotecontent?filepath=io/github/crac/com/amazonaws/aws-lambda-java-runtime-interface-client/${AWS_LAMBDA_JAVA_RUNTIME_INTERFACE_CLIENT_VERSION}/aws-lambda-java-runtime-interface-client-${AWS_LAMBDA_JAVA_RUNTIME_INTERFACE_CLIENT_VERSION}.jar /var/runtime/lib/aws-lambda-java-runtime-interface-client-${AWS_LAMBDA_JAVA_RUNTIME_INTERFACE_CLIENT_VERSION}.jar
ADD https://search.maven.org/remotecontent?filepath=io/github/crac/org-crac/${ORG_CRAC_VERSION}/org-crac-${ORG_CRAC_VERSION}.jar /var/runtime/lib/org-crac-${ORG_CRAC_VERSION}.jar

ENV LANG=en_US.UTF-8
ENV TZ=:/etc/localtime
ENV PATH=/opt/java/openjdk/bin:/usr/local/bin:/usr/bin:/bin:/opt/bin
ENV LD_LIBRARY_PATH=/lib:/usr/lib:/var/runtime:/var/runtime/lib:/var/task:/var/task/lib:/opt/lib
ENV LAMBDA_TASK_ROOT=/var/task
ENV LAMBDA_RUNTIME_DIR=/var/runtime

ENTRYPOINT [ "/opt/java/openjdk/bin/java", "--class-path", "/var/runtime/lib/:/var/task/lib/:/var/task/", "com.amazonaws.services.lambda.runtime.api.client.AWSLambda" ]

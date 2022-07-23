# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
# 
#   http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

# https://rieckpil.de/java-aws-lambda-container-image-support-complete-guide/

ARG JAVA_VERSION=17
ARG JAVA_REVISION=17.0.3

FROM public.ecr.aws/amazoncorretto/amazoncorretto:${JAVA_REVISION}-al2

COPY target/dependencies/* /var/runtime/lib/

ENV LANG=en_US.UTF-8
ENV TZ=:/etc/localtime
ENV PATH=/opt/java/openjdk/bin:/usr/local/bin:/usr/bin:/bin:/opt/bin
ENV LD_LIBRARY_PATH=/lib:/usr/lib:/var/runtime:/var/runtime/lib:/var/task:/var/task/lib:/opt/lib
ENV LAMBDA_TASK_ROOT=/var/task
ENV LAMBDA_RUNTIME_DIR=/var/runtime

ENTRYPOINT [ "/usr/bin/java", "--class-path", "/var/runtime/lib/*:/var/task/lib/*:/var/task/", "--add-opens", "java.base/java.util=ALL-UNNAMED", "com.amazonaws.services.lambda.runtime.api.client.AWSLambda" ]

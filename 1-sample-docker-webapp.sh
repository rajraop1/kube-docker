
#create a sample docker container


sudo apt-get install unzip 

curl https://start.spring.io/starter.zip \
    -d dependencies=web \
    -d javaVersion=1.8 \
    -d bootVersion=2.3.3.RELEASE \
    -d name=helloworld \
    -d artifactId=helloworld \
    -d baseDir=helloworld \
    -o helloworld.zip
unzip helloworld.zip
cd helloworld


tee > src/main/java/com/example/helloworld/HelloworldApplication.java << EOF
package com.example.helloworld;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
public class HelloworldApplication {

  @Value("${NAME:World}")
  String name;

  @RestController
  class HelloworldController {
    @GetMapping("/")
    String hello() {
      return "Hello " + name + "!";
    }
  }

  public static void main(String[] args) {
    SpringApplication.run(HelloworldApplication.class, args);
  }
}
EOF


tee > src/main/resources/application.properties << EOF
server.port=${PORT:8080}
EOF




tee > Dockerfile << EOF

# Use the official maven/Java 8 image to create a build artifact.
# https://hub.docker.com/_/maven
FROM maven:3.8-jdk-11 as builder

# Copy local code to the container image.
WORKDIR /app
COPY pom.xml .
COPY src ./src

# Build a release artifact.
RUN mvn package -DskipTests

FROM adoptopenjdk/openjdk11:alpine-jre

# Copy the jar to the production image from the builder stage.
COPY --from=0 /app/target/helloworld-*.jar /helloworld.jar

# Run the web service on container startup.
CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/helloworld.jar"]


EOF


tee > .dockerignore << EOF
Dockerfile
.dockerignore
target/

EOF


docker build -t my-server .

docker run -p 8080:8080 my-server


echo login from machine to localhost:8080 and check it says hello world


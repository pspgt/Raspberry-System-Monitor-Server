FROM balenalib/armv7hf-debian


WORKDIR /app
RUN curl -sf  -o dartsdk-linux-arm-release.zip -L https://storage.googleapis.com/dart-archive/channels/stable/release/2.4.1/sdk/dartsdk-linux-arm-release.zip
RUN [ "cross-build-start" ]

RUN apt install unzip
RUN unzip dartsdk-linux-arm-release.zip
ADD dart-sdk /app/dart-sdk
ENV PATH $PATH:dart-sdk/bin

ADD pubspec.* /app/
RUN ls
RUN pub get

ADD . /app
RUN pub get --offline
RUN [ "cross-build-end" ]
CMD []
ENTRYPOINT ["dart", "bin/main.dart"]
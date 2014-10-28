# This docker file sets up a build environment for Android API Level 10
# It sets up the SDK and the NDK for your builds.
# In order to use it, you need to run it with 
# `docker run -v <path to your source>:/src davidsiaw/ndk-env ndk-build`
# By default this will run `ndk-build` and `ant debug`

FROM ubuntu:precise
MAINTAINER David Siaw <davidsiaw@gmail.com>

# Install base packages
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get -yq install \
    	ia32-libs \
    	openjdk-7-jdk \
    	build-essential \
    	ant \
        wget && \
    rm -rf /var/lib/apt/lists/*

# Prepare the SDK and NDK
RUN mkdir /android
ENV ANDROID_HOME /android/android-sdk-linux
WORKDIR /android

RUN wget --timeout=30 http://dl.google.com/android/ndk/android-ndk-r9-linux-x86.tar.bz2 -O ndk.tar.bz2
RUN tar -xf ndk.tar.bz2
RUN wget -q http://dl.google.com/android/android-sdk_r22.0.1-linux.tgz -O sdk.tar.gz
RUN tar xzvf sdk.tar.gz > /dev/null
RUN $ANDROID_HOME/tools/android list sdk
RUN echo "y" | $ANDROID_HOME/tools/android -s update sdk --filter 14,1,2,3 --no-ui
RUN $ANDROID_HOME/tools/android list targets

# Clean up
RUN rm ndk.tar.bz2 sdk.tar.gz

# Set up the build environment
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/android/android-sdk-linux/tools:/android/android-sdk-linux/platform-tools:/android/android-ndk-r9/

ADD build.sh /build.sh
RUN chmod 755 /*.sh

RUN mkdir /src
WORKDIR /src
CMD ["/build.sh"]

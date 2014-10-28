ndk-env
=======

Script for building a docker image that contains an android build environment

This docker file sets up a build environment for Android API Level 10.

It sets up the SDK and the NDK for your builds.

## How to use

In order to use it, you need to run it with:

`docker run -v <path to your source>:/src davidsiaw/ndk-env`

The command above mounts your directory to where the container expects the source to be and builds it.

By default this will run `ndk-build` and `ant debug`. See [build.sh](https://github.com/davidsiaw/ndk-env/blob/master/build.sh)

Also, you can call it with your own command if you want:

`docker run -v <path to your source>:/src davidsiaw/ndk-env make android`

## CBF

If you don't want to build and just want to download the image, you can do that with this command

`docker pull davidsiaw/ndk-env`

## Dependencies

It should be obvious at this point you will need docker to use this.

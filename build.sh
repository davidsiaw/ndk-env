#!/bin/bash
android update project --path . --target "android-10"
ndk-build
ant debug
#!/usr/bin/env groovy

def image = docker.image("centos:latest");
stage 'Mirror'
image.pull()

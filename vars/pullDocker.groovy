#!/usr/bin/env groovy

node {
	
	def image = docker.image("centos:latest");
	stage 'Mirror'
	image.pull()
}

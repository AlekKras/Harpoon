#!/usr/bin/env groovy

def image() {
	docker.image('groovy:2.4').inside {
		sh 'groovy -v'
	}
}

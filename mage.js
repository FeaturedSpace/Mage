#!/usr/bin/env node
"use strict"

var builder = require("./builder.js"),
	server = require('./server.js'),
	colors = require('colors');

module.exports = {
		builder: builder,
		server: server
};

if (process.argv.length) {

	function intro() {
		console.log("\n\n\n--- Mage is a WebGL Game Engine. ---");
		console.log("written by Marco Stagni, thanks MrDoob.");
		console.log("----- < http://marcostagni.com > -----\n\n\n");
	}

	function usage() {
		console.log("USAGE: mage create <projectName>".blue);
		console.log("USAGE: mage serve <port>".blue);
	}

	if (process.argv.length > 2) {

		intro();
		var command = process.argv[2];
		if (command == "create") {
			var location = process.argv[3];
			if (location) {
				builder.create(location)
			} else {
				console.log('Please provide a location for the project'.red);
				usage();
			}
		} else if (command == 'serve') {
			var port = process.argv[3] ? process.argv[3] : 8000;
			server.start(port);
		} else{
			console.log("Sorry, only create and serve methods avaible right now.".red);
			usage();
		}
	} else {
		usage();
	}
}

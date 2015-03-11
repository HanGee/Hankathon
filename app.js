"use strict";

var irc = require('slate-irc');
var net = require('net');
var Brig = require('brig');

var brig = new Brig();

var curColor = 0;
var colors = [
	'#A4C400', '#60A917',
	'#008A00', '#00ABA9',
	'#1BA1E2', '#0050EF',
	'#6A00FF', '#AA00FF',
	'#F472D0', '#D80073',
	'#A20025', '#E51400',
	'#FA6800', '#F0A30A',
	'#E3C800', '#825A2C',
	'#6D8764', '#647687',
	'#76608A', '#87794E'
];

brig.on('ready', function(brig) {

	function getUserColor() {

		var color = colors[curColor];

		curColor++;

		if (curColor == colors.length)
			curColor = 0;

		return color;
	}

	brig.open('app.qml', function(err, window) {

		var names = {};

		var channelName = '#HackathonTaiwan5th';
		var stream = net.connect({
			port: 6667,
			host: 'irc.freenode.org'
		});

		window.emit('updatedIRC', 'Connecting IRC Server...');

		var client = irc(stream);

		client.nick('HackathonTaiwan');
		client.user('HackathonTaiwan', 'Hackathon Taiwan');
		client.join(channelName);

		client.on('welcome', function(msg) {
			console.log('Connected IRC server');
			window.emit('updatedIRC', 'Connected Server');
		});

		client.on('notice', function(msg) {
			console.log(msg.message);

			window.emit('updatedIRC', msg.message);
		});

		client.on('message', function(e) {

			if (e.to != channelName.toLowerCase()) 
				return;

			var msg = e.from + ': ' + e.message;
			console.log(msg);

			var color = names[e.from];
			if (!color) {
				color = getUserColor();
				names[e.from] = color;
			}
			var msgRich = '&lt; <font color="' + color + '">' + e.from + '</font> &gt; ' + e.message;

			window.emit('updatedIRC', msgRich);
		});

		client.on('join', function(msg) {

			if (Object.keys(names).length == 0)
				return;

			names[msg.nick] = getUserColor();
		});

		client.names(channelName, function(err, list) {

			for (var index in list) {
				var name = list[index].name;

				names[name] = getUserColor();
			}
		});
/*
		setInterval(function() {
			window.emit('updatedIRC', ircMsg.join('<br>'));
		}, 800);
*/
	});
});

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- google CDN -->
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link href="./resources/styles/speakingTest.css" rel="stylesheet">
<title>Speak to Text</title>

</head>
<body>
	<h1 class="center" id="headline">Speak to Text</h1>
	<div id="info">
		<p id="info_start">Click on the microphone icon and begin speaking.</p>
		<p id="info_speak_now">Speak now.</p>
		<p id="info_no_speech">
			No speech was detected. You may need to adjust your <a
				href="//support.google.com/chrome/bin/answer.py?hl=en&amp;answer=1407892">
				microphone settings</a>.
		</p>
		<p id="info_no_microphone" style="display: none">
			No microphone was found. Ensure that a microphone is installed and
			that <a href="//support.google.com/chrome/bin/answer.py?hl=en&amp;answer=1407892">
				microphone settings</a> are configured correctly.
		</p>
		<p id="info_allow">Click the "Allow" button above to enable your microphone.</p>
		<p id="info_denied">Permission to use microphone was denied.</p>
		<p id="info_blocked">Permission to use microphone is blocked. To
			change, go to chrome://settings/contentExceptions#media-stream</p>
		<p id="info_upgrade">
			Web Speech API is not supported by this browser. Upgrade to <a
				href="//www.google.com/chrome">Chrome</a> version 25 or later.
		</p>
	</div>
	<div class="right">
		<button id="start_button" onclick="startButton(event)">
			<img id="start_img" src="./resources/images/icons/mic.gif" alt="Start">
		</button>
	</div>
	<form id="sendData" action="sendData" method="post">
		<div id="results">
			<span id="final_span" class="final"></span> <span id="interim_span"	class="interim"></span>
		</div>
	</form>
	<div class="center">
		<div class="sidebyside">
			<button id="finish_button" class="button">Finished</button>
		</div>
	</div>
	<script>
		showInfo('info_start');
		var final_transcript = '';
		var recognizing = false;
		var ignore_onend;
		var start_timestamp;
		if (!('webkitSpeechRecognition' in window)) {
			upgrade();
		} else {
			start_button.style.display = 'inline-block';
			var recognition = new webkitSpeechRecognition();
			recognition.continuous = true;
			recognition.interimResults = true;

			recognition.onstart = function() {
				recognizing = true;
				showInfo('info_speak_now');
				start_img.src = './resources/images/icons/mic-animate.gif';
			};

			recognition.onerror = function(event) {
				if (event.error == 'no-speech') {
					start_img.src = './resources/images/icons/mic.gif';
					showInfo('info_no_speech');
					ignore_onend = true;
				}
				if (event.error == 'audio-capture') {
					start_img.src = './resources/images/icons/mic.gif';
					showInfo('info_no_microphone');
					ignore_onend = true;
				}
				if (event.error == 'not-allowed') {
					if (event.timeStamp - start_timestamp < 100) {
						showInfo('info_blocked');
					} else {
						showInfo('info_denied');
					}
					ignore_onend = true;
				}
			};

			recognition.onend = function() {
				recognizing = false;
				if (ignore_onend) {
					return;
				}
				start_img.src = './resources/images/icons/mic.gif';
				if (!final_transcript) {
					showInfo('info_start');
					return;
				}
				showInfo('');
				if (window.getSelection) {
					window.getSelection().removeAllRanges();
					var range = document.createRange();
					range.selectNode(document.getElementById('final_span'));
					window.getSelection().addRange(range);
				}
			};

			recognition.onresult = function(event) {
				var interim_transcript = '';
				for (var i = event.resultIndex; i < event.results.length; ++i) {
					if (event.results[i].isFinal) {
						final_transcript += event.results[i][0].transcript;
					} else {
						interim_transcript += event.results[i][0].transcript;
					}
				}
				final_transcript = capitalize(final_transcript);
				final_span.innerHTML = linebreak(final_transcript);
				interim_span.innerHTML = linebreak(interim_transcript);
				if (final_transcript || interim_transcript) {
					showButtons('inline-block');
				}
			};
		}

		function upgrade() {
			start_button.style.visibility = 'hidden';
			showInfo('info_upgrade');
		}

		var two_line = /\n\n/g;
		var one_line = /\n/g;
		function linebreak(s) {
			return s.replace(two_line, '<p></p>').replace(one_line, '<br>');
		}

		var first_char = /\S/;
		function capitalize(s) {
			return s.replace(first_char, function(m) {
				return m.toUpperCase();
			});
		}

		$(function() {
			$('#finish_button').on('click', function() {
				finish_button.style.display = 'none';
				var sendData = $('#final_span').text();
				opener.setSttData(sendData);
				window.close();
			});
		});

		function startButton(event) {
			if (recognizing) {
				recognition.stop();
				return;
			}
			final_transcript = '';
			recognition.lang = 'en-US';
			recognition.start();
			ignore_onend = false;
			final_span.innerHTML = '';
			interim_span.innerHTML = '';
			start_img.src = './resources/images/icons/mic-slash.gif';
			showInfo('info_allow');
			showButtons('none');
			start_timestamp = event.timeStamp;
		}

		function showInfo(s) {
			if (s) {
				for (var child = info.firstChild; child; child = child.nextSibling) {
					if (child.style) {
						child.style.display = child.id == s ? 'inline' : 'none';
					}
				}
				info.style.visibility = 'visible';
			} else {
				info.style.visibility = 'hidden';
			}
		}

		var current_style;
		function showButtons(style) {
			if (style == current_style) {
				return;
			}
			current_style = style;
			finish_button.style.display = style;
		}
	</script>
</body>
</html>
/*
*  Copyright (c) 2015 The WebRTC project authors. All Rights Reserved.
*
*  Use of this source code is governed by a BSD-style license
*  that can be found in the LICENSE file in the root of the source
*  tree.
*/

// This code is adapted from
// https://rawgit.com/Miguelao/demos/master/mediarecorder.html

'use strict';

/* globals MediaRecorder */

var mediaSource = new MediaSource();
var mediaRecorder;
var recordedBlobs;
var sourceBuffer;


// 실행용 비디오 이벤트
var startButton = document.querySelector('button#startInterview');
var recordedVideo = document.querySelector('video#recorded');


// 녹화 버튼 클릭시 이벤트
var recordButton = document.querySelector('button#record');


// 플레이 버튼 클릭시 이벤트
var playButton = document.querySelector('button#play');





// window.isSecureContext could be used for Chrome
var isSecureOrigin = location.protocol === 'https:' || location.hostname === 'localhost';
if (!isSecureOrigin) {
  alert('getUserMedia() must be run from a secure origin: HTTPS or localhost.\n\nChanging protocol to HTTPS');
  location.protocol = 'HTTPS';
}

var constraints = {
  audio: true,
  video: true
};

function handleSourceOpen(event) {
  console.log('MediaSource opened');
  sourceBuffer = mediaSource.addSourceBuffer('video/webm; codecs="vp8"');
  console.log('Source buffer: ', sourceBuffer);
}

function handleDataAvailable(event) {
  if (event.data && event.data.size > 0) {
    recordedBlobs.push(event.data);
  }
}

function handleStop(event) {
  console.log('Recorder stopped: ', event);
}

function startRecording() {
  recordedBlobs = [];
  let options = {mimeType: 'video/webm;codecs=vp9'};
  if (!MediaRecorder.isTypeSupported(options.mimeType)) {
    console.log(options.mimeType + ' is not Supported');
    options = {mimeType: 'video/webm;codecs=vp8'};
    if (!MediaRecorder.isTypeSupported(options.mimeType)) {
      console.log(options.mimeType + ' is not Supported');
      options = {mimeType: 'video/webm'};
      if (!MediaRecorder.isTypeSupported(options.mimeType)) {
        console.log(options.mimeType + ' is not Supported');
        options = {mimeType: ''};
      }
    }
  }
  try {
    mediaRecorder = new MediaRecorder(window.stream, options);
  } catch (e) {
    console.error(`Exception while creating MediaRecorder: ${e}`);
    alert(`Exception while creating MediaRecorder: ${e}. mimeType: ${options.mimeType}`);
    return;
  }
  console.log('Created MediaRecorder', mediaRecorder, 'with options', options);
  recordButton.textContent = 'Stop Recording';
  playButton.disabled = true;
  downloadButton.disabled = true;
  mediaRecorder.onstop = handleStop;
  mediaRecorder.ondataavailable = handleDataAvailable;
  mediaRecorder.start(10); // collect 10ms of data
  console.log('MediaRecorder started', mediaRecorder);
}

function stopRecording() {
  mediaRecorder.stop();
  console.log('Recorded Blobs: ', recordedBlobs);
  recordedVideo.controls = true;
}

function handleSuccess(stream) {
  recordButton.disabled = false;
  console.log('getUserMedia() got stream: ', stream);
  window.stream = stream;

  const gumVideo = document.querySelector('video#gum');
  gumVideo.srcObject = stream;
}

function handleError(error) {
  console.log('navigator.getUserMedia error: ', error);
}


function init(){
	if(startButton != null){
		startButton.addEventListener('click', () => {
			  if (startButton.textContent === '시작하기') {
			    
			  }
			});
	}
	if(playButton != null){
	playButton.addEventListener('click', () => {
		  const superBuffer = new Blob(recordedBlobs, {type: 'video/webm'});
		  recordedVideo.src = window.URL.createObjectURL(superBuffer);
		  // workaround for non-seekable video taken from
		  // https://bugs.chromium.org/p/chromium/issues/detail?id=642012#c23
		  recordedVideo.addEventListener('loadedmetadata', () => {
		    if (recordedVideo.duration === Infinity) {
		      recordedVideo.currentTime = 1e101;
		      recordedVideo.ontimeupdate = function() {
		        recordedVideo.currentTime = 0;
		        recordedVideo.ontimeupdate = function() {
		          delete recordedVideo.ontimeupdate;
		          recordedVideo.play();
		        };
		      };
		    } else {
		      recordedVideo.play();
		    }
		  });
		});
	}
	if(recordedVideo != null){
	recordedVideo.addEventListener('error', function(ev) {
		  console.error('MediaRecording.recordedMedia.error()');
		  alert(`Your browser can not play ${recordedVideo.src} media clip. event: ${JSON.stringify(ev)}`);
		}, true);
	}
	if(recordButton != null){
		navigator.mediaDevices.getUserMedia(constraints).then(handleSuccess).catch(handleError);
		mediaSource.addEventListener('sourceopen', handleSourceOpen, false);

	startRecording();
	recordButton.addEventListener('click', () => {
		  if (recordButton.textContent === 'Start Recording') {
		    startRecording();
		  } else {
		    stopRecording();
		    recordButton.textContent = 'Start Recording';
		    playButton.disabled = false;
		    downloadButton.disabled = false;
		  }
		});
	}
}

init();
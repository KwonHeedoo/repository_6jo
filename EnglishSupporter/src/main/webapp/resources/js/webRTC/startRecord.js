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

const mediaSource = new MediaSource();
mediaSource.addEventListener('sourceopen', handleSourceOpen, false);
let mediaRecorder;
let recordedBlobs;
let sourceBuffer;


//실행용 비디오 이벤트
const recordedVideo = document.querySelector('video#recorded');
recordedVideo.addEventListener('error', function(ev) {
  console.error('MediaRecording.recordedMedia.error()');
  alert(`Your browser can not play ${recordedVideo.src} media clip. event: ${JSON.stringify(ev)}`);
}, true);

//녹화 버튼 클릭시 이벤트
const recordButton = document.querySelector('button#record');
recordButton.addEventListener('click', () => {
    startRecording();
});


const startButton = document.querySelector('button#start');
startButton.addEventListener('click', () => {
    startRecording();
    console.log("record start!");
});

/*const endButton = document.querySelector('button#end');
endButton.addEventListener('click', () => {

});*/

const playButton = document.querySelector('button#end');
playButton.addEventListener('click', () => {
	stopRecording();
	uploadVideo();	
	
	console.log(recordedVideo.src);
/*	if(recordedVideo.src != ""){
		recordedVideo.src="";
	}
*/	const superBuffer = new Blob(recordedBlobs, {type: 'video/webm'});
	recordedVideo.src = window.URL.createObjectURL(superBuffer);
	recordedVideo.load();
  // workaround for non-seekable video taken from
  // https://bugs.chromium.org/p/chromium/issues/detail?id=642012#c23
  recordedVideo.addEventListener('loadedmetadata', () => {
    if (recordedVideo.duration === Infinity) {
      recordedVideo.currentTime = 1e101;
      recordedVideo.ontimeupdate = function() {
        recordedVideo.currentTime = 0;
        recordedVideo.ontimeupdate = function() {
          delete recordedVideo.ontimeupdate;
          //recordedVideo.play();
        };
      };
    } else {
     //recordedVideo.play();
    	
    }
  });
});


// window.isSecureContext could be used for Chrome
let isSecureOrigin = location.protocol === 'https:' || location.hostname === 'localhost';
if (!isSecureOrigin) {
  alert('getUserMedia() must be run from a secure origin: HTTPS or localhost.\n\nChanging protocol to HTTPS');
  location.protocol = 'HTTPS';
}

const constraints = {
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

function uploadVideo(){
	const blob = new Blob(recordedBlobs, {type: 'video/webm;codecs=vp9'});
	  var file = new File([blob], "test.webm", { type: "video/webm;codecs=vp9", lastModified: Date.now()});
	  var data;
	  data = new FormData();
	  data.append('file', file);
	  data.append('questionNum', questions[count].questionNum);
	  console.log(JSON.stringify(data));
	  const download = document.getElementById("download");
	  $.ajax({
	      url: 'savedata',
	      data: data,
	      processData: false,
	      contentType: false,
	      type: 'POST',
	      enctype: 'multipart/form-data',
	      success: function (data) {
	    	  document.getElementById("datanum").value = data;
	    	  console.log(document.getElementById("datanum").value);
	    	  download.href = "getdata?dataNum="+data;
	      },
	  		error: function(){
	  		}
	  });
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

navigator.mediaDevices.getUserMedia(constraints).then(handleSuccess).catch(handleError);

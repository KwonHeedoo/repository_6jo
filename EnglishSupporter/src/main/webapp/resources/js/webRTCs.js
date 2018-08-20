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


/*//실행용 비디오 이벤트
const recordedVideo = document.querySelector('video#recorded');
recordedVideo.addEventListener('error', function(ev) {
  console.error('MediaRecording.recordedMedia.error()');
  alert(`Your browser can not play ${recordedVideo.src} media clip. event: ${JSON.stringify(ev)}`);
}, true);*/

//녹화 버튼 클릭시 이벤트
const startButton = document.querySelector('button#startInterview');

const recordButton = document.querySelector('button#nextQuestion');
recordButton.addEventListener('click', () => {
  if (recordButton.textContent === 'NEXT QUESTION') {
    stopRecording();
    const blob = new Blob(recordedBlobs, {type: 'video/webm'});
    var file = new File([blob], "test.webm", { type: "video/webm", lastModified: Date.now()});
    var data;
    data = new FormData();
    data.append('file', file);
    console.log(JSON.stringify(data));
    $.ajax({
        url: 'savedata',
        data: data,
        processData: false,
        contentType: false,
        type: 'POST',
        // This will override the content type header, 
        // regardless of whether content is actually sent.
        // Defaults to 'application/x-www-form-urlencoded'
        enctype: 'multipart/form-data',
        //Before 1.5.1 you had to do this:
        /*beforeSend: function (x) {
            if (x && x.overrideMimeType) {
                x.overrideMimeType("multipart/form-data");
            }
        },*/
        // Now you should be able to do this:
        //mimeType: 'multipart/form-data',    //Property added in 1.5.1

        success: function (data) {
      	  
            alert(data);
        }
    });
  }
  
});




//다운로드 버튼 클릭시 이벤트
// 현재 서버에 전송하는 것을 담당
const downloadButton = document.querySelector('button#download');
downloadButton.addEventListener('click', () => {
  const blob = new Blob(recordedBlobs, {type: 'video/webm'});
  /*var myReader = new FileReader();
  myReader.onload = function(event){
	    console.log(JSON.stringify(myReader.result));
	};
	myReader.readAsText(blob);*/
  //기본 코드
  /*const url = window.URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.style.display = 'none';
  a.href = url;
  a.download = 'test.webm';
  document.body.appendChild(a);
  a.click();
  setTimeout(() => {
    document.body.removeChild(a);
    window.URL.revokeObjectURL(url);
  }, 100);*/
  
  //추가 코드 1
  /*var xhr = new XMLHttpRequest();
  var formData = new FormData();
  formData.append('blob', blob);
  xhr.open('POST', '/test005/senddata', true);
  xhr.onload = function(e) {
    console.log('Sent');
  };
  xhr.send(formData);
  console.log(xhr.response);*/
  // 추가 코드 2
  var file = new File([blob], "test.webm", { type: "video/webm", lastModified: Date.now()});
  var data;
  data = new FormData();
  data.append('file', file);
  console.log(JSON.stringify(data));
  $.ajax({
      url: 'savedata',
      data: data,
      processData: false,
      contentType: false,
      type: 'POST',
      // This will override the content type header, 
      // regardless of whether content is actually sent.
      // Defaults to 'application/x-www-form-urlencoded'
      enctype: 'multipart/form-data',
      //Before 1.5.1 you had to do this:
      /*beforeSend: function (x) {
          if (x && x.overrideMimeType) {
              x.overrideMimeType("multipart/form-data");
          }
      },*/
      // Now you should be able to do this:
      //mimeType: 'multipart/form-data',    //Property added in 1.5.1

      success: function (data) {
    	  
          alert(data);
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
	navigator.mediaDevices.getUserMedia(constraints).then(handleSuccess).catch(handleError);
	
	startButton.addEventListener('click', () => {
		  if (startButton.textContent === '시작하기') {
		    startRecording();
		  }
		});
}

init();
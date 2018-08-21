
<br>
<button id="btn-start-recording">Start Recording</button>
<button id="btn-stop-recording" disabled>Stop Recording</button>

<hr>
<audio controls id="playaudio"></audio>

<script src="https://cdn.webrtc-experiment.com/RecordRTC.js"></script>
<script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>
<script>
var audio = document.querySelector('#playaudio');

function captureMicrophone(callback) {
    navigator.mediaDevices.getUserMedia({audio: true}).then(callback).catch(function(error) {
        alert('Unable to access your microphone.');
        console.error(error);
    });
}

function stopRecordingCallback() {
    var blob = recorder.getBlob();
    audio.src = URL.createObjectURL(blob);
    audio.play();

    recorder.microphone.stop();
}

var recorder; // globally accessible

document.getElementById('btn-start-recording').onclick = function() {
    //this.disabled = true;
    captureMicrophone(function(microphone) {
        setSrcObject(microphone, audio);
        audio.play();

        recorder = RecordRTC(microphone, {
            type: 'audio',
            recorderType: StereoAudioRecorder,
            desiredSampRate: 16000
        });

        recorder.startRecording();

        // release microphone on stopRecording
        recorder.microphone = microphone;

        document.getElementById('btn-stop-recording').disabled = false;
    });
};

document.getElementById('btn-stop-recording').onclick = function() {
   // this.disabled = true;
    recorder.stopRecording(stopRecordingCallback);
};
</script>
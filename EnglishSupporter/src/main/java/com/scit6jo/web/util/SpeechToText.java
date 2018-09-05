/*
 * Copyright 2018 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.scit6jo.web.util;

// [START speech_quickstart]
// Imports the Google Cloud client library
import com.google.cloud.speech.v1p1beta1.RecognitionAudio;
import com.google.cloud.speech.v1p1beta1.RecognitionConfig;
import com.google.cloud.speech.v1p1beta1.RecognitionConfig.AudioEncoding;
import com.google.cloud.speech.v1p1beta1.RecognizeResponse;
import com.google.cloud.speech.v1p1beta1.SpeechClient;
import com.google.cloud.speech.v1p1beta1.SpeechRecognitionAlternative;
import com.google.cloud.speech.v1p1beta1.SpeechRecognitionResult;
import com.google.protobuf.ByteString;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

public class SpeechToText {

  /**
   * Demonstrates using the Speech API to transcribe an audio file.
   */
  public String ChangeSTT(String audioPathFile) throws Exception {
	  // Instantiates a client
	  System.out.println("audioPathFile in STT : " + audioPathFile);
	  	String ex = "";
	    try (SpeechClient speechClient = SpeechClient.create()) {

	      // The path to the audio file to transcribe

	      // Reads the audio file into memory
	      Path path = Paths.get(audioPathFile);
	      byte[] data = Files.readAllBytes(path);
	      ByteString audioBytes = ByteString.copyFrom(data);

	      // Builds the sync recognize request
	      RecognitionConfig config = RecognitionConfig.newBuilder()
	          .setEncoding(AudioEncoding.LINEAR16)
	          .setSampleRateHertz(16000)
	          .setLanguageCode("en-US")
	          .build();
	      RecognitionAudio audio = RecognitionAudio.newBuilder()
	          .setContent(audioBytes)
	          .build();

	      // Performs speech recognition on the audio file
	      
	      
	      
	      RecognizeResponse response = speechClient.recognize(config, audio);
	      List<SpeechRecognitionResult> results = response.getResultsList();

	      for (SpeechRecognitionResult result : results) {
	        // There can be several alternative transcripts for a given chunk of speech. Just use the
	        // first (most likely) one here.
	        SpeechRecognitionAlternative alternative = result.getAlternativesList().get(0);
	        System.out.printf("Transcription: %s%n", alternative.getTranscript());
	        ex = alternative.getTranscript();
	      }
	    }
	    return ex;
  }
}
// [END speech_quickstart]

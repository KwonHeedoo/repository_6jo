package com.scit6jo.web.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import java.util.regex.Pattern;

public class AudioConverter {
	public static final String FFMPEG_PATH = "C:\\gtj\\ffmpeg\\bin";
	public static final String FFMPEG_EXEC_FILE = "ffmpeg.exe";
	public static final String FILEPATH = "c:\\ES_uploadPath";

	private String fileName;
	private String userName;

	public AudioConverter(String fileName, String userName) {
		super();
		this.fileName = fileName;
		this.userName = userName;
	}

	public String convert() throws Exception {
		String convertPath = FILEPATH + "\\audio\\" + userName;
		File path = new File(convertPath);
		if (!path.isDirectory()) {
			path.mkdirs();
		}
		
		int pos = fileName.lastIndexOf( "." );
		String audioFileName = fileName.substring(0, pos+1) + "wav";
		
		
		// setup the process builder
		String videoPathFile = FILEPATH + "\\video\\" + userName +"\\"+ fileName ;
		String audioPathFile = convertPath +"\\"+ audioFileName ;
		ProcessBuilder pb = new ProcessBuilder(FFMPEG_PATH + "\\" + FFMPEG_EXEC_FILE, // ffmpeg 파일 위치
				"-i", videoPathFile, // 영상 위치
				"-acodec", "pcm_s16le", "-f", "s16le", "-ac", "1", "-ar", "16000", audioPathFile // 처리후 저장 위치 및 형식
		);
		pb.redirectErrorStream(true);

		Process proc = pb.start();

		// capture the output
		InputStreamReader isr = new InputStreamReader(proc.getInputStream());
		BufferedReader br = new BufferedReader(isr);
		List<String> lines = new ArrayList<String>();
		String line;
		while ((line = br.readLine()) != null) {
			lines.add(line);
		}

		// wait to start the next file
		try {
			if (proc.waitFor() != 0) {
				System.out.println("\nRemuxing was interupted\n");
				for (String l : lines) {
					System.out.println(l);
				}
			} else {
				System.out.println("error\n");
			}
		} catch (InterruptedException e) {
			System.out.println("\nRemuxing was interupted\n");
			e.printStackTrace();
		}
		return audioPathFile;
	}

}

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>

    <meta charset="utf-8">
    <meta name="description" content="WebRTC code samples">
    <meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=1, maximum-scale=1">
    <meta itemprop="description" content="Client-side WebRTC code samples">
    <meta itemprop="image" content="../../../images/webrtc-icon-192x192.png">
    <meta itemprop="name" content="WebRTC code samples">
    <meta name="mobile-web-app-capable" content="yes">
    <meta id="theme-color" name="theme-color" content="#ffffff">

    <base target="_blank">

    <title>MediaStream Recording</title>

    <!-- <link rel="icon" sizes="192x192" href="../../../images/webrtc-icon-192x192.png">
    <link href="//fonts.googleapis.com/css?family=Roboto:300,400,500,700" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="../../../css/main.css"> -->
    <link rel="stylesheet" href="./resources/css/webRTC.css">

</head>

<body>

<div id="container">

    <h1><a href="//webrtc.github.io/samples/" title="WebRTC samples homepage">WebRTC samples</a>
        <span>MediaRecorder</span></h1>

    <p>For more information see the MediaStream Recording API <a
            href="http://w3c.github.io/mediacapture-record/MediaRecorder.html"
            title="W3C MediaStream Recording API Editor's Draft">Editor's&nbsp;Draft</a>.</p>

    <video id="gum" playsinline autoplay muted></video>
    <video id="recorded" playsinline loop controls></video>

    <div>
        <button id="record" disabled>Start Recording</button>
        <button id="play" disabled>Play</button>
        <button id="download" disabled>Download</button>
    </div>

    <a href="https://github.com/webrtc/samples/tree/gh-pages/src/content/getusermedia/record"
       title="View source for this page on GitHub" id="viewSource">View source on GitHub</a>

</div>

<!-- include adapter for srcObject shim -->
<script type="text/javascript" src = "./resources/jquery-3.3.1.min.js"></script>
<script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>
<script src="./resources/js/webRTC.js" async></script>
<script src="./resources//js/lib/ga.js"></script>

</body>
</html>

/*
 *  Copyright (c) 2015 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree.
 */

'use strict';

const startButton = document.getElementById('startButton');
const callButton = document.getElementById('callButton');
const hangupButton = document.getElementById('hangupButton');
callButton.disabled = true;
hangupButton.disabled = true;
startButton.addEventListener('click', start);
callButton.addEventListener('click', call);
hangupButton.addEventListener('click', hangup);

let startTime;
const localVideo = document.getElementById('localVideo');
const remoteVideo = document.getElementById('remoteVideo');

localVideo.addEventListener('loadedmetadata', function() {

});

remoteVideo.addEventListener('loadedmetadata', function() {

});

remoteVideo.addEventListener('resize', () => {

  // We'll use the first onsize callback as an indication that video has started
  // playing out.
  if (startTime) {
    const elapsedTime = window.performance.now() - startTime;
    console.log('Setup time: ' + elapsedTime.toFixed(3) + 'ms');
    startTime = null;
  }
});

let localStream;
let pc1;
let pc2;
const offerOptions = {
  offerToReceiveAudio: 1,
  offerToReceiveVideo: 1
};

function getName(pc) {
  return (pc === pc1) ? 'pc1' : 'pc2';
}

function getOtherPc(pc) {
  return (pc === pc1) ? pc2 : pc1;
}

function start() {
  console.log('Requesting local stream');
  startButton.disabled = true;
  try {
    const stream = navigator.mediaDevices.getUserMedia({audio: true, video: true});
    console.log('Received local stream');
    localVideo.srcObject = stream;
    localStream = stream;
    callButton.disabled = false;
  } catch (e) {

  }
}

function getSelectedSdpSemantics() {
  const sdpSemanticsSelect = document.querySelector('#sdpSemantics');
  const option = sdpSemanticsSelect.options[sdpSemanticsSelect.selectedIndex];
  return option.value === '' ? {} : {sdpSemantics: option.value};
}

function call() {
  callButton.disabled = true;
  hangupButton.disabled = false;
  console.log('Starting call');
  startTime = window.performance.now();
  const videoTracks = localStream.getVideoTracks();
  const audioTracks = localStream.getAudioTracks();
  if (videoTracks.length > 0) {

  }
  if (audioTracks.length > 0) {

  }
  const configuration = getSelectedSdpSemantics();
  pc1 = new RTCPeerConnection(configuration);
  pc1.addEventListener('icecandidate', e => onIceCandidate(pc1, e));
  pc2 = new RTCPeerConnection(configuration);
  pc2.addEventListener('icecandidate', e => onIceCandidate(pc2, e));
  pc1.addEventListener('iceconnectionstatechange', e => onIceStateChange(pc1, e));
  pc2.addEventListener('iceconnectionstatechange', e => onIceStateChange(pc2, e));
  pc2.addEventListener('track', gotRemoteStream);

  localStream.getTracks().forEach(track => pc1.addTrack(track, localStream));

  try {
    const offer =  pc1.createOffer(offerOptions);
    onCreateOfferSuccess(offer);
  } catch (e) {
    onCreateSessionDescriptionError(e);
  }
}

function onCreateSessionDescriptionError(error) {
  
}

function onCreateOfferSuccess(desc) {

  try {
     pc1.setLocalDescription(desc);
    onSetLocalSuccess(pc1);
  } catch (e) {
    onSetSessionDescriptionError();
  }

  console.log('pc2 setRemoteDescription start');
  try {
     pc2.setRemoteDescription(desc);
    onSetRemoteSuccess(pc2);
  } catch (e) {
    onSetSessionDescriptionError();
  }

  console.log('pc2 createAnswer start');
  // Since the 'remote' side has no media stream we need
  // to pass in the right constraints in order for it to
  // accept the incoming offer of audio and video.
  try {
    const answer =  pc2.createAnswer();
     onCreateAnswerSuccess(answer);
  } catch (e) {
    onCreateSessionDescriptionError(e);
  }
}

function onSetLocalSuccess(pc) {
	console.log('내화면출력성공');
}

function onSetRemoteSuccess(pc) {
	console.log('상대화면출력성공');
}

function onSetSessionDescriptionError(error) {
	console.log('오류입니다.');
}

function gotRemoteStream(e) {
  if (remoteVideo.srcObject !== e.streams[0]) {
    remoteVideo.srcObject = e.streams[0];
    console.log('pc2 received remote stream');
  }
}

function onCreateAnswerSuccess(desc) {

  try {
    pc2.setLocalDescription(desc);
    onSetLocalSuccess(pc2);
  } catch (e) {
    onSetSessionDescriptionError(e);
  }

  try {
   pc1.setRemoteDescription(desc);
    onSetRemoteSuccess(pc1);
  } catch (e) {
    onSetSessionDescriptionError(e);
  }
}

 function onIceCandidate(pc, event) {
  try {
    await (getOtherPc(pc).addIceCandidate(event.candidate));
    onAddIceCandidateSuccess(pc);
  } catch (e) {
    onAddIceCandidateError(pc, e);
  }
  
}

function onAddIceCandidateSuccess(pc) {

}

function onAddIceCandidateError(pc, error) {
 
}

function onIceStateChange(pc, event) {
  if (pc) {

  }
}

var PeerConnection = (function(){
	var PeerConnection = window.PeerConnection ||
		window.webkitPeerConnection00 ||
		window.webkitRTCPeerConnection ||
		window.mozRTCPeerConnection ||
		window.RTCPeerConnection;
	return PeerConnection;
})();

var pc = new PeerConnection({
	'iceServers': [
	    {
	      'urls': 'stun:stun.l.google.com:19302'
	    },
	    {
	      'urls': 'turn:192.158.29.39:3478?transport=udp',
	      'credential': 'JZEOEt2V3Qb0y27GRntt2u2PAYA=',
	      'username': '28224511:1379330808'
	    },
	    {
	      'urls': 'turn:192.158.29.39:3478?transport=tcp',
	      'credential': 'JZEOEt2V3Qb0y27GRntt2u2PAYA=',
	      'username': '28224511:1379330808'
	    }
	  ]}, {
		optional: [
			{ DtlsSrtpKeyAgreement: true },
			{ RtpDataChannels: false }
		]
});

function hangup() {

  pc1.close();
  pc2.close();
  pc1 = null;
  pc2 = null;
  hangupButton.disabled = true;
  callButton.disabled = false;
}

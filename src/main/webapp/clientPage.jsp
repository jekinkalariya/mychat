<!DOCTYPE html>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.net.Inet4Address"%>

<html>
<head>
<title>My Chat</title>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/materialize.js"></script>
<script type="text/javascript" src="js/sweetalert.min.js"></script>
<script>var currentTime=new Date($.now());</script>
<link rel="stylesheet" href="css/materialize.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/emojify.js/0.9.5/emojify-emoticons.css" media="screen" rel="stylesheet" type="text/css" />
<script src="js/emojis-keywords.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/emojify.js/0.9.5/emojify.js" type="text/javascript"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="css/sweetalert.css">
<link rel="shortcut icon" sizes="57x57" href="images/emoji/speech_balloon.png">
<style type="text/css">
.emoji {
	height: 25px !important;
	width: 25px;
}
</style>
<script>

var userName="Good Guy"

</script>
</head>
<%
	String loginName = System.getProperty("user.name");
	

	
	application.setAttribute("10.210.22.77", "Rakshit");
	application.setAttribute("10.210.24.22", "Jekin");
	application.setAttribute("10.210.22.107", "Sandip");
	application.setAttribute("10.210.24.55", "Love");
	
	String userName = request.getRemoteHost();
	InetAddress host = InetAddress.getByName(userName);
	userName = application.getAttribute(userName) != null
			? (String) application.getAttribute(userName)
			: userName;
%>
<body>

<div id="nameModal" class="modal">
    <div class="modal-content">
      <h4>Enter Your Good Name :)</h4>
     <input id="clientName" type="text" placeholder="Name" />
    </div>
    <div class="modal-footer">
      <a href="" onclick="setName()" class=" modal-action modal-close waves-effect waves-green btn-flat">OK</a>
    </div>
  </div>

	<div class="col s12">

		<div class="row">
			<h5 class="col s12 center" style="font-family: cursive;">
				<b id="headerName"></b>
			</h5>
			<span class="col s12"></span>
			<form action="#" class="col s12">
				<input id="inputmessage" type="text" placeholder="start typing your gosiiipppp..." />
				<div class="row">
					<button type="submit" value="Send" onclick="return send()" class="btn brown lighten-2">Send<i class="material-icons right">send</i></button> <button type="button" value="clear" onclick="clearText()" class="btn  grey darken-1">Clear<i class="material-icons right">clear</i></button>
					
				</div>
				<div class="row" style="height: 10px;">
					<div id="typingUSer" style="color: blue" class="col s3 push-s6">&nbsp;</div>
				</div>
			</form>
			<div id="messages" style="height: 400px; overflow-y: scroll; background: #FFFFFFF; margin-top: 20px" class="col s12 card"></div>
			<div id="sentmessages" style="color: green"></div>

			<div id="emojiModal" class="modal">
				<div class="modal-content">
					<h4>Modal Header</h4>
					<p>A bunch of text</p>
				</div>
				<div class="modal-footer">
					<a href="#!" class=" modal-action modal-close waves-effect waves-green btn grey">Agree</a>
				</div>
			</div>
			</div>
			</div>

			<!-- <div class="col s12">
				<div class="row">
					<div id="Jekin" class="col m1 l1 s2  red" style="height: 22px; width: 15px ;border-radius:50%"></div>
					<div class="col s2 m1"><b>Jekin</div>
					<div id="Rakshit" class="col m1 l1 s2  red" style="height: 22px; width: 15px ;border-radius:50%"></div>
					<div class="col s2 m1"><b>Rakshit</div>
					<div id="Sandip" class="col m1 l1 s2  red" style="height: 22px; width: 15px ;border-radius:50%"></div>
					<div class="col s2 m1"><b>Sandip(bussy with some one!!)</div>
					<div id="Love" class="col m1 l1 s2  red" style="height: 22px; width: 15px ;border-radius:50%"></div>
					<div class="col s2 m1">Love</div>

					<div id="Love2"  class="col s1  red" style="height: 10px;width: 10px"></div>
				<div class="col s1">Love2</div>
				</div>
			</div> -->
			<script>
			
			
				if (readCookie("clientName") == null) {
					$('#nameModal').openModal({dismissible:false});
				} else {

					userName = readCookie("clientName");
					$('#headerName').text("Welcome  " + userName + "!!");

				

				var webSocket = new WebSocket('ws://10.210.24.22:8480/mychat/websocket/' + userName);

				webSocket.onerror = function(event) {
					onError(event)
				};

				webSocket.onopen = function(event) {
					onOpen(event)
				};

				webSocket.onmessage = function(event) {
					onMessage(event)
				};

				webSocket.onclose = function(event) {
					//alert("call");
					//notifyMe("Session close","Your Session is close please reopen the link");
					//window.location.href="https://www.google.co.in";
				};

				window.onbeforeunload = function(evnet) {
					// notifyMe("Session close","Your Session is close please reopen the link");
				}

				function clearText() {

					$("#messages").empty();
				}

				function onMessage(event) {

					var dt = new Date();

					/*  document.getElementById('messages').innerHTML 
					   += '<br />'+userName+': ' + event.data; */
					var receiveData = event.data;
					console.log("receiveData" + receiveData);
					if (receiveData.indexOf('closefor') >= 0) {

						var message = receiveData.replace("closefor", "");
						console.log("messageclosefor" + message)

						//$('#'+message).removeClass('green');
						//$('#'+message).addClass('red');
					}

					else if (receiveData.indexOf('openfor') >= 0) {

						var message = receiveData.replace("openfor", "");
						console.log("messageopenfor" + message)
						//$('#'+message).removeClass('red');
						//$('#'+message).addClass('green');
					}

					else if (receiveData == "cleartypinguser") {
						$("#typingUSer").text("")
						return;

					} else if (receiveData.indexOf('typinguser') >= 0) {
						var message = receiveData.replace("typinguser", "");
						$("#typingUSer").text(message + " is typing");

					} else {
						var message = receiveData.substring(0, receiveData.lastIndexOf("thisisremoteadress"));
						var address = receiveData.substring(receiveData.lastIndexOf("thisisremoteadress") + 18);
						//$( "#messages" ).append( '<span style="color:green"><br />'+address+': ' +message+'<span>');
						//$("#messages").append('<div class="row" ><div class="col s10" style="background:lightgreen;height:40px;padding-top:10px;border-radius: 15%;margin-left:20px""><span style="color:red;">'+address+': ' +message+'</span></div><div class="col s1"><span   style="color:grey;margin-right:-30px;font-size:12px">('+dt.getHours() + ":" + dt.getMinutes()+ ')<span></div></div>');
						$("#messages").append('<div class="row" ><div class="col m1 l1 s2 " style="color: black;padding-top:8px";>' + address + ':speech_balloon:</div><div class="col s10 green accent-1" style="height:40px;padding-top:10px;border-radius: 15%;><span style="color:red;">' + message + '</span></div><div class="col s1"><span   style="color:grey;margin-right:-30px;font-size:12px">(' + dt.getHours() + ":" + dt.getMinutes() + ')<span></div></div>');

						$("#typingUSer").text("")

						console.log(document.visibilityState);
						if (document.visibilityState != "visible") {
							console.log("true");
							notifyMe(address, message);
						}
					}
					//$('#messages').emoticonize();
					emojify.run(document.getElementById('messages'))
					var elem = document.getElementById('messages');
					elem.scrollTop = elem.scrollHeight;
				}

				function onOpen(event) {
					//$('#messages').emoticonize();

					emojify.run(document.getElementById('messages'));

					/* document.getElementById('messages').innerHTML 
					  = 'Connection established'; */
				}

				function onError(event) {
					alert(event.data);
				}

				var searchTimeout;
				var isfirstchar = true
				document.getElementById('inputmessage').onkeypress = function() {
					if (isfirstchar) {
						sendTypinguser();
						isfirstchar = false;
					}
					if (searchTimeout != undefined)
						clearTimeout(searchTimeout);
					searchTimeout = setTimeout(clearTypinguser, 1000);
				};

				function send() {
					$("#typingUSer").text("")
					if ($("#inputmessage").val().length > 0) {

						var txt = document.getElementById('inputmessage').value;
						var dt = new Date();
						$("#messages").append('<div class="row" ><div class="col s10  purple lighten-4" style="height:40px;padding-top:10px;border-radius: 15%;><span style="color:red;">' + txt + '</span></div><div class="col s1"><span   style="color:grey;margin-right:-30px;font-size:12px">(' + dt.getHours() + ":" + dt.getMinutes() + ')<span></div></div>');
						webSocket.send(txt);
						$("#inputmessage").val("");

					}
					//$('#messages').emoticonize();
					emojify.run()
					var elem = document.getElementById('messages');
					elem.scrollTop = elem.scrollHeight;
					return false;
				}

				function sendTypinguser() {

					webSocket.send("typinguser" + userName);
					return false;

				}
				function clearTypinguser() {

					webSocket.send("clear");
					isfirstchar = true;

				}
				
				}

				$(document).ready(function() {

					if (readCookie("clientName") == null) {
						$('#nameModal').openModal({dismissible:false});
					} else {

						userName = readCookie("clientName");
						$('#headerName').text("Welcome" + userName + "!!");

					}

					//console.log("$('#nameModal').openModal();"+$('#nameModal').text())
				});
				document.addEventListener('DOMContentLoaded', function() {
					if (Notification.permission !== "granted")
						Notification.requestPermission();
				});

				function setName() {
					
					if($('#clientName').val().trim().length>0){

					createCookie("clientName", $('#clientName').val());
					}else{
						
						userName="Good Guy";
					}
					//$('#nameModal').closeModal();

				}

				function notifyMe(title, body) {
					if (!Notification) {
						alert('Desktop notifications not available in your browser. Try Chromium.');
						return;
					}

					if (Notification.permission !== "granted")
						Notification.requestPermission();
					else {
						var notification = new Notification(title, {
							body : body,
							iconUrl : "images/emoji/speech_balloon.png"
						});

						/*  notification.onclick = function () {
						   window.open("http://stackoverflow.com/a/13328397/1269037");      
						 }; */
						notification.onclick = function(x) {

							window.focus();
							this.cancel();
						};
						notification.onClose = function(x) {
							alert("close");
						};

					}

				}

				function createCookie(name, value, days) {
					if (days) {
						var date = new Date();
						date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
						var expires = "; expires=" + date.toGMTString();
					} else
						var expires = "";

					document.cookie = name + "=" + value + expires + "; path=/";
				}

				function readCookie(name) {
					var nameEQ = name + "=";
					var ca = document.cookie.split(';');
					for (var i = 0; i < ca.length; i++) {
						var c = ca[i];
						while (c.charAt(0) == ' ')
							c = c.substring(1, c.length);
						if (c.indexOf(nameEQ) == 0)
							return c.substring(nameEQ.length, c.length);
					}
					return null;
				}

				function eraseCookie(name) {
					createCookie(name, "", -1);
				}
			</script>
</body>
</html>

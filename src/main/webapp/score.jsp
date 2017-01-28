<script src="//www.cricruns.com/widget/widget_livebar.js" type="text/javascript"></script>

<script type="text/javascript">

function load(){
var eventMethod = window.addEventListener ? "addEventListener" : "attachEvent";var eventer = window[eventMethod];var messageEvent = eventMethod == "attachEvent" ? "onmessage" : "message";eventer(messageEvent,function(e) {var key = e.message ? "message" : "data";var data = e[key].split("#")[0];var iframe_height = e[key].split("#")[1];if(data=="nodata"){document.getElementById("cricruns_iframe").style.display="none";}else if(data=="one"){document.getElementById("cricruns_iframe").style.display="block";document.getElementById("cricruns_iframe").style.minHeight=iframe_height+"px";document.getElementById("cricruns_iframe").style.maxHeight=iframe_height+"px";}else if(data=="two"){document.getElementById("cricruns_iframe").style.display="block";document.getElementById("cricruns_iframe").style.minHeight=iframe_height+"px";document.getElementById("cricruns_iframe").style.maxHeight=iframe_height+"px";}},false);

}
</script>

<body onload="load()">

<iframe id="cricruns_iframe" class="cricruns_iframe" src="https://www.cricruns.com/livebarwidget" frameborder="0" width="100%" scrolling="no"></iframe>


</body>

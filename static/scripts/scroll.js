function vscrollToHbar() {
  if (document.body === null) return;
  var winScroll = document.body.scrollTop || document.documentElement.scrollTop;
  var height = document.documentElement.scrollHeight - document.documentElement.clientHeight;
  var scrolled = (winScroll / height) * 100;
  document.getElementById("progressBar").style.width = scrolled + "%";
} 

function attachProgressBar() {
  var nav = document.getElementsByClassName("navigation");
  if (nav === null || nav.length === 0) return;
  var progressHeader = document.createElement("div");
  progressHeader.className = "progress-header";
  var progressContainer = document.createElement("div");
  progressContainer.className = "progress-container";
  var progressBar = document.createElement("div");
  progressBar.className = "progress-bar";
  progressBar.id = "progressBar";
  progressHeader.appendChild(progressContainer);
  progressContainer.appendChild(progressBar);
  nav[0].insertBefore(progressHeader, nav[0].firstChild);
}

window.onload = function() {
  this.attachProgressBar();
  this.vscrollToHbar();
  window.onscroll = vscrollToHbar;
}
  
// ==UserScript==
// @name     Sushiscan DL
// @version  1
// @grant GM_download
// @match        https://sushiscan.net/*
// ==/UserScript==

(function() {
    'use strict';
    var div = document.createElement('div');
    div.style.display = 'block';
    div.style.position = 'fixed';
    div.style.bottom = '5px';
    div.style.right = '5px';;
    div.style.background = '#FFFFFF';
    div.style.color = '#000000';
    div.style.border = '1px solid black';
    div.style.padding = '1em';
    div.style.fontSize = 'smaller';
    div.textContent = 'Download'
    div.onclick = function() {
        downloadNext();
    }

    document.body.appendChild(div);
})();

function downloadNext() {
    var img = document.querySelector('.ts-main-image')
    var src = img.src
    var separator = src.lastIndexOf('/')
    var filename = src.substring(separator + 1);
    console.log('will download ' + filename)
    GM_download(src, filename)

  var nextButton = document.querySelector('.ch-next-btn');
    nextButton.click()
    setTimeout(downloadNext, 1000)
}



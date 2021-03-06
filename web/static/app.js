"use strict";
// this looks to be similar to that react document.getElementById("#idAttribute")
// and then call the render method where you pass in the DOM node
var lab = angular.module('lab', []);
console.log("lab", lab)

lab.controller('LabCtrl', function ($scope, $http, $timeout) {
  const debugging = {
    "$scope": $scope,
    "$http": $http,
    "$timeout":  $timeout
  };
  console.log("debugging", debugging);
  
  $scope.track = ""; 
  $scope.lyric = "";

  getAlbum($http, $timeout, '/albums/tracks', function(resp) {
    console.log("get album albums/tracks", resp);
    $scope.track = word(resp);
  });
  getAlbum($http, $timeout, '/albums/lyrics', function(resp) {
    console.log("albums/lyrics", resp);
    $scope.lyric = word(resp);
  });
});


/**
 * @name getAlbum
 * @param {} $http 
 * @param {*} $timeout - how long to wait
 * @param {*} url - api url
 * @param {*} callback - what to do when you get a response
 */
function getAlbum($http, $timeout, url, callback) {
  const debugging = {
    "$http": $http,
    "$timeout": $timeout,
    "url": url,
    "callback": callback
  };
  console.log("debugging", debugging);

    $http.get(url).then(callback, function(resp) {
        $timeout(function() {
            console.log("Retry: " + url);
            getAlbum($http, timeout, url, callback);
        }, 500)
    })
}

function word(resp) {
  console.log("word - resp", resp);
  return {
    word: resp.data.word,
    hostname: resp.headers()["source"]
  };
}
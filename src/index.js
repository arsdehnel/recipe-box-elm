'use strict';

var css = require("./styles/main.scss");
// var __svg__ = { path: './svg/*.svg', name: '[hash].logos.svg' };
// require('webpack-svgstore-plugin/src/helpers/svgxhr')(__svg__);

// Require index.html so it gets copied to dist
require('./index.html');

var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');

// The third value on embed are the initial values for incomming ports into Elm
var app = Elm.Main.embed(mountNode);
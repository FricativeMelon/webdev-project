// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"
import jQuery from 'jquery';
window.jQuery = window.$ = jQuery;
import "bootstrap";
import $ from 'jquery';

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
import socket from "./socket";
import project_init from "./project";
import friends_init from "./friends"

function start() {
  let root = document.getElementById('root');
  if (root) {
    socket.connect();
    let channel = socket.channel("vittles:" + "default", {});
    project_init(root, channel);
  }
  let friends_root = document.getElementById("friends_root");
  if (friends_root) {
    socket.connect();  
    let channel = socket.channel("vittles:" + "default", {});
    friends_init(friends_root, channel);
  }
}

$(start);

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
import food_init from "./food";
import stats_init from "./stats";
import calendar_init from "./calendar";
function start() {
  let home = document.getElementById('home');
  if (home) {
    socket.connect();
    let channel = socket.channel("vittles:" + window.gameName, {});
    stats_init(home, channel);
  }
  let calendar = document.getElementById('calendar');
  if (calendar) {
    socket.connect();
    let channel = socket.channel("vittles:" + window.gameName, {});
    calendar_init(calendar, channel);
  }
  let food = document.getElementById('food');
  if (food) {
    socket.connect();
    let channel = socket.channel("vittles:" + window.gameName, {});
    food_init(food, channel);
  }

}

$(start);




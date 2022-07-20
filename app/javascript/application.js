import "@hotwired/turbo-rails";
import "controllers";
import LocalTime from "local-time";
LocalTime.start();

import "popper";
import "bootstrap";

// --------------------------------------------------------------------
// sprockets-rails import is not working with importmap-rails
// as in assets/javascript/application.js. I can not find a solution
//
// Ask instructor how to get them work together or should ditch sprockets
// In the demo projects, only importmap is used
// In this project, I added
// Rails.application.config.assets.precompile += %w( bootstrap.min.js popper.js )
// to assets.rb and importmap.rb then
// used importmap
// --------------------------------------------------------------------

//= require jquery3

//= require popper

//= require bootstrap

//= require rails-ujs

//= require turbolinks

//= require_tree .

import "@hotwired/turbo-rails";
import "controllers";
import LocalTime from "local-time";
LocalTime.start();

// --------------------------------------------------------------------
// sprockets-rails import is not working with importmap-rails
// as in assets/javascript/application.js. I can not find a solution
//
// Ask instructor how to get them work together or should ditch sprockets
// In the demo projects, only importmap is used
// As for newer developement, webpack is recommanded
// --------------------------------------------------------------------

// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

//= require jquery
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"; 
import "script.js";
import "messages.js";
import 'swiper-init.js';

Rails.start()
Turbolinks.start()
ActiveStorage.start()

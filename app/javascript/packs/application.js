// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascripts and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");
require("moment/locale/es");
require("tempusdominus-bootstrap-4");

// import JQuery from 'jquery';
// window.$ = window.JQuery = JQuery;

import init from '../src/init';
import initDate from "../src/init2";
import "bootstrap";
import './../stylesheets/application.scss';
import './admin-template';
import '@fortawesome/fontawesome-free/js/all';

import "./transaction";
import "./clibboard_Transaction";
import "multiple-select";

init();
initDate();

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

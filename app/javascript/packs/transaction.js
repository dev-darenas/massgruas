$(document).on('turbolinks:load', function () {
  function initializeAutocomplete(id) {
    var element = document.getElementById(id);
    if (element) {
      var autocomplete = new google.maps.places.Autocomplete(element, {
        types: ['address'],
        componentRestrictions: {country: 'co'}
      });
      if (id === "autocomplete_address"){
        google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
      }
      else {
        google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged2);
      }
    }
  }

  function onPlaceChanged() {
    var place = this.getPlace();

    console.log(place.geometry.location);  // geometry.location Uncomment this line to view the full object returned by Google API.
    var lat = document.getElementById("lat");
    var lng = document.getElementById("lng");
    var lat2 = document.getElementById("lat2");
    var lng2 = document.getElementById("lng2");
    var total_km = document.getElementById("total_km")

    lat.value = place.geometry.location.lat();
    lng.value = place.geometry.location.lng();

    $.getJSON('/api/v1/calulate_distance', function(resp) {
      $.each(resp, function(k, v) {
        console.log(k + ' : ' + v);
      });
    });

  }

  function onPlaceChanged2() {
    var place = this.getPlace();

    console.log(place.geometry.location);  // Uncomment this line to view the full object returned by Google API.

    var lat = document.getElementById("lat");
    var lng = document.getElementById("lng");
    var lat2 = document.getElementById("lat2");
    var lng2 = document.getElementById("lng2");
    var total_km = document.getElementById("total_km")

    lat2.value = place.geometry.location.lat();
    lng2.value = place.geometry.location.lng();


    $.getJSON('/api/v1/calulate_distance', function(resp) {
      $.each(resp, function(k, v) {
        console.log(k + ' : ' + v);
      });
    });

  }

  google.maps.event.addDomListener(window, 'load', function () {
    initializeAutocomplete('autocomplete_address');
  });

  google.maps.event.addDomListener(window, 'load', function () {
    initializeAutocomplete('autocomplete_address2');
  });
});

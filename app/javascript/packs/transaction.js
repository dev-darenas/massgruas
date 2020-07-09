$(document).on('turbolinks:load', function () {
  function initializeAutocomplete(id) {
    var element = document.getElementById(id);
    if (element) {
      var autocomplete = new google.maps.places.Autocomplete(element, {
        types: ['address'],
        componentRestrictions: {country: 'co'}
      });
      google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
    }
  }

  function onPlaceChanged() {
    var place = this.getPlace();

    console.log(place);  // Uncomment this line to view the full object returned by Google API.
  }

  google.maps.event.addDomListener(window, 'load', function () {
    initializeAutocomplete('autocomplete_address');
  });

  google.maps.event.addDomListener(window, 'load', function () {
    initializeAutocomplete('autocomplete_address2');
  });
});

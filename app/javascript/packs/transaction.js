function calcularHoras(){
    var fecha_y_hora = $("#fecha_Y_hora")
    var hora_inicio = fecha_y_hora.val().split("T")[1]
    var hora_final = $("#hora_llegada").val();

    // Expresión regular para comprobar formato
    var formatohora = /^([01]?[0-9]|2[0-3]):[0-5][0-9]$/;

    // Si algún valor no tiene formato correcto sale
    if (!(hora_inicio.match(formatohora)
        && hora_final.match(formatohora))){
        return;
    }

    // Calcula los minutos de cada hora
    var minutos_inicio = hora_inicio.split(':')
        .reduce((p, c) => parseInt(p) * 60 + parseInt(c));
    var minutos_final = hora_final.split(':')
        .reduce((p, c) => parseInt(p) * 60 + parseInt(c));

    // Si la hora final es anterior a la hora inicial sale
    if (minutos_final < minutos_inicio) return;

    // Diferencia de minutos
    var diferencia = minutos_final - minutos_inicio;

    // Cálculo de horas y minutos de la diferencia
    var horas = Math.floor(diferencia / 60);
    var minutos = diferencia % 60;

    $('#response_time').val(horas + ':'
        + (minutos < 10 ? '0' : '') + minutos);
}

$(document).on('turbolinks:load', function () {
    $("#hora_llegada").change(function () {
        calcularHoras();
    });
    $("#fecha_Y_hora").change(function () {
        calcularHoras();
    });
});

$(document).on('turbolinks:load', function () {
    function initializeAutocomplete(id) {
        var element = document.getElementById(id);
        if (element) {
            var autocomplete = new google.maps.places.Autocomplete(element, {
                types: ['address'],
                componentRestrictions: {country: 'co'}
            });
            if (id === "autocomplete_address") {
                google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
            } else {
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

        $.getJSON('/api/v1/calulate_distance',
            {
                lat: lat.value,
                lng: lng.value,
                lat2: lat2.value,
                lng2: lng2.value
            }, function (resp) {
                console.log(resp.distance_km);
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


        $.getJSON('/api/v1/calulate_distance', {
            lat: lat.value,
            lng: lng.value,
            lat2: lat2.value,
            lng2: lng2.value
        }, function (resp) {
            total_km.value  = resp.distance_km
        });

    }

    google.maps.event.addDomListener(window, 'turbolinks:load', function () {
        initializeAutocomplete('autocomplete_address');
    });

    google.maps.event.addDomListener(window, 'turbolinks:load', function () {
        initializeAutocomplete('autocomplete_address2');
    });
});

$(document).on('turbolinks:load', function () {
    $("#tecnicos").change(function () {
        var tecnico=$("#tecnicos").val();
        var $tel1= $("#tel1");
        var $tel2= $("#tel2");
        var $ltel1= $("#ltel1");
        var $ltel2 = $("#ltel2");

        $.getJSON('/technicals/'+tecnico+'.json',
            function (resp) {
                console.log(resp);
                $tel1.val(resp.telefono1);
                $tel2.val(resp.telefono2);

                $tel1.show();
                $ltel1.show();
                $tel2.show();
                $ltel2.show();
            });
    })
});

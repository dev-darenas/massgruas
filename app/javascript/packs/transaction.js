function calcularHoras() {
    var fecha_y_hora = $("#fecha_Y_hora")
    var hora_inicio = fecha_y_hora.val().split("T")[1]
    var hora_final = $("#hora_llegada").val();

    // Expresión regular para comprobar formato
    var formatohora = /^([01]?[0-9]|2[0-3]):[0-5][0-9]$/;

    // Si algún valor no tiene formato correcto sale
    if (!(hora_inicio.match(formatohora)
        && hora_final.match(formatohora))) {
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
            total_km.value = resp.distance_km
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

        var tecnico = $("#tecnicos").val();
        var $id_tecnico = $("#id_tecnico");
        var $tel1 = $("#tel1");
        var $tel2 = $("#tel2");
        var $ltel1 = $("#ltel1");
        var $ltel2 = $("#ltel2");

        if (tecnico === "") {

            $tel1.hide();
            $ltel1.hide();
            $tel2.hide();
            $ltel2.hide();

        } else {
            $.getJSON('/technicals/' + tecnico + '.json',
                function (resp) {
                    $tel1.val(resp.telefono1);
                    $tel2.val(resp.telefono2);
                    $id_tecnico.val(tecnico)
                    $tel1.show();
                    $ltel1.show();
                    $tel2.show();
                    $ltel2.show();
                });
        }
    })

    var $clientes = $("#clientes");
    var $cuentas = $("#cuentas");

    function accounts() {
        $.getJSON('/clients/' + $clientes.val() + '.json',

            function (resp) {
                $cuentas.empty();
                var option = document.createElement("option");
                $cuentas.append(option);
                for (account of resp.accounts) {
                    option = document.createElement("option");
                    option.setAttribute("value", account.id);
                    option.setAttribute("label", account.name);
                    $cuentas.append(option)
                }
            });
    }

    if ($clientes.val() === "") {
        $cuentas.empty();
        var option = document.createElement("option");
        $cuentas.append(option);
    }

    $clientes.change(function () {
        if ($clientes.val() === "") {
            $cuentas.empty();
            var option = document.createElement("option");
            $cuentas.append(option);

        } else {
            accounts();
        }
    });

    var $servicio = $("#servicio");
    var $banderazo = $("#banderazo");
    var $val_km = $("#val_km");
    var $val_km_red = $("#val_km_red");
    var $horas_espera = $("#horas_espera");
    var $r_nocturno = $("#r_nocturno");
    var $r_festivo = $("#r_festivo");

    function list_prices() {
        $.getJSON('/clients/' + $clientes.val() + '.json',

            function (resp) {
                for (lp of resp.list_prices) {
                    if (lp.service_id === parseInt($servicio.val())) {
                        $banderazo.val(lp.flag);
                        $val_km.val(lp.kilometer_value);
                        $val_km_red.val(lp.red_zone_value);
                        $horas_espera.val(lp.waiting_hours_value);
                        $r_nocturno.val(lp.night_surcharge);
                        $r_festivo.val(lp.holiday_surcharge);
                    }
                }
            }
        );
    }

    $servicio.change(function () {
        if ($servicio.val() === "") {
        } else {
            list_prices();
        }
    });

    var $km_zona_normal = $("#km_zona_normal");
    var $total_normal_zone = $("#total_normal_zone");
    var $km_zona_roja = $("#km_zona_roja");
    var $total_red_zone = $("#total_red_zone");

    if ($val_km.val() !== "" && $val_km.val() !== undefined){
        $total_normal_zone.val(parseFloat($val_km.val()) * parseFloat($km_zona_normal.val()));
    }else {
        $km_zona_normal.change(function () {
            $total_normal_zone.val(parseFloat($val_km.val()) * parseFloat($km_zona_normal.val()));
        })
    }

    if ($val_km_red.val() !== "" && $val_km_red.val() !== undefined){
        $total_red_zone.val(parseFloat($val_km_red.val()) * parseFloat($km_zona_roja.val()));
    }else {
        $km_zona_roja.change(function () {
            $total_red_zone.val(parseFloat($km_zona_roja.val()) * parseFloat($val_km_red.val()));
        })
    }
});

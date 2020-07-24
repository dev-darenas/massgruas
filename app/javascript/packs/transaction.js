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

function sumTotalService() {
    var $total_normal_zone = $("#total_normal_zone");
    var $total_red_zone = $("#total_red_zone");
    var $total_waiting_hours = $("#total_waiting_hours");
    var $banderazo = $("#banderazo");
    var $r_nocturno = $("#r_nocturno");
    var $r_festivo = $("#r_festivo");
    var $valor_servicio = $("#valor_servicio");
    var $priced = $("#priced");

    var total_normal_zone = ($total_normal_zone.val() === null || $total_normal_zone.val() === undefined || $total_normal_zone.val() === "") ? 0 : $total_normal_zone.val();
    var total_red_zone = ($total_red_zone.val() === null || $total_red_zone.val() === undefined || $total_red_zone.val() === "") ? 0 : $total_red_zone.val();
    var total_waiting_hours = ($total_waiting_hours.val() === null || $total_waiting_hours.val() === undefined || $total_waiting_hours.val() === "") ? 0 : $total_waiting_hours.val();
    var banderazo = ($banderazo.val() === null || $banderazo.val() === undefined || $banderazo.val() === "") ? 0 : $banderazo.val();
    var r_nocturno = ($r_nocturno.val() === null || $r_nocturno.val() === undefined || $r_nocturno.val() === "") ? 0 : $r_nocturno.val();
    var r_festivo = ($r_festivo.val() === null || $r_festivo.val() === undefined || $r_festivo.val() === "") ? 0 : $r_festivo.val();

    $valor_servicio.val(parseFloat(total_normal_zone) + parseFloat(total_red_zone) + parseFloat(total_waiting_hours) + parseFloat(banderazo) +
        parseFloat(r_nocturno) + parseFloat(r_festivo));
    $priced.val($valor_servicio.val());
}

function sumTotalGastos() {
    var $pago_tecnico = $("#pago_tecnico");
    var $combustible = $("#combustible");
    var $peajes = $("#peajes");
    var $gasto_viaje = $("#gasto_viaje");
    var $gastos = $("#gastos");
    var $ganancias = $("#ganancias");
    var $priced = $("#priced");

    var pago_tecnico = ($pago_tecnico.val() === null || $pago_tecnico.val() === undefined || $pago_tecnico.val() === "") ? 0 : $pago_tecnico.val();
    var combustible = ($combustible.val() === null || $combustible.val() === undefined || $combustible.val() === "") ? 0 : $combustible.val();
    var peajes = ($peajes.val() === null || $peajes.val() === undefined || $peajes.val() === "") ? 0 : $peajes.val();
    var gasto_viaje = ($gasto_viaje.val() === null || $gasto_viaje.val() === undefined || $gasto_viaje.val() === "") ? 0 : $gasto_viaje.val();

    var resultado = parseFloat(parseFloat(pago_tecnico) + parseFloat(combustible) + parseFloat(peajes) + parseFloat(gasto_viaje)).toFixed(2);
    $gastos.val(resultado);

    var priced = ($priced.val() === null || $priced.val() === undefined || $priced.val() === "") ? 0 : $priced.val();
    var gastos = resultado;
    $ganancias.val(parseFloat(priced) - parseFloat(gastos));
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

    var lat = document.getElementById("lat");
    var lng = document.getElementById("lng");
    var lat2 = document.getElementById("lat2");
    var lng2 = document.getElementById("lng2");
    var total_km = document.getElementById("total_km");
    var km_zona_normal = document.getElementById("km_zona_normal");
    var km_zona_roja = document.getElementById("km_zona_roja");

    function distanceAPI() {
        $.getJSON('/api/v1/calulate_distance', {
            lat: lat.value,
            lng: lng.value,
            lat2: lat2.value,
            lng2: lng2.value
        }, function (resp) {
            total_km.value = resp.distance_km;
            km_zona_normal.value = 0;
            km_zona_roja.value = 0;
        });
    }

    function onPlaceChanged() {
        var place = this.getPlace();

        lat.value = place.geometry.location.lat();
        lng.value = place.geometry.location.lng();
        distanceAPI();

    }

    function onPlaceChanged2() {
        var place = this.getPlace();

        lat2.value = place.geometry.location.lat();
        lng2.value = place.geometry.location.lng();
        distanceAPI();

    }

    google.maps.event.addDomListener(window, 'turbolinks:load', function () {
        initializeAutocomplete('autocomplete_address');
    });

    google.maps.event.addDomListener(window, 'turbolinks:load', function () {
        initializeAutocomplete('autocomplete_address2');
    });
});

$(document).on('turbolinks:load', function () {
    var $km_zona_normal = $("#km_zona_normal");
    var $km_zona_roja = $("#km_zona_roja");
    var $total_km = $("#total_km");
    var $val_km_red = $("#val_km_red");
    var $total_red_zone = $("#total_red_zone");
    var $total_normal_zone = $("#total_normal_zone");
    var $val_km = $("#val_km");
    var $horas_de_espera = $("#horas_de_espera");
    var $waiting_hours_value = $("#waiting_hours_value");
    var $total_waiting_hours = $("#total_waiting_hours");

    function sumaKM(valorinputEvento, inputCompletar) {
        if (parseFloat(valorinputEvento) <= parseFloat($total_km.val())) {
            resultado = parseFloat(parseFloat($total_km.val()) - parseFloat(valorinputEvento)).toFixed(2);
            inputCompletar.val(resultado);
            total_zonas_km();
        } else {
            alert("El valor está fuera de rango");
        }
    }

    function total_zonas_km(){
        $total_normal_zone.val(parseFloat($val_km.val()) * parseFloat($km_zona_normal.val()));
        $total_red_zone.val(parseFloat($km_zona_roja.val()) * parseFloat($val_km_red.val()));
    }

    $km_zona_normal.change(function () {
        sumaKM($km_zona_normal.val(), $km_zona_roja);
        sumTotalService();
    });

    $km_zona_roja.change(function () {
        sumaKM($km_zona_roja.val(), $km_zona_normal);
        sumTotalService();
    });

    $horas_de_espera.change(function () {
        $total_waiting_hours.val(parseFloat($horas_de_espera.val()) * parseFloat($waiting_hours_value.val()));
        sumTotalService();
    });

});

$(document).on('turbolinks:load', function () {
    var $descuento = $("#descuento");
    var $pago_total = $("#pago_total");
    var $priced = $("#priced");


    $descuento.change(function () {
        $pago_total.val(parseFloat($priced.val()) - parseFloat($priced.val()) * (parseFloat($descuento.val()) / 100));
    });

});

$(document).on('turbolinks:load', function () {
    var $pago_total = $("#pago_total");
    var $porcentaje_tecnico = $("#porcentaje_tecnico");
    var $pago_tecnico = $("#pago_tecnico");
    var $combustible = $("#combustible");
    var $peajes = $("#peajes");
    var $gasto_viaje = $("#gasto_viaje");

    $porcentaje_tecnico.change(function () {
        resultado = parseFloat(parseFloat($pago_total.val()) * (parseFloat($porcentaje_tecnico.val()) / 100)).toFixed(2);
        $pago_tecnico.val(resultado);
        sumTotalGastos();
    });

    $combustible.change(function () {
        sumTotalGastos();
    });

    $peajes.change(function () {
        sumTotalGastos();
    });

    $gasto_viaje.change(function () {
        sumTotalGastos();
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
    var $waiting_hours_value = $("#waiting_hours_value");
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
                        $waiting_hours_value.val(lp.waiting_hours_value);
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

});

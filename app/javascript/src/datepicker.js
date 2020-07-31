function calcularHoras() {
    var fecha_y_hora = $("#fecha_Y_hora")
    var hora_inicio = fecha_y_hora.val().split(" ")[1]
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

const init2 = () => {

    console.log(' init datetimepicker ');
    $('#datetimepicker2').datetimepicker({
        format: 'DD-MM-YYYY HH:mm zz',
        ignoreReadonly: true,
        icons: {
            time: "far fa-clock"
        }
    });

    $("#datetimepicker2").on("change.datetimepicker", function (e) {
        calcularHoras();
    });

    $('#datetimepicker3').datetimepicker({
        format: 'HH:mm',
        ignoreReadonly: true
    });

    $("#datetimepicker3").on("change.datetimepicker", function (e) {
        calcularHoras();
    });

    $('#datetimepicker4').datetimepicker({
        format: 'DD-MM-YYYY HH:mm zz',
        ignoreReadonly: true,
        icons: {
            time: "far fa-clock"
        }
    });
};

export default init2;

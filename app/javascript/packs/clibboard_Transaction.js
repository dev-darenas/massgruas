import Clipboard from 'clipboard';

function showTooltip(elem, msg) {
    elem.setAttribute('class', 'btn_clip_board btn btn-primary tooltipped tooltipped-s');
    elem.setAttribute('aria-label', msg);
}

function clearTooltip(e) {
    $(e.delegateTarget).attr('class', 'btn_clip_board btn btn-primary');
    $(e.delegateTarget).removeAttr('aria-label');
}

$(document).on('turbolinks:load', function () {
    var clipboard = new Clipboard('.btn_clip_board', {
        text: function (trigger) {
            var transaction= $("#data_transaction").data("transaction");

            return "DETALLE DE LA SOLICITUD DEL SERVICIO"+
                "\nExpediente: " + transaction.expediente +
                "\nProveedor:"+transaction.enterprise.name+
                "\nSubservicio: "+transaction.service_including_deleted.name+
                "\nGrupo de Cuenta: "+transaction.account_including_deleted.name+
                "\nNuestro Usuario: "+transaction.account_including_deleted.nombre+
                "\nQuien Reporta: "+transaction.technical_including_deleted.nombre+
                "\nUBICACION DEL SINIESTRO: "+ transaction.origen+
                "\nTRANSPORTE INVOLUCRADO: "+transaction.vehicle_including_deleted.marca+
                "\nNombre asegurado: "+transaction.asegurado+
                "\nTelefono asegurado: "+transaction.telefono+
                "\nTelefono Direccion: "+transaction.direccion+
                "\nTipo: "+transaction.vehicle_including_deleted.tipo+
                "\nTarea: "+transaction.tarea+
                "\n\nTIEMPOS:\n"+
                "\nDestino:"+  transaction.destino+
                "\nFecha Apertura Expediente:"+transaction.fecha+
                "\nFecha Término Expediente: " + transaction.fecha_de_cierre+
                "\nEstatus: "+transaction.status+
                "\nFecha Llegada: "+transaction.hora_llegada
        }
    });

    clipboard.on('success', function (e) {
        showTooltip(e.trigger, 'Copiado!');
    });

    $(".btn_clip_board").on('mouseleave', clearTooltip)
                        .on('blur', clearTooltip);
});
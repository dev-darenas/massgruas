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
            var transaction=$("#data_transaction").data("transaction");

            return "DETALLE DE LA SOLICITUD DEL SERVICIO \n \n \nExpediente: " + transaction.expediente +
                "\nProveedor:"+transaction.enterprise.name+" Subservicio: "+transaction.service_including_deleted.name+
                "\nGrupo de Cuenta: "+transaction.account_including_deleted.name+"\nNuestro Usuario: "+transaction.account_including_deleted.nombre+
                " Quien Reporta: "+transaction.technical_including_deleted.nombre+"\nUBICACION DEL SINIESTRO: "+
                transaction.origen+"\nTRANSPORTE INVOLUCRADO: "+transaction.vehicle_including_deleted.marca+
                " Tipo: "+transaction.vehicle_including_deleted.tipo+"\nModelo: "+transaction.vehicle_including_deleted.modelo+
                "\nCOMBUSTIBLE: "+transaction.vehicle_including_deleted.combustible+"\n" +
                "TIEMPOS:\n"+
                "Destino:"+  transaction.destino+"\n" +
                "Fecha Apertura Expediente:"+transaction.fecha+"\n" +
                "Fecha Término Expediente: " + transaction.fecha_de_cierre+"\n" +
                "Estatus: "+transaction.status +"\n"+
                "Fecha Llegada: "+transaction.hora_llegada
        }
    });

    clipboard.on('success', function (e) {
        showTooltip(e.trigger, 'Copiado!');
    });

    $(".btn_clip_board").on('mouseleave', clearTooltip)
                        .on('blur', clearTooltip);
});
import Clipboard from 'clipboard';

$(document).on('turbolinks:load', function () {
    new Clipboard('.btn_clip_board',{
        text: function(trigger) {
            return "Prueba de clipboard"
        }
    });
});
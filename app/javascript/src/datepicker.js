const init2 = () => {
    console.log(' init datetimepicker ');
    $('#datetimepicker2').datetimepicker({
        format: 'DD-MM-YYYY HH:mm zz',
        ignoreReadonly: true,
        icons: {
            time: "far fa-clock"
        }
    });

    $('#datetimepicker3').datetimepicker({
        format: 'HH:mm',
        ignoreReadonly: true
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

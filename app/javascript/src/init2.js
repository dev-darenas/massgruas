import initdatepicker from  './datepicker'

const initDate = () => {
    $(document).on('turbolinks:load', () => {
        initdatepicker();
    });
};

export default initDate;

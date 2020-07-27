import iniMultiselect from './multiselect'

const init = () => {
  $(document).on('turbolinks:load', () => {
    if($(".multiple-select").length > 0){
      iniMultiselect()
    }
  });
};

export default init;

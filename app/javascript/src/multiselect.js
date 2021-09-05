const init = () => {
  console.log(' init multiselect mod')
  $('.multiple-select').multipleSelect({
    showClear: true,
    selectAll: true,
    dropWidth: '500',
    filter: 'Buscar'
  });
};

export default init;

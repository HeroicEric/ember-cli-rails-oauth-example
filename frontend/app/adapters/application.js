import DS from 'ember-data';

export default DS.ActiveModelAdapter.extend({
  host: ExampleENV.host,
  namespace: 'api/v1'
});

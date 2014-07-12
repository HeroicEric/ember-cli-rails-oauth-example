import Ember from 'ember';
// import ApplicationRouteMixin from 'simple-auth/mixins/application-route-mixin';

export default Ember.Route.extend({
  actions: {
    authenticate: function(provider){
      var controller = this.controller;

      this.get('session').open(provider).then(function() {
        alert('hooray it worked');
      }, function(error) {
        controller.set('error', 'Could not sign you in');
      });
    }
  }
});

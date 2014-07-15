import Ember from 'ember';

var Router = Ember.Router.extend({
  location: ExampleENV.locationType
});

Router.map(function() {
  this.route('authCallback', { path: '/auth/callback' });
});

export default Router;

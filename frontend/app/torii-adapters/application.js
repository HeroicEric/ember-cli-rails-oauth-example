import Ember from 'ember';

export default Ember.Object.extend({
  open: function(authentication){
    return new Ember.RSVP.Promise(function(resolve, reject){
      Ember.$.ajax({
        type: 'post',
        url: 'api/v1/token',
        data: {
          provider: authentication.provider,
          code: authentication.authorizationCode
        },
        dataType: 'json',
        success: Ember.run.bind(null, resolve),
        error: Ember.run.bind(null, reject)
      });
    }).then(function(user){
      // The returned object is merged onto the session (basically). Here
      // you may also want to persist the new session with cookies or via
      // localStorage.

      debugger;

      return {
        currentUser: user
      };
    });
  }
});

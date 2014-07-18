/* jshint node: true */

module.exports = function(environment) {
  var ENV = {
    environment: environment,
    baseURL: '/',
    locationType: 'hash',
    EmberENV: {
      FEATURES: {
        // Here you can enable experimental features on an ember canary build
        // e.g. 'with-controller': true
      }
    },

    APP: {
      // Here you can pass flags/options to your application instance
      // when it is created
    }
  };

  ENV.torii = {
    providers: {
      'github-oauth2': {
        scope: 'user:email'
      }
    }
  };

  if (environment === 'development') {
    // LOG_MODULE_RESOLVER is needed for pre-1.6.0
    ENV.LOG_MODULE_RESOLVER = true;

    ENV.APP.LOG_RESOLVER = true;
    ENV.APP.LOG_ACTIVE_GENERATION = true;
    ENV.APP.LOG_MODULE_RESOLVER = true;
    // ENV.APP.LOG_TRANSITIONS = true;
    // ENV.APP.LOG_TRANSITIONS_INTERNAL = true;
    ENV.APP.LOG_VIEW_LOOKUPS = true;

    ENV.host = 'http://localhost:3000';
    ENV.torii.providers['github-oauth2'].apiKey = '7ba20b9d5eb6cd9ee831';
  }

  if (environment === 'production') {
    ENV.host = 'http://ember-cli-rails-oauth-example.herokuapp.com';
    ENV.torii.providers['github-oauth2'].apiKey = '148a27a37233a18bf596';
  }

  ENV['simple-auth'] = {
    authorizer: 'simple-auth-authorizer:oauth2-bearer',
    crossOriginWhitelist: [ENV.host]
  };

  ENV['simple-auth-oauth2'] = {
    serverTokenEndpoint: ENV.host + '/api/v1/token'
  };

  return ENV;
};

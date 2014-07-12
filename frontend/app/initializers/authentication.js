import ToriiOauth2Authenticator from '../authenticators/torii-oauth2';

export default {
  name: 'authentication',

  initialize: function(container) {
    container.register('authenticator:torii-oauth2', ToriiOauth2Authenticator);
  }
};

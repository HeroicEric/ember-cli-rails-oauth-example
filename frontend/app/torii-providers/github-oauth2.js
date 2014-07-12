import Oauth2 from 'torii/providers/oauth2-code';
import {configurable} from 'torii/configuration';

var GithubOauth2 = Oauth2.extend({
  name:       'github-oauth2',
  baseUrl:    'https://github.com/login/oauth/authorize',

  // additional url params that this provider requires
  requiredUrlParams: ['state'],

  state: 'STATE',

  redirectUri: configurable('redirectUri', function(){
    // A hack that allows redirectUri to be configurable
    // but default to the superclass
    return this._super();
  })
});

export default GithubOauth2;

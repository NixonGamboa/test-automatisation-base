function fn() {

  var env = java.lang.System.getenv('env');
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'local';
  }
  var config = {
    env: env,
    baseUrl: 'http://bp-se-test-cabcd9b246a5.herokuapp.com',
    username: 'ngamboa' // Usuario dinámico para las rutas de la API
  }

  config.marvelApiBaseUrl = config.baseUrl + '/' + config.username + '/api';

  return config;
}

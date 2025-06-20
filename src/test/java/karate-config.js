function() {

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

// Combina la URL base con el username para crear la URL raíz de la API
config.marvelApiBaseUrl = config.baseUrl + '/' + config.username + '/api';


return config;
}

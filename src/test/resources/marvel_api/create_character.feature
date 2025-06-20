@MarvelApi @create_character @Agente2 @E2
Feature: MarvelApi: Crear Personaje
  Background:
  # La URL base para la API de Marvel se define en karate-config.js
    Given url marvelApiBaseUrl
    And path '/characters'
    And header Content-Type = 'application/json'

  @Crear_personaje_exitosamente
  Scenario: Crear personaje exitosamente
    * def requestBody = read('classpath:marvel_api/data/create_character_body.json')
    # Modificar el nombre para asegurar que sea único para cada ejecución
    * set requestBody.name = 'Personaje_Nuevo_' + new Date().getTime()
    And request requestBody
    When method POST
    Then status 201
    And match response.id == '#number'
    And match response.name == requestBody.name
    And match response.alterego == requestBody.alterego
    And match response.description == requestBody.description
    And match response.powers == requestBody.powers
  Scenario: Crear personaje con campos faltantes

    * def requestBody = read('classpath:marvel_api/data/create_character_body_missing_fields.json')
    And request requestBody
    When method POST
    Then status 400
    And match response.name == 'Name is required'
    And match response.description == 'Description is required'
    And match response.powers == 'Powers are required'
    And match response.alterego == 'Alterego is required'

  Scenario: Crear personaje con nombre duplicado
    # Primero, creamos un personaje que luego intentaremos duplicar
    * def uniqueName = 'Personaje_Original_' + new Date().getTime()
    * def originalCharacterBody = read('classpath:marvel_api/data/create_character_body.json')
    * set originalCharacterBody.name = uniqueName
    And request originalCharacterBody
    When method POST
    Then status 201
    * def originalId = response.id

    # Ahora intentamos crear otro personaje con el mismo nombre
    And path '/characters'
    * def duplicateCharacterBody = read('classpath:marvel_api/data/create_character_body_duplicate.json')
    # Aseguramos que el nombre sea el duplicado
    * set duplicateCharacterBody.name = uniqueName
    And request duplicateCharacterBody
    When method POST
    Then status 400
    And match response == { error: 'Character name already exists' }

    # Limpieza: Borrar el personaje original para no dejar basura si es posible
    # NOTA: La eliminación está en otro .feature, pero para pruebas independientes es buena práctica limpiar
    And path '/characters/' + originalId
    When method DELETE
    Then status 204


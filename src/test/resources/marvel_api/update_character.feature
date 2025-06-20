@MarvelApi @update_character
Feature: MarvelApi: Actualizar Personaje

  Background:
    Given url marvelApiBaseUrl
    And header Content-Type = 'application/json'

  Scenario: Actualizar personaje exitosamente

  # Precondición: Crear un personaje para actualizar
    * def createCharacter = call read('create_character.feature@Crear personaje exitosamente')
    * def characterId = createCharacter.response.id
    * def initialName = createCharacter.response.name

    # Cuerpo de actualización
    * def updateBody = read('classpath:marvel_api/data/update_character_body.json')
    * set updateBody.name = initialName

    Given path '/characters/' + characterId
    And request updateBody
    When method PUT
    Then status 200
    And match response.id == characterId
    And match response.name == updateBody.name
    And match response.description == updateBody.description
    And match response.powers == updateBody.powers

    # Limpieza: Eliminar el personaje actualizado
    * url marvelApiBaseUrl
    * path '/characters/' + characterId
    When method DELETE
    Then status 204

  Scenario: Actualizar personaje que no existe

    Given path '/characters/9999999'
    * def updateBody = read('classpath:marvel_api/data/update_character_body_no_change.json')
    And request updateBody
    When method PUT
    Then status 404
    And match response == { error: 'Character not found' }


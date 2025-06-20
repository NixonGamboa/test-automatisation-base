@MarvelApi @delete_character @Agente2 @E2
Feature: MarvelApi: Eliminar Personaje

  Background:
    Given url marvelApiBaseUrl

  Scenario: Eliminar personaje exitosamente

  # Precondición: Crear un personaje para eliminar
    * def createCharacter = call read('create_character.feature@Crear personaje exitosamente')
    * def characterId = createCharacter.response.id

    Given path '/characters/' + characterId
    When method DELETE
    Then status 204

  Scenario: Eliminar personaje que no existe

    Given path '/characters/9999999'
    When method DELETE
    Then status 404
    And match response == { error: 'Character not found' }


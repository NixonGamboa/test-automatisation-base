@MarvelApi @get_character_by_id
Feature: MarvelApi: Obtener Personaje por ID

  Background:
    Given url marvelApiBaseUrl
    And header Content-Type = 'application/json' // Aunque sea GET, a veces se incluyen

  Scenario: Obtener personaje por ID exitosamente

  # Precondición: Crear un personaje para obtener su ID dinámicamente
    * def createCharacter = call read('create_character.feature@Crear personaje exitosamente')
    * def characterId = createCharacter.response.id
    * def characterName = createCharacter.response.name
    * def characterAlterego = createCharacter.response.alterego
    * def characterDescription = createCharacter.response.description
    * def characterPowers = createCharacter.response.powers

    Given path '/characters/' + characterId
    When method GET
    Then status 200
    And match response.id == characterId
    And match response.name == characterName
    And match response.alterego == characterAlterego
    And match response.description == characterDescription
    And match response.powers == characterPowers

    # Limpieza: Eliminar el personaje creado
    * url marvelApiBaseUrl
    * path '/characters/' + characterId
    When method DELETE
    Then status 204

  Scenario: Obtener personaje por ID que no existe

    Given path '/characters/9999999'
    When method GET
    Then status 404
    And match response == { error: 'Character not found' }

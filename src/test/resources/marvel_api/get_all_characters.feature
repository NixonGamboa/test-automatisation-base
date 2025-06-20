@MarvelApi @get_all_characters @Agente2 @E2
Feature: MarvelApi: Obtener todos los Personajes
  Background:
    Given url marvelApiBaseUrl
    And path '/characters'

  Scenario: Obtener todos los personajes exitosamente (lista con al menos uno)
  #Precondición: Aseguramos que haya al menos un personaje para obtener
    * def createCharacter = call read('create_character.feature@Crear_personaje_exitosamente')
    Then print 'Personaje creado con ID: ' + createCharacter.error
    * def createdId = createCharacter.response.id

    When method GET
    Then status 200
    And match response == '#array'
    #And match response contains { id: createdId }

    # Limpieza: Eliminar el personaje creado para no afectar otras pruebas
    And path '/characters/' + createdId
    When method DELETE
    Then status 204

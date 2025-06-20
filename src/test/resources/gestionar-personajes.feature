@REQ_MARVEL-001 @HU001 @gestionar_personajes @marvel_characters_api @Agente2 @E2 @iniciativa_automatizacion_api
Feature: MARVEL-001 Gestión de personajes Marvel (microservicio para personajes)

  Background:
    * url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/dagonzal/api'
    * def generarHeaders =
      """
      function() {
        return {
          "Content-Type": "application/json"
        };
      }
      """
    * def headers = generarHeaders()
    * headers headers

  @id:1 @obtenerPersonajes @listaVacia200
  Scenario: T-API-MARVEL-001-CA01-Obtener todos los personajes 200 - karate
    Given path '/characters'
    When method GET
    Then status 200
    # And match response == []

  @id:2 @getCharacterById @noEncontrado
  Scenario: T-API-DAGONZAL-123-CA02-Obtener personaje por ID no existente 404 - karate
    Given path '/characters', '999'
    When method GET
    Then status 404
    # And match response.error == 'Character not found'

  @id:3 @createCharacter @exitoso
  Scenario: T-API-DAGONZAL-123-CA03-Crear personaje exitosamente 201 - karate
    * def body = read('classpath:personajes/create_character_valid.json')
    Given path '/characters'
    And request body
    When method POST
    Then status 201
    # And match response.name == 'Spider-Man'

  @id:4 @createCharacter @duplicado
  Scenario: T-API-DAGONZAL-123-CA04-Crear personaje con nombre duplicado 400 - karate
    * def body = read('classpath:personajes/create_character_duplicate.json')
    Given path '/characters'
    And request body
    When method POST
    Then status 400
    # And match response.error == 'Character name already exists'

  @id:5 @updateCharacter @exitoso
  Scenario: T-API-DAGONZAL-123-CA05-Actualizar personaje existente 200 - karate
    * def body = read('classpath:personajes/update_character_valid.json')
    Given path '/characters/'+15
    And request body
    When method PUT
    Then status 200
    # And match response.description == 'Updated description'

  @id:6 @updateCharacter @noEncontrado
  Scenario: T-API-DAGONZAL-123-CA06-Actualizar personaje inexistente 404 - karate
    * def body = read('classpath:personajes/update_character_notfound.json')
    Given path 'characters', '999'
    And request body
    When method PUT
    Then status 404
    # And match response.error == 'Character not found'
  @id:7 @deleteCharacter @exitoso
  Scenario: T-API-DAGONZAL-123-CA07-Eliminar personaje existente 204 - karate
    Given path 'characters', '16'
    When method DELETE
    Then status 204

  @id:8 @deleteCharacter @noEncontrado
  Scenario: T-API-DAGONZAL-123-CA08-Eliminar personaje inexistente 404 - karate
    Given path 'characters', '84'
    When method DELETE
    Then status 404
    # And match response.error == 'Character not found'

  @id:9 @flujo_completo @dinamico
  Scenario: T-API-DAGONZAL-123-CA09-Flujo completo: crear, consultar, actualizar y eliminar personaje - karate
  # Paso 1: Crear personaje con nombre aleatorio
    * def uuid = java.util.UUID.randomUUID() + ''
    * def body = read('classpath:personajes/create_character_aleatory.json')
    Given path 'characters'
    And request body
    When method POST
    Then status 201
    * def created = response
    * def id = created.id

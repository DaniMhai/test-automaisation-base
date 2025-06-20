@REQ_MARVEL-001 @HU001 @gestionar_personajes @marvel_characters_api @Agente2 @E2 @iniciativa_automatizacion_api
Feature: MARVEL-001 Gestión de personajes Marvel (microservicio para personajes)

  Background:
    * url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
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
    When method GET
    Then status 200
    # And match response == []

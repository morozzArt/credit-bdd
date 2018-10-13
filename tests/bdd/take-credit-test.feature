Feature: integration test

  Background:
    * def serverConfig = read('mocks/start-mock.js')
    * def serverMock = serverConfig('take-credit-mock')
    * url 'http://localhost:' + serverMock.port + '/credit'
    * configure afterScenario = read('mocks/stop-mock.js')
    * configure headers = { 'Content-Type': 'application/json' }

  Scenario: create credit positive
    Given request {"person":{"firstName":"Alexandra","lastName":"Chernyshova"},"credit":2000000,"agreementAt":"2018-10-08","currency":"USD","duration":60,"percent":10}
    When method post
    Then status 200
    And match response == { id:'#number' }

# Created by korwin at 10/11/18
Feature: integration test

Background:
    * def serverConfig = read('mocks/start-mock.js')
    * def catsServerMock = serverConfig('take-credit-mock')
    * url 'http://localhost:' + catsServerMock.port + '/credit'
    * def afterScenario = function(){ catsServerMock.stop() }

Scenario: create credit
    Given request {"person":{"firstName":"Alexandra","lastName":"Chernyshova"},"credit":2000000,"agreementAt":"2018-10-08","currency":"USD","duration":60,"percent":10}
    When method post
    Then status 200
    And match response == { id:'#number' }
    And def id = response.id

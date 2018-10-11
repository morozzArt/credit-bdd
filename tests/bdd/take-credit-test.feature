# Created by korwin at 10/11/18
Feature: integration test

Background:
    * def serverConfig = read('mocks/start-mock.js')
    * def catsServerMock = serverConfig('take-credit-mock')
    * url 'http://localhost:' + catsServerMock.port + '/credit'
    * def afterScenario = function(){ catsServerMock.stop() }

Scenario: create credit #1
    Given request {"person":{"firstName":"Alexandra","lastName":"Chernyshova"},"credit":2000000,"agreementAt":"2018-10-08","currency":"USD","duration":60,"percent":10}
    When method post
    Then status 200
    And match response == { id:'#number' }
    And def id = response.id

    Given path id
    When method get
    Then status 200
    And match response == {"person":{"firstName":"Alexandra","lastName":"Chernyshova"},"credit":2000000,"agreementAt":"2018-10-08","currency":"USD","duration":60,"percent":10,"id":'#(id)'}


Scenario: create credit #2
    Given request {"person":{"firstName":"Lev","lastName":"Kovalenko"},"credit":2000,"agreementAt":"2018-10-08","currency":"USD","duration":1,"percent":1}
    When method postK
    Then status 200
    And match response == { id:'#number' }

    Given request {"person":{"firstName":"Alexandr","lastName":"Chernyshov"},"credit":20000000,"agreementAt":"2018-10-10","currency":"RUB","duration":60,"percent":100}
    When method post
    Then status 200
    And match response == { id:'#number' }
    And def id = response.id

    Given path id
    When method get
    Then status 200
    And match response == {"person":{"firstName":"Alexandra","lastName":"Chernyshova"},"credit":2000000,"agreementAt":"2018-10-08","currency":"USD","duration":60,"percent":10,"id":'#(id)'}

    Given url 'http://localhost:' + catsServerMock.port + '/__admin/stop'
    When method get
    Then status 200
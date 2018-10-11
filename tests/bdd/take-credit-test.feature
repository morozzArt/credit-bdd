# Created by korwin at 10/11/18
Feature: integration test

Background:
    * def serverConfig = read('mocks/start-mock.js')
    * def catsServerMock = serverConfig('take-credit-mock')
    * url 'http://localhost:' + catsServerMock.port + '/credit'
    * def afterScenario = function(){ catsServerMock.stop() }

Scenario: create credit positive
    Given request {"person":{"firstName":"Alexandra","lastName":"Chernyshova"},"credit":2000000,"agreementAt":"2018-10-08","currency":"USD","duration":60,"percent":10}
    When method post
    Then status 200
    And match response == { id:'#number' }

    Given url 'http://localhost:' + catsServerMock.port + '/__admin/stop'
    When method get
    Then status 200

Scenario: create credit negative
    Given request {"person":{"firstName":"Alexandra","lastName":"Chernyshova"},"agreementAt":"2018-10-08","currency":"USD","duration":60,"percent":10}
    When method post
    Then status 400
    And match response == {"code":400,"message":"Parametr missed"}

    Given request {"person":{"firstName":"Alexandra","lastName":"Chernyshova"},"credit":0,"agreementAt":"2018-10-08","currency":"USD","duration":60,"percent":10}
    When method post
    Then status 400
    And match response == {"code":400, "message":"Inalid value of credit"}

    Given request {"person":{"firstName":"Alexandra","lastName":"Chernyshova"},"credit":200000,"agreementAt":"2018-10-08","currency":12,"duration":60,"percent":10}
    When method post
    Then status 400
    And match response == {"code":400, "message":"Invalid currency"}

    Given request {"person":{"firstName":"Alexandra","lastName":"Chernyshova"},"credit":2000000,"agreementAt":"2018-10-08","currency":"USD","duration":1,"percent":10}
    When method post
    Then status 400
    And match response == {"code":400, "message":"Invalid duration"}

    Given request {"person":{"firstName":"Alexandra","lastName":"Chernyshova"},"credit":2000000,"agreementAt":"2018-10-08","currency":"USD","duration":60,"percent":103}
    When method post
    Then status 400
    And match response == {"code":400, "message":"Invalid percent"}

    Given url 'http://localhost:' + catsServerMock.port + '/__admin/stop'
    When method get
    Then status 200

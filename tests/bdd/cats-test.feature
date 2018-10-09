Feature: integration test

Background:
    * def serverConfig = read('mocks/start-mock.js')
    * def catsServerMock = serverConfig('cats-mock')
    * url 'http://localhost:' + catsServerMock.port + '/cats'
    * def afterScenario = function(){ catsServerMock.stop() }

Scenario: create cat
    Given request { name: 'Billie' }
    When method post
    Then status 200    
    And match response == { id: '#uuid', name: 'Billie' }
    And def id = response.id

    Given path id
    When method get
    Then status 200
    And match response == { id: '#(id)', name: 'Billie' }

    When method get
    Then status 200
    And match response contains [{ id: '#(id)', name: 'Billie' }]

    Given request { name: 'Bob' }
    When method post
    Then status 200    
    And match response == { id: '#uuid', name: 'Bob' }
    And def id = response.id

    Given path id
    When method get
    Then status 200
    And match response == { id: '#(id)', name: 'Bob' }

    When method get
    Then status 200
    And match response contains [{ id: '#uuid', name: 'Billie' },{ id: '#(id)', name: 'Bob' }]

    Given url 'http://localhost:' + catsServerMock.port + '/__admin/stop'
    When method get
    Then status 200

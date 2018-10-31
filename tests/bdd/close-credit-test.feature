Feature: integration test

  Background:
    * def serverConfig = read('mocks/start-mock.js')
    * def serverMock = serverConfig('cats-mock')
    * url 'http://localhost:' + serverMock.port + '/cats'
    * configure afterScenario = read('mocks/stop-mock.js')
    * configure headers = { 'Content-Type': 'application/json' }

    Scenario: close credit
    	Given request {"id":0}
    	When method post
    	Then status 200
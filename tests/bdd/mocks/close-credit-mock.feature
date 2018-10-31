Feature: stateful mock server

  Background:
    * configure cors = true
    * configure responseHeaders = { 'Content-Type': 'application/json; charset=utf-8' }

  Scenario: pathMathes('/credit/delete/{id}')
  	* def id = pathParam.id
  	* def response = {message: "done"}
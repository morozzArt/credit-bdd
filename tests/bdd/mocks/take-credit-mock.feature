# Created by korwin at 10/11/18
Feature: stateful mock server

Background:
* configure cors = true
* def id = 0
* def credits = {}
* def str2int = function(arg) {return parseInt(arg);}
* def incr = function(arg) { return arg + 1;}


Scenario: pathMatches('/credit') && methodIs('post')
    * def credit = request
    * eval id = incr(id)
    * eval credit.id = id
    * eval credits[id] = credit
    * def response = {id: '#(id)'}

Scenario: pathMatches('/credit')
    * def response = credits

Scenario: pathMatches('/credit/{id}/')
    * def response = credits[str2int(pathParams.id)]

Scenario:
    # catch-all
    * def responseStatus = 404
    * def responseHeaders = { 'Content-Type': 'text/html; charset=utf-8' }
    * def response = <html><body>Not Found</body></html>


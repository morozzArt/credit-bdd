# Created by korwin at 10/11/18
Feature: stateful mock server

Background:
* configure cors = true
* def id = 0
* def credits = {}

Scenario: pathMatches('/credit') && methodIs('post')
    * def credit = request
    * eval id = id + 1
    * set credit.id = id
    * eval credits[id] = credit
    * def answer = {}
    * set answer.id = id
    * def response = answer

Scenario: pathMatches('/credit')
    * def response = $credits.*

Scenario:
    # catch-all
    * def responseStatus = 404
    * def responseHeaders = { 'Content-Type': 'text/html; charset=utf-8' }
    * def response = <html><body>Not Found</body></html>


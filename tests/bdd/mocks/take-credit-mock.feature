# Created by korwin at 10/11/18
Feature: stateful mock server

Background:
    * configure cors = true
    * configure responseHeaders = { 'Content-Type': 'application/json; charset=utf-8' }
    * def id = 0
    * def credits = {}
    * def incr = function(arg) { return arg + 1;}



Scenario: pathMatches('/credit') && methodIs('post') && typeContains('json')
    * def cred = request
    * eval id = incr(id)
    * eval cred.id = id
    * eval credits[id] = cred
    * def response = {id:'#(id)'}


Scenario: pathMatches('/credit') && methodIs('get') && typeContains('json')
    * def response = credits

Scenario:
    # catch-all
    * def responseStatus = 404
    * def response = { code: 1, message: 'Not Found' }

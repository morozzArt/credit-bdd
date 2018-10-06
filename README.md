# credit-bdd
BDD tests for credit

https://github.com/intuit/karate/blob/933d3803987a736cc1a38893e7039c4b5e5132fc/karate-netty/README.md#standalone-jar


## run mock server
java -jar karate.jar -m tests/bdd/mocks/cats-mock.feature -p 8080

## run test
java -jar karate.jar tests/bdd/cats-test.feature


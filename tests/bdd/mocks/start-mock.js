function(mockName) {
  var Mock = Java.type('com.intuit.karate.netty.FeatureServer');
  var file = new java.io.File('tests/bdd/mocks/' + mockName + '.feature');
  var server = Mock.start(file, 0, false, null);
  return server;
}

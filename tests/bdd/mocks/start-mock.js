function(mockFeatureName) {
    var mock = Java.type('com.intuit.karate.netty.FeatureServer');
    var file = new java.io.File('tests/bdd/mocks/' + mockFeatureName + '.feature');
    var server = mock.start(file, 0, false, null);
    return server;
}

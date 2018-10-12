function(template) {
    var match = Java.type('com.intuit.karate.Match');
    var jsonUtils = Java.type('com.intuit.karate.JsonUtils');
    var request = karate.get('request');

    var requestJson = jsonUtils.toJson(request);
    var templateJson = jsonUtils.toJson(template);

    try {
        match.json(requestJson).contains(templateJson)
    } catch (e) {
        return false;
    }
    return true;
}

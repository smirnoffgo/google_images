import QtQuick 2.7
import '../root'

Item {
    property string url: 'https://www.googleapis.com/customsearch/v1'
    property string method: 'GET'
    property string params: 'imgSize=medium&key=AIzaSyCRyKU5B4N6yEs2US1qTG2aJBo1E-dg-9M&cx=015832491808845338171:cw5q1y-gfeg&searchType=image'
    
    property var getSearchResult: function(query) {
        var request = new XMLHttpRequest()
        
        request.onreadystatechange = function() {
            if (request.readyState === XMLHttpRequest.DONE) {
                if (request.status && request.status === 200) {
                    var result = JSON.parse(request.responseText)
                    print(JSON.stringify(result, null, 2));
                    listView.model = result['items']
                } else {
                    print("HTTP:", request.status, request.statusText)
                }
            }
        }        
        var prm = params + '&q=%1'.arg(encodeURIComponent(query))
        request.open(method, url + '?' + prm)
        print(url + '?' + prm)
        request.send()
    }
}

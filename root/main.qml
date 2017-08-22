import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

ApplicationWindow {
    visible: true
    width: 320
    height: 640
    title: qsTr("Hello World")

    Rectangle {
        id: main

        property int userId: 66586492
        property var friends

        width: 320
        height: 640
        color: 'skyblue'

        property var getFriends: function() {
            var request = new XMLHttpRequest()
            request.open('GET', 'https://www.googleapis.com/customsearch/v1?key=AIzaSyCRyKU5B4N6yEs2US1qTG2aJBo1E-dg-9M&cx=015832491808845338171:cw5q1y-gfeg&q=flower&searchType=image&imgSize=small')
            request.onreadystatechange = function() {
                if (request.readyState === XMLHttpRequest.DONE) {
                    if (request.status && request.status === 200) {
                        var result = JSON.parse(request.responseText)
                        print(JSON.stringify(result, null, 2));
                        main.friends = result['items']
                    } else {
                        console.log("HTTP:", request.status, request.statusText)
                    }
                }
            }
            request.send()
        }

        ListView {
            id: view

            anchors.margins: 10
            anchors.fill: parent
            model: main.friends
            spacing: 10



            delegate: Rectangle {
                width: view.width
                height: 100
                anchors.horizontalCenter: parent.horizontalCenter
                color: 'white'
                border {
                    color: 'lightgray'
                    width: 2
                }
                radius: 10

                MouseArea {
                   anchors.fill: parent
//                   onClicked: {
//                        console.log(index, main.friends[index]['user_id'])
//                        main.userId = main.friends[index]['user_id']
//                        main.getFriends()
//                   }

                }

                Row {
                    anchors.margins: 10
                    anchors.fill: parent
                    spacing: 10

                    Image {
                        id: image

                        height: parent.height
                        fillMode: Image.PreserveAspectFit
                        source: modelData['link']
                    }

//                    Text {
//                        width: parent.width - image.width - parent.spacing
//                        anchors.verticalCenter: parent.verticalCenter
//                        elide: Text.ElideRight
//                        renderType: Text.NativeRendering
//                        text: "%1 %2".arg(modelData['first_name']).arg(modelData['last_name'])

//                    }
                }
            }


        }

        Component.onCompleted: {
            getFriends()
        }
    }


}

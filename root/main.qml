import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import '../io'
import '../models'

ApplicationWindow {    
    property var googleApi: GoogleApi {}
    property var prop: Properties {}
    width: 320
    height: 640
    
    visible: true
    title: prop.windowTitle
    color: prop.windowColor

    Item {
        id: mainItem

        anchors.fill: parent
        anchors.margins: prop.mainMargin

        RowLayout {
            id: row
            z: 1
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true

                color: 'white'

                TextInput {
                    id: textInput
                    anchors.margins: 10
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Button {
                id: btnSearch
                text: qsTr("Search")
                onClicked: {
                    var query = textInput.text
                    googleApi.getSearchResult(query)
                }
            }

        }

        ListView {
            id: listView

            anchors.top: row.bottom
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            model: ImagesModel {}
            spacing: 10


            delegate:
             Rectangle {
                width: parent.width
                height: 300
                color: 'white'

//                Row {
//                    anchors.fill: parent

                    Image {
                        id: image

                        height: parent.height
                        width: parent.width
                        fillMode: Image.PreserveAspectFit
                        source: modelData['link']
                    }
//                }

                Component.onCompleted: {

                }
            }
        }
    }

}

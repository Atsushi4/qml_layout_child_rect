import QtQuick 2.6

ListView {
    id: root
    property var components: []
    property var currentComponent: (currentIndex >= 0 && currentIndex < components.length)
                                        ? components[currentIndex]
                                        : null
    model: components
    width: 80
    height: 160
    Keys.onUpPressed: decrementCurrentIndex()
    Keys.onDownPressed: incrementCurrentIndex()
    delegate: Item {
        width: ListView.view.width
        height: 60
        Text {
            anchors.fill: parent
            text: index
            verticalAlignment: Text.AlignVCenter
        }
    }
    highlight: Rectangle {color: Qt.rgba(0,0,255,0.3)}
}

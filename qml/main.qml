import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3

Item {
    id: window
    anchors.fill: parent
    RowLayout {
        anchors.fill: parent
        ComponentSelector {
            id: componentSelector
            focus: true
            Layout.preferredWidth: 100
            Layout.fillHeight: true
            components: [source0,source1,source2,source3,source4,source5]
            Rectangle {anchors.fill: parent; color: Qt.rgba(255,0,255,0.3)}
        }
        ColumnLayout {
            Layout.alignment: Qt.AlignTop
            Layout.fillWidth: true
            Layout.fillHeight: true
            Text {
                Layout.fillWidth: true
                Layout.preferredHeight: contentHeight
                horizontalAlignment: Text.AlignHCenter
                text: itemWidth + ' x ' + itemHeight
                property int itemWidth: loader.item ? loader.item.item.width : 0
                property int itemHeight: loader.item ? loader.item.item.height : 0
            }
            Loader {
                id: loader
                Layout.fillWidth: true
                Layout.fillHeight: true
                Rectangle {
                    anchors.fill: parent
                    color: Qt.rgba(255, 255, 0, 0.3)
                }
                sourceComponent: componentSelector.currentComponent
            }
        }
    }
    Component { // 0: Image is not affected by width
        id: source0
        ColumnLayout {
            property alias item: content
            Image {
                id: content
                Layout.alignment: Qt.AlignCenter
                width: 200
                height: 200
                source: 'http://www.ptp.co.jp/wp-content/themes/ptpcorp/imgs/img_remocon.jpg'
            }
        }
    }
    Component { // 1: Item is affected by width
        id: source1
        ColumnLayout {
            property alias item: content
            Item {
                id: content
                Layout.alignment: Qt.AlignCenter
                width: 200
                height: 200
                Rectangle {anchors.fill: parent; color: 'red'}
            }
        }
    }
    Component { // 2: Image is affected by Layout.preferredWidth
        id: source2
        ColumnLayout {
            property alias item: content
            Image {
                id: content
                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: 200
                Layout.preferredHeight: 200
                source: 'http://www.ptp.co.jp/wp-content/themes/ptpcorp/imgs/img_remocon.jpg'
            }
        }
    }
    Component { // 3: Item is affected by Layout.preferredWidth
        id: source3
        ColumnLayout {
            property alias item: content
            Item {
                id: content
                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: 200
                Layout.preferredHeight: 200
                Rectangle {anchors.fill: parent; color: 'green'}
            }
        }
    }
    Component { // 4: Image is affected by width without layout
        id: source4
        Item {
            property alias item: content
            Image {
                id: content
                anchors.centerIn: parent
                width: 200
                height: 200
                source: 'http://www.ptp.co.jp/wp-content/themes/ptpcorp/imgs/img_remocon.jpg'
            }
        }
    }
    Component {
        // 5:
        // > Layout.preferredWidth : real
        // > This property holds the preferred width of an item in a layout. If the preferred width is -1 it will be ignored, and the layout will use implicitWidth instead. The default is -1.
        //
        // > implicitWidth : real
        // > The default implicit size for most items is 0x0, however some items have an inherent implicit size which cannot be overridden, for example, Image and Text.
        id: source5
        ColumnLayout {
            property alias item: content
            Image {
                Layout.alignment: Qt.AlignCenter
                id: content
                // implicitWidth: 200 // Error: read-only property
                // implicitHeight: 200 // Error: read-only property
                source: 'http://www.ptp.co.jp/wp-content/themes/ptpcorp/imgs/img_remocon.jpg'
            }
        }
    }
}

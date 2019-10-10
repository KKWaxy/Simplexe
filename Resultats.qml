import QtQuick.Controls 2.4
import QtQuick 2.11

Drawer{
    id:result

    property string solutionOpti
    property string msg

    signal sauver()
    signal solutions()
    bottomMargin:0
    modal: true
    dragMargin: 20
    edge: Qt.RightEdge
    onSolutions:{
        text3.text = msg
        text2.text = solutionOpti
        result.open()
    }

    background: Rectangle {
        id: rectangle
        color: "#5abf8d"
        radius: 10
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        border.color: "#ffffff"
        border.width: 5
        z: 100
        
        Rectangle {
            id: rectangle1
            color: "#ffffff"
            radius: 20
            border.width: 6
            border.color: "#0033ff"
            anchors.rightMargin: 42
            anchors.leftMargin: 30
            anchors.bottomMargin: 25
            anchors.top: label.bottom
            anchors.right: parent.right
            anchors.bottom: confirmer.top
            anchors.left: parent.left
            anchors.topMargin: 17

            Rectangle {
                id: rectangle2
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.top: parent.top
                anchors.topMargin: 30
                width: parent.width*0.5
                height:parent.height*0.6
                color: "#6bdda5"
                radius: 20

                Text {
                    id: text2
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: 20
                    text:""
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 30
                    
                                    }
            }

            Rectangle {
                id: rectangle3
                anchors.top:parent.top
                anchors.topMargin: 47
                anchors.left: parent.left
                anchors.leftMargin: 99

                width: parent.width*0.4
                height: 56
                color: "#cc3827"//"#6bdda5"
                radius: 20
                border.width: 5
                border.color: "#ffffff"

                Text {
                    id: text1
                    anchors.centerIn: parent
                    color: "#ffffff"
                    text: qsTr("Valeur Optimal")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 13
                }
            }

            Text {
                id: text3
                visible: true
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.right: parent.right
                anchors.rightMargin: 10
                //anchors.leftMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                text: ""
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 13
            }
        }

        Button {
            id: infirmer
            text: qsTr("Retourner")
            height: 35
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 15
            anchors.left: parent.left
            anchors.leftMargin: 20
            font.pixelSize: 13
            display: AbstractButton.TextBesideIcon
            icon.width:confirmer.height
            icon.height:confirmer.height
            icon.color: "red"
            icon.source:"./Image/icons8_Delete_32.png"
            background: Rectangle{
                radius: 5
                implicitHeight: infirmer.height
                color: infirmer.down?"#666666":"white"
                implicitWidth: infirmer.width
            }
            onClicked: {
                result.close()
            }
        }

        Label {
            id: label
            width: 315
            color: "#ffffff"
            text: qsTr("Résultas de la Résolution du Programme Lineaire par la Méthode du SIMPLEXE")
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            anchors.horizontalCenterOffset: -5
            anchors.top: parent.top
            anchors.topMargin: 35
            font.pixelSize: 14
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 384
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Button {
            id: confirmer
            height: 35
            text: qsTr("Sauvegarder")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 15
            anchors.right: parent.right
            anchors.rightMargin: 20
            font.pixelSize: 13
            display: AbstractButton.TextBesideIcon
            icon.width:confirmer.height
            icon.height:confirmer.height
            icon.color: "#5abf8d"
            icon.source:"./Image/icons8_Checkmark_32.png"
            background: Rectangle{
                radius: 5
                implicitHeight: confirmer.height
                color: confirmer.down?"#666666":"white"
                implicitWidth: confirmer.width
            }
            onClicked: {
                result.sauver()
                result.close()
            }
        }

    }

}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/

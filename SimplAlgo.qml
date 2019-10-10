import QtQuick 2.0
import QtQuick.Window 2.1
import QtQuick.Controls 2.4
Window{
    title: "ALGORITHME DE SIMPLEXE"

    Item {
        id: item1
        anchors.fill: parent


        Rectangle {
            id: rectangle1
            width: parent.width
            //color: "#6bdda5"
            radius: 10
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "#ffffff"
                }

                GradientStop {
                    position: 1
                    color: "#6bdda5"
                }
            }
            border.width: 3
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 60
            border.color: "#cc3827"

            Text {
                id: text2
                text: qsTr("L'algorithme du simplexe est une des méthodes les plus utilisées dans le cadre de la recherche opérationnelle.La complexité des problèmes à résoudre évolue constamment, de telle sorte que les implémentations existantes s'avèrent parfois trop lentes. En parallèle la technologie évolue et met à notre disposition de nouveaux outils tel que l'algoritme du simplexe.")
                font.bold: true
                font.wordSpacing: 0.6
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 72
                anchors.right: parent.right
                anchors.rightMargin: 63
                anchors.left: parent.left
                anchors.leftMargin: 63
                anchors.top: parent.top
                anchors.topMargin: 69
                font.pixelSize: 16
                color: "#0c0b0b"
            }//#0033ff"
        }
        Rectangle {
            id: rectangle
            width: 300
            height: parent.height*0.2
            color: "#6bdda5"
            radius: 20
            border.width: 5
            border.color: "#cc3827"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10

            Text {
                id: text1
                color: "#ffffff"
                text: qsTr("Algorithme du Simplexe")
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 19
            }
        }
    }


}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:7;anchors_height:200;anchors_width:616}
D{i:8;anchors_x:"-160";anchors_y:50}D{i:5;anchors_height:200;anchors_width:200}
}
 ##^##*/

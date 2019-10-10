import QtQuick 2.11
import QtQuick.Controls 2.4

Item{
    id: item1
    property alias item1Width: item1.width

    signal sClicked()
    anchors.fill: parent
    
    Rectangle {
        id: rectangle
        anchors{left: parent.left}
        width: 278
        height:parent.height
        color: "#272a29"
        radius: 20
        enabled: false
        Image {
            id: image1
            fillMode: Image.PreserveAspectCrop
            anchors{left: parent.left;top:parent.top;bottom: parent.bottom;right: parent.right}
            source: "IMG_20190609_012900.jpg"
        }

        Rectangle {
            id: rectangle5
            radius: 0
            anchors.fill: parent
            z:2
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "#000000"
                }

                GradientStop {
                    position: 0.077
                    color: "#000000"
                }

                GradientStop {
                    position: 0.518
                    color: "#00000000"
                }

                GradientStop {
                    position: 0.93
                    color: "#000000"
                }

                GradientStop {
                    position: 1
                    color: "#000000"
                }



            }
            opacity: 0.8
        }

    }

    Rectangle {
        id: rectangle1
        anchors{right:parent.right;bottom: parent.bottom;left: rectangle.right}
        width: parent.width-rectangle.width
        height: parent.height/2
        color: "#2f4990"
        //"#ef4136"
        radius: 20
        border.width: 0
        anchors.bottomMargin: -16
    }

    Rectangle {
        id: rectangle4
        anchors.horizontalCenter: rectangle1.horizontalCenter
        anchors.verticalCenter: rectangle.verticalCenter
        anchors.verticalCenterOffset: 15
        width: 150
        height: 150
        color: "#ffffff"
        radius: 90
        border.color: "#00000000"

        Rectangle {
            id: rectangle2
            anchors.centerIn: parent
            width: 117
            height: 117
            radius: 90
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color:  "#cc3827"
                }

                GradientStop {
                    position: 1
                    color: "#000000"
                }
            }

            Rectangle {
                id: rectangle3
                anchors.centerIn: parent
                width: 100
                height: 100
                color: "#ebf4ee"
                radius: 90

                Text {
                    id: textEdit
                    anchors.centerIn: parent
                    width: 97
                    height: 118
                    color:"#5abf8d"
                    text: qsTr("S")
                    renderType: Text.NativeRendering
                    anchors.verticalCenterOffset: 9
                    anchors.horizontalCenterOffset: 2
                    font.family: "Arial"
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 97
                    font.weight: Font.Light
                    font.bold: true
                }
                RotationAnimation{
                    id: textEditRotExit
                    duration: 500
                    target:  rectangle3
                    from:90
                    to:0
                    direction: RotationAnimation.Counterclockwise
                }
                RotationAnimation{
                    id: textEditRotEnter
                    duration: 500
                    target:  rectangle3
                    from:0
                    to:90
                    direction: RotationAnimation.Counterclockwise
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled : true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: {
                        textEditRotEnter.start()
                        //probType2ToolTip.width=200
                        //probType2ToolTipText.fontSize=13
                        //probType2ToolTipText.opacity=1
                        //probType1ToolTip.width=1
                       // probType1.opacity=0
                    }
                    onExited: {
                        textEditRotExit.start()
                        //probType2ToolTipText.fontSize=0
                        //probType2ToolTipText.opacity=0
                        //probType2ToolTip.width=0
                        //probType1ToolTip.width=0
                        //probType1.opacity=1

                    }
                    onClicked:{
                        simplexe.flags=Qt.Window
                        view.push(type1)

                    }

                }
            }
        }
    }

    Image {
        id: image
        anchors{left: rectangle.right;right: parent.right;bottom: rectangle1.top;top:parent.top}
        width: 372
        height: parent.height/2
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 42
        //anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        source: "Image/Simplexe2_Simplexe.png"
    }

}


/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/

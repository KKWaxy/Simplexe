import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Window 2.3

ApplicationWindow{
    id:simplexe
    width: 660
    height: 440
    flags:Qt.Dialog
    minimumHeight: 440
    minimumWidth: 650
    visible: true


    //Propriétés

    /*L'élément d'ndice 0 constitue les coeficients de la fonction objectif
    et le  reste constituent les contraintes*/


    Item{
        anchors.fill:parent
        Behavior on width{
            NumberAnimation {
                duration:6000
                easing.type: Easing.InOutQuad
            }
        }
        StackView {
            id: view
            font.weight: Font.Thin
            anchors.fill: parent
            initialItem: Component{
                id:accueil
                Accueil{
                    id:accueilVue

                    //Les icons

                        //  Algo de simplexe
                    RoundButton {
                        id: algoSimpl
                        focusPolicy: Qt.StrongFocus
                        anchors{bottom: parent.bottom;bottomMargin: 15;right: parent.right;rightMargin: 15}
                        icon.color: "#5abf8d"
                        icon.height:algoSimpl.height
                        icon.width: algoSimpl.width
                        icon.source:"Image/icons8_Graduation_Cap_32.png"
                        RotationAnimation{
                            id:algoSimplAnimEnter
                            duration: 500
                            target: algoSimpl
                            from:0
                            to:90
                            direction: RotationAnimation.Counterclockwise
                        }
                        RotationAnimation{
                            id:algoSimplAnimExit
                            duration: 500
                            target: algoSimpl
                            from:90
                            to:0
                            direction: RotationAnimation.Counterclockwise
                        }
                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled : true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                algo.visible = true
                                //view.push(blur)
                                //simplexe.flags=Qt.Window
                            }

                            onEntered: {
                                algoSimplAnimEnter.start()
                                simplAloToolTip.width=245
                                simplAloToolTipText.fontSize=13
                                simplAloToolTipText.opacity=1
                                probType2.opacity=0
                                probType1.opacity=0
                            }
                            onExited: {
                                algoSimplAnimExit.start()
                                simplAloToolTipText.fontSize=0
                                simplAloToolTipText.opacity=0
                                simplAloToolTip.width=0
                                probType2.opacity=1
                                probType1.opacity=1

                            }

                        }
                        }
                    Rectangle{

                        id:simplAloToolTip
                        height: algoSimpl.height
                        color: "#00000000"
                        anchors{bottom: parent.bottom;bottomMargin: 15;right: algoSimpl.right}
                        width:0
                        radius: 360
                        z:3
                        border{color:"#5abf8d";width:2}
                        children:Text {
                            id: simplAloToolTipText
                            property int fontSize
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.horizontalCenterOffset:-12
                            font.pixelSize: fontSize
                            opacity: 0
                            color: "white"
                            text: qsTr("Découvrez l'Algo De Simplexe")
                            Behavior on fontSize{
                                NumberAnimation{duration:500}
                            }
                            Behavior on opacity {
                                NumberAnimation{duration: 500}
                            }
                        }
                        Behavior on width{
                            NumberAnimation{duration:500}
                        }


                    }
                        //Problème de type 2
                    RoundButton {
                        id: probType2

                        focusPolicy: Qt.StrongFocus
                        anchors{bottom: parent.bottom;bottomMargin: 15;right: algoSimpl.left;rightMargin: 10}
                        icon.color: "#5abf8d"
                        icon.height: probType2.height
                        icon.width:  probType2.width
                        icon.source:"Image/icons8__Circled_2_32.png"
                        opacity: 1
                        Behavior on opacity{
                            NumberAnimation{duration: 500}
                        }

                        RotationAnimation{
                            id: probType2Enter
                            duration: 500
                            target:  probType2
                            from:0
                            to:90
                            direction: RotationAnimation.Counterclockwise
                        }
                        RotationAnimation{
                            id: probType2Exit
                            duration: 500
                            target:  probType2
                            from:90
                            to:0
                            direction: RotationAnimation.Counterclockwise
                        }
                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled : true

                            cursorShape: Qt.PointingHandCursor
                            onEntered: {
                                probType2Enter.start()
                                probType2ToolTip.width=200
                                probType2ToolTipText.fontSize=13
                                probType2ToolTipText.opacity=1
                                //probType1ToolTip.width=1
                                probType1.opacity=0
                            }
                            onExited: {
                                probType2Exit.start()
                                probType2ToolTipText.fontSize=0
                                probType2ToolTipText.opacity=0
                                probType2ToolTip.width=0
                                probType1ToolTip.width=0
                                probType1.opacity=1

                            }
                            onClicked:{
                                simplexe.flags=Qt.Window
                                view.push(type1)

                            }

                        }

                    }
                    Rectangle{
                        id:probType2ToolTip
                        height: algoSimpl.height
                        color: "#00000000"//"#ddd4d4"
                        anchors{bottom: parent.bottom;bottomMargin: 15;right: probType2.right}
                        width:0
                        radius: 360
                        z:3
                        border{color:"#5abf8d";width:2}
                        children:Text {
                            id: probType2ToolTipText
                            property int fontSize
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.horizontalCenterOffset: -10
                            font.pixelSize: fontSize
                            opacity: 0
                            color: "white"
                            text: qsTr("Problème de type 2")
                            Behavior on fontSize{
                                NumberAnimation{duration:500}
                            }
                            Behavior on opacity {
                                NumberAnimation{duration: 500}
                            }
                        }
                        Behavior on width{
                            NumberAnimation{duration:500}
                        }

                    }

                    //Problème de type 1
                    RoundButton {
                    id: probType1

                    focusPolicy: Qt.StrongFocus
                    anchors{bottom: parent.bottom;bottomMargin: 15;right: probType2.left;rightMargin: 10}
                    icon.color: "#5abf8d"//"#00a651"
                    icon.height: probType1.height
                    icon.width:  probType1.width
                    icon.source:"Image/icons8_1st_32.png"
                    opacity: 1
                    Behavior on opacity{
                        NumberAnimation{duration: 500}
                    }

                    RotationAnimation{
                        id: probType1Enter
                        duration: 500
                        target:  probType1
                        from:0
                        to:90
                        direction: RotationAnimation.Counterclockwise
                    }
                    RotationAnimation{
                        id: probType1Exit
                        duration: 500
                        target:  probType1
                        from:90
                        to:0
                        direction: RotationAnimation.Counterclockwise
                    }
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled : true
                        cursorShape: Qt.PointingHandCursor
                        onEntered: {
                            probType1Enter.start()
                            probType1ToolTip.width=200
                            probType1ToolTipText.fontSize=13
                            probType1ToolTipText.opacity=1
                        }
                        onExited: {
                            probType1Exit.start()
                            probType1ToolTipText.fontSize=0
                            probType1ToolTipText.opacity=0
                            probType1ToolTip.width=0

                        }
                        onClicked: {
                            simplexe.flags=Qt.Window
                            view.push(type1)
                        }

                    }

                }
                    Rectangle{
                    id:probType1ToolTip
                    height: algoSimpl.height
                    color: "#00000000"//"#ddd4d4"
                    anchors{bottom: parent.bottom;bottomMargin: 15;right: probType1.right}
                    width:0
                    radius: 360
                    z:3
                    border{color: "#5abf8d";width:2}
                    children:Text {
                        id: probType1ToolTipText
                        property int fontSize
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.horizontalCenterOffset: -10
                        font.pixelSize: fontSize
                        opacity: 0
                        color: "white"
                        text: qsTr("Problème de type 1")
                        Behavior on fontSize{
                            NumberAnimation{duration:500}
                        }
                        Behavior on opacity {
                            NumberAnimation{duration: 500}
                        }
                    }
                    Behavior on width{
                        NumberAnimation{duration:500}
                    }

                }

                    //Les Auteurs
                    RoundButton {
                    id: about
                    focusPolicy: Qt.StrongFocus
                    anchors{bottom: parent.bottom;bottomMargin: 15;right: probType1.left;rightMargin: 160}
                    icon.color: "#cc3827"
                    icon.height: about.height
                    icon.width:  about.width
                    icon.source:"Image/icons8_Info_32.png"
                    opacity: 1

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled : true
                        cursorShape: Qt.PointingHandCursor
                        onEntered: {
                        }
                        onExited: {

                        }
                        onClicked: {
                            simplexeAlgo.visible = true
                            //simplexe.flags=Qt.Window
                            //view.push(type1)
                        }

                    }

                }
                    Rectangle{
                    id:aboutToolTip
                    height: algoSimpl.height
                    color: "#00000000"
                    anchors{bottom: parent.bottom;bottomMargin: 15;right: about.right}
                    width:0
                    radius: 360
                    z:3
                    border{color: "#5abf8d";width:2}
                    children:Text {
                        id: aboutToolTipText
                        property int fontSize
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.horizontalCenterOffset: -10
                        font.pixelSize: 0
                        opacity: 0
                        color: "white"
                        text: qsTr("Problème de type 1")
                        /*Behavior on fontSize{
                            NumberAnimation{duration:500}
                        }
                        Behavior on opacity {
                            NumberAnimation{duration: 500}
                        }*/
                    }
                    /*Behavior on width{
                        NumberAnimation{duration:500}
                    }*/

                }

                    SimplAlgo{
                        id:algo
                        visible: false
                        width: simplexe.width-20
                        height: simplexe.height-20

                    }
            }

                }

            }
            Component{
                id:type1
                Type1{
                    id:problemType1

                    onCanceled:{
                        view.pop()
                        simplexe.flags=Qt.Dialog
                    }
                }
            }

           /* Component{
                id:algoSiplexe

                AlgoSimplexe{
                    id: algoSiplexeDoc
                }

            }*/

        }
}

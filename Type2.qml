import Ponts 1.0
import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Controls 1.4 as Ctrl
import QtQuick.Layouts 1.11

Item {
    id: item2
    signal canceled()

    Page {
        id: page
        anchors.fill: parent

        /*Pon{
            id:pont
            foncObjectifCoef:""
            contstraintCoef:""
            typeProble : ""
            onResultat:{

            }
        }*/

        Item {
            id: cadreDroite
            x: 526
            width: 76
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0

            Image {
                id: image1
                fillMode: Image.PreserveAspectCrop
                anchors.fill: parent
                source: "IMG_20190609_012851.jpg"
            }

            Rectangle {
                id: rectangle3
                color: "#0033ff"
                anchors.fill: parent
                opacity: 0.7
            }
            ToolButton{
                id:suivant
                property int taille: parent.width*0.
                width:parent.width*0.5
                height: parent.width*0.5
                z:10
                display: AbstractButton.IconOnly
                icon.width:retour.width
                icon.height:retour.height
                icon.color: "#ffffff"
                icon.source:"./Image/icons8_Right_32.png"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                anchors.horizontalCenter: parent.horizontalCenter
                background: Rectangle {
                     color: "#5abf8d"
                     radius: 180
                    implicitHeight: suivant.height
                    implicitWidth: suivant.width

             }
                onClicked:{
                    //pont.typeProble = typeProb.currentText
                    //pont.contstraintCoef = contraint.coeficiestsVar
                    //pont.foncObjectifCoef = coeficients.getText(0,10000)
                    //pont.resultatst()
                    resultats.open()

                }
            }
        }

        Rectangle{
            id:rect
            height: parent.height*0.3
            anchors.topMargin: 0
            anchors.top: parent.top
            anchors.right: cadreDroite.left
            anchors.rightMargin: 2
            anchors.left: item2.right
            anchors.leftMargin: 2


            ComboBox {
                id: typeProb
                height: 44
                z:3
                font.pixelSize: 15
                font.family: "Arial"
                flat: true
                anchors.left: parent.left
                anchors.leftMargin: 60
                anchors.top: parent.top
                anchors.topMargin: 22
                anchors.right: parent.right
                currentIndex: 1
                anchors.rightMargin: 60
                //onAccepted: page.choix=typeProb.currentIndex
                model:["Maximisation","Minimisation"]
            }
            Row{
                id:nombreVare
                height: 40
                anchors.right: parent.right
                anchors.rightMargin: 60
                anchors.left: parent.left
                anchors.leftMargin: 60
                anchors.top: typeProb.bottom
                spacing:0
                anchors.topMargin: 16

                Rectangle{
                    id:nombreVarRect
                    width: nombreVare.width*0.6
                    height: parent.height
                    color: "#d1d0d0"
                    Label {
                        id: nombreVar
                        text: qsTr("Nombre de Variables:")
                        font.pixelSize: 15
                        //color: ""
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        //width:nombreVare.width*0.6
                        horizontalAlignment: Text.AlignLeft

                    }
                }

                SpinBox{
                    id:valider
                    from:0
                    to:2000
                    value: 3
                    width:nombreVare.width*0.4
                    editable: true
                }
            }

        }
        //Le S de simplexe
        Text {
            id: s
            color: "#cc3827"
            text: qsTr("S")
            opacity: 0.1
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.fill: parent
            z:17
            font.pixelSize: 225
        }

        Item {
            id: cadreGauche
            width: 76
            anchors{left: parent.left;leftMargin: 0;bottom: parent.bottom;bottomMargin: 0;top: parent.top;topMargin: 0}

            Image {
                id: image
                fillMode: Image.PreserveAspectCrop
                anchors.fill: parent
                source: "IMG_20190609_012851.jpg"
            }

            Rectangle {
                id: rectangle2
                color: "#0033ff"
                opacity: 0.9
                anchors.fill: parent
            }
            ToolButton{
                id:retour
                property int taille: parent.width*0.
                width:parent.width*0.5
                height: parent.width*0.5
                z:10
                display: AbstractButton.IconOnly
                icon.width:retour.width
                icon.height:retour.height
                icon.color: "#ffffff"
                icon.source:"./Image/icons8_Left_32.png"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                anchors.horizontalCenter: parent.horizontalCenter
                background: Rectangle {
                     color: "#5abf8d"
                     radius: 180
                    implicitHeight: retour.height
                    implicitWidth: retour.width

             }
                onClicked:   item1.canceled()
            }


        }

        // Déclarations des variables de la fonction Objectif
        Rectangle {
            id: item4
            width: 400
            height: 79
            z: 2
            anchors.top: rect.bottom
            anchors.topMargin: 15
            anchors.right: cadreDroite.left
            anchors.rightMargin: 2
            anchors.left: item2.right
            anchors.leftMargin: 2
            Rectangle{
                id:header
                color: "#5abf8d"
                height:parent.height*0.4
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 60
                anchors.rightMargin: 60
                anchors.bottom: coeficients.top
                anchors.bottomMargin: 0

                Text {
                    id: fonctionEcoText
                    color: "#ffffff"
                    anchors.fill: parent
                    text: qsTr("Coeficients de la fonction Objectif")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family: "Arial"
                    styleColor: "#f1e4e4"
                    font.pixelSize: 15
                }

                ToolButton {
                    id: aide
                    property string icColor:"#0033ff"
                    x: 343
                    y: 0
                    width: parent.height
                    height: parent.height
                    text: qsTr("Tool Button")
                    z: 2
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    anchors.rightMargin: 2
                    display: AbstractButton.IconOnly
                    icon.color: icColor
                    icon.width:aide.height+20
                    icon.height: aide.height+20
                    icon.source: "./Image/icons8_Idea_16.png"
                    background: Rectangle {
                        implicitWidth: aide.height
                        radius: 180
                        implicitHeight: aide.width
                        color: "#00000000"
                    }
                    MouseArea{
                        hoverEnabled: true
                        anchors.fill: parent
                        cursorShape:Qt.WhatsThisCursor
                        onEntered: {
                            indication.height=71
                            indicationText.opacity=1
                            indicationText.fontSize=13
                            aide.icColor="#ffffff"

                        }
                        onExited: {
                            indication.height=0
                            indicationText.opacity=0
                            indicationText.fontSize=0
                            aide.icColor="#0033ff"

                        }
                    }
                }
            }


            TextField {
                id:coeficients
                y: 0
                height: parent.height*0.6
                anchors.rightMargin: 60
                anchors.leftMargin: 60
                horizontalAlignment: Text.AlignHCenter
                anchors.bottomMargin: 0
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                placeholderText: "Exemple:12,15,12,0,0"
                font.bold: true
                font{family: "Arial";pixelSize: 12}

            }

            Rectangle{
                id:indication
                height: 0
                radius: 15
                anchors.rightMargin: 85
                anchors.leftMargin:65
                anchors.left: parent.left
                z:100
                anchors.right: parent.right
                Behavior on  height{

                    NumberAnimation {
                        duration: 300
                    }
                }
                color: "#0033ff"

                Text {
                    id: indicationText
                    property int fontSize
                    color: "#faf7f7"
                    text: qsTr("Entrez les Coeficients de la fonction Objectif en les séparant par des virgules. Avec le constant C comme dernière valeur. Exemple: 12,15,-5,0,")
                    anchors.left:parent.left
                    anchors.leftMargin: 5
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.fill: parent
                    wrapMode: Text.WordWrap
                    font.pixelSize: fontSize
                    renderType: Text.QtRendering
                    font.family: "Arial"
                    opacity: 0
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Behavior on fontSize{
                        NumberAnimation{duration:300}
                    }
                    Behavior on opacity {
                        NumberAnimation{duration: 300}
                    }
                }
            }


        }
        Item {
            id: contraints
            width: 400
            height: 79
            anchors.left: item2.right
            anchors.leftMargin: 2
            anchors.right: cadreDroite.left
            anchors.rightMargin: 2
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.top: item4.bottom
            anchors.topMargin: 10
            Column{
            id: column
            spacing: 0
            z:3
            anchors.left: parent.left
            anchors.leftMargin: 60
            anchors.right: parent.right
            anchors.rightMargin: 60
            anchors.bottomMargin: 20
            anchors.bottom: plus.top
            anchors.top: parent.top
            anchors.topMargin: 22

            Rectangle{
                id:titre
                y: 0
                color: "#0033ff"
                height:parent.height*0.4
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: contraint.top
                anchors.bottomMargin: 0

                ToolButton {
                    id: aide2
                    property string icColor:"#ffffff"

                    width: parent.height
                    height: parent.height*0.2
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    anchors.rightMargin: 2
                    display: AbstractButton.IconOnly
                    icon.color: icColor
                    icon.width:aide2.height+20
                    icon.height: aide2.height+20
                    icon.source: "./Image/icons8_Idea_16.png"
                    background: Rectangle {
                        implicitWidth: aide2.height
                        radius: 180
                        implicitHeight: aide2.width
                        color: "#00000000"
                    }
                    MouseArea{
                        hoverEnabled: true
                        anchors.fill: parent
                        cursorShape:Qt.WhatsThisCursor
                        onEntered: {

                        }
                        onExited: {

                        }
                    }
                }

                Text {
                    id: constraintext
                    color: "#ffffff"
                    anchors.fill: parent
                    text: qsTr("Coeficients de la contraintes.")
                    anchors.topMargin: 0
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family: "Arial"
                    styleColor: "#f1e4e4"
                    font.pixelSize: 15
                }


            }


            TextField {
                id:contraint
                property string coeficiestsVar : ""
                height: parent.height*0.6
                horizontalAlignment: Text.AlignHCenter
                anchors.bottomMargin: 0
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                placeholderText: "Exemple:12,15,12,0,0"
                font.bold: true
                font{family: "Arial";pixelSize: 12}

            }

        }

            ToolButton {
                id: plus
                property string icColor:"#ffffff"
                width:40
                height: 40
                z: 2
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 15
                anchors.horizontalCenter: parent.horizontalCenter
                display: AbstractButton.IconOnly
                icon.color: icColor
                icon.width:plus.height
                icon.height: plus.height
                icon.source: "./Image/icons8_Plus_32.png"
                background: Rectangle {
                    implicitWidth: plus.height
                    radius: 180
                    implicitHeight: plus.width
                    color: "#5abf8d"
                }
                onClicked: {
                    contraint.coeficiestsVar+=contraint.getText(0,20000)+";"
                    contraint.text=""

                }

            }

            }
        }


    Resultats{
        id:resultats
        solutionOpti: ""
        width:item1.width/2
        height:item1.height
        onSauver:{
            //pont.sauvegarder()
        }


    }

}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/

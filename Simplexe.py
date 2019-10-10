# -*- coding: utf-8 -*-

#Impory des fontions d'intéraction avec le systeme
import os
import sys

#Import des Modules PySide2
from PySide2.QtCore import QUrl,QObject,Property,Signal,Slot
from PySide2.QtGui import QGuiApplication,QIcon
import PySide2.QtQml
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtQml import qmlRegisterType
from PySide2.QtQuick import QQuickItem

#Import de la fonction simplexe
import algorithme

class Pont(QQuickItem):
    
    def __init__(self,parent=None):
        
        QQuickItem.__init__(self,parent)
        self.__name =  'u'

    def getName(self):
        return self._name

    def setName(self,valeur):
        self._name =  valeur

    def getFoncObjectifCoef(self):
        return(self.foncOjectifCoef)
    
    def setFoncObjectifCoef(self,valeur):
        self.foncOjectifCoef = valeur

    def getFoncObject(self):
        """"""
        return(self.foncObject)
    def setFoncObject(self,valeur):
        """"""
        self.foncObject = valeur
    
    def getContstraintCoef(self):
        return (self.contraintCoef)

    def setContstraintCoef(self,valeur):
        """"""
        self.contraintCoef = valeur
        
    def getContraints(self):
        """"""
        return(self.contraintes)

    def setContraints(self,valeur):
        """"""
        self.contraintes = valeur
        
    def getTypeProjet(self):
        """"""
        return(self.typeProjet )

    def setTypeProjet(self,valeur):
        """"""
        if(valeur == "Maximisation"):
            self.typeProjet = "max"
        else:
            self.typeProjet = "min"
        
    def getNombreVar(self):
        """"""
        return(self.nombreVar)

    def setNombreVar(self,valeur):
        """"""
        self.nombreVar =  valeur
        
    def getResultas(self):
        """"""
        return(self.resultas)
    
    def setResultas(self,valeur):
        """"""
        self.resultas = valeur
        
    ''' def convertion(self,valeur):
        """"""
        # listeFontionObject,listeContraintes = [],[]
        return(liste) '''
    def setMessage(self, valeur):
        """"""
        self.messag = valeur
        
    def getMessage(self):
        """"""
        return(self.messag)
    
    #Définition QML des Propriétes de la classse
    
    foncObjectifCoef = Property(str,getFoncObjectifCoef,setFoncObjectifCoef)
    foncObjectif = Property(str, getFoncObject,setFoncObject)
    
    contstraintCoef = Property(str,getContstraintCoef,setContstraintCoef)
    contrainte = Property(str,getContraints,setContraints)
    typeProble = Property(str,getTypeProjet,setTypeProjet)
    
    solutOptimal = Property(str, getResultas,setResultas)
    messages = Property(str,getMessage,setMessage)
    
    #Définition des signaux emit par la classe 
    resolution = Signal()
    
    #Définition des Slot capturer par la class
    @Slot()
    def verifFoncObject(self):
        """"""
        equation = algorithme.fonctionObjectif(self.foncOjectifCoef)
        self.setFoncObject(equation)
        self.update()
        
    @Slot()
    def verifContraints(self):
        """"""
        equation = algorithme.contraintes(self.contraintCoef)
        self.setContraints(equation)
        self.update()

    @Slot()
    def sauvegarder(self):
        """ Permet de Sauvegarder les résultas en format csv"""

        #with as csv:
            
    @Slot()
    def resultatst(self):
        #liste = self.convertion()
        #calcule= str(simplexe.simplexe(self.typePro, fonctionOject))
        optimal,message = algorithme.simplexe(self.typeProjet,algorithme.recupFonction(self.foncOjectifCoef),*algorithme.recupContraintes(self.contraintCoef))
        self.setResultas(optimal)
        self.setMessage(message)
        self.update()
        self.resolution.emit()

#Fonction Principale             
if __name__=='__main__':

    #sys.argv += ['--style', 'material']
    app=QGuiApplication(sys.argv)
    
    qmlRegisterType(Pont,"Ponts", 1, 0, "Pon")
    
    icon=QIcon("./Image/icon.bmp")
    # app.setWindowIcon(icon)
    app.setWindowIcon(icon)
    app.setApplicationDisplayName("Simplexe")
    
    engine = QQmlApplicationEngine()
    context = engine.rootContext()
           
    qml=os.path.join(os.path.dirname(__file__),"vue.qml")
    engine.load(QUrl.fromLocalFile(os.path.abspath(qml)))
           
    root=engine.rootObjects()[0]   
    if not root:
        sys.exit(-1)
    sys.exit(app.exec_())


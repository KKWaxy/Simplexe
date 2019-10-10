#### Resolution d'un programme lineaire par la methode du simplexe dit du grand M ####

import copy
from fractions import Fraction as fraction
from copy import deepcopy

######## fonctions qui permettent les calculs avec ligne qui contient le M #####
def somme_M(m1,m2):
        return [m1[0] + m2[0] , m1[1] + m2[1]]



def produit_M(m,x):
        return [m[0]*x , m[1]*x]



def division_M(m,x):
        return [m[0] /x , m[1]/x]



def oppose_M(m):
        return [- m[0] , - m[1]]
###########################################################


def fractionner(contraintes):
        """ Permet de rendre sous forme de fraction toutes les variables du probleme"""
        for i in range(len(contraintes)):
                for j in range(len(contraintes[i])):
                        if i == len(contraintes) - 1:###cas particulier de la derniere ligne du table
                                contraintes[i][j][0] = fraction(str(contraintes[i][j][0]))
                                contraintes[i][j][1] = fraction(str(contraintes[i][j][1]))
                        else:contraintes[i][j] = fraction(str(contraintes[i][j]))
        return contraintes



def fonctionObjective(typeProb,fonction):
        """Cette fonction defini le signe des coefficients de M suivant le type du probleme"""
        if (typeProb == "max"):
                for j in range(len(fonction)):
                        fonction[j][1] = - fonction[j][1]
        return fonction



def standard(contrainte):
        """ Permet d'ajouter une variable afin d'avoir l'egalite au niveau de la contrainte"""
        ### Pour faire simple, < represente en realite <= et > represente en realite >=
        
        if contrainte[-1] == "<":
                contrainte.insert(-2,1) ### quand c'est <= on ajoute
        elif contrainte[-1] == ">":
                contrainte.insert(-2,-1) ###quand c'est  >= on retranche

        return contrainte



       
def forme_standard(fonction,contraintes): ####modification
        """ Permet de d'avoir la matrice standardisee des contraintes du probleme """
        
        lajout = [ ]
        ###permet de collecter les indices des lignes
         ##des contraintes qui seront mises sous forme standard
        for i in range(len(contraintes)):
                if contraintes[ i ][-1] != "=":
                        lajout.append(i)
        
        for elt in lajout:
                contraintes[elt] = standard(contraintes[elt]) ## on met chaque contrainte sous forme standard
                ##et on insere une nouvelle colonne aux autres contraintes avec le coefficient 0
                for j in range(len(contraintes)):       
                        if elt != j:
                                contraintes[j].insert(-2,0)
                                
        ##puis pour terminer on supprime les signes  d'egalite ou inegalite                    
        for i in range(len(contraintes)):                       
                del contraintes[i][-1]
                
        return contraintes 



                
def base_realisable(contraintes):
        """Cette fonction determine les variables de base du probleme"""

        nb_var=len(contraintes[0]) - 1

        varArt = [ ] ## Pour contenir les variables artificielles

        base = [ ] ##cette liste contiendra les differentes variables qui formeront la base realisable
          ## on remplie cette liste de nombre de contraintes fois None
        for i in range(len(contraintes)): 
                base.append(None)
                
        ##puis pour chaque ligne on identifie une possible variable de base
        ##s'il n'y en a pas 
        for i in range(len(contraintes)):                               
                for j in range(len(contraintes[0])):                    
                        if contraintes[i][j] == 1:                              ## Si le coefficient d'une variable vaut 1
                                ajout = True                                    ##alors cette variable peut entrer dans la base
                                
                                ##on verifie alors que ses autres coefficient sont nuls dans les autres contraintes
                                for k in range(len(contraintes)):
                                        if k != i:                              
                                                if contraintes[k][j] != 0: ##lorsqu'on trouve un coefficient non nul
                                                        ajout = False   ##alors cette variable ne peut pas faire partie de la base
                                
                                if ajout:#s'il est toujours possible d'ajouter cette variable
                                           #on remplace le None par xi ( i pour ieme variable du probleme) 
                                        base[i] = "x{}".format(j+1)
                                        
                if base[i] == None:
                        ##s'il y a toujours None apres avoir traiter une contraintes, on ajoute une variable artificielle
                        base[i] = "x{}".format(nb_var + 1)
                        varArt.append(base[i])
                        nb_var+=1
        return (base,varArt)



                                        
def nouvelles_contraintes(contraintes,base):
        """Cette fonction insere les  possibles variales artificielle cree lors de la determination de la base realisable"""
        nb_var = len(contraintes[0]) - 1
        ###nb_var represente le nombre de variable presente dans le probleme avant l'ajout des variables artificielles
        for k in range(len(base)):#pour chaque element de la base....
                if int(base[k][1]) > nb_var:# si xi est superieur a nb_var...
                        for i in range(len(contraintes)):
                                if i == k:                                      ### on insere la variable artifielle a chaque colonne des contraintes
                                        contraintes[i].insert(-1,1)     ## avec le coefficient 1 lorsqu'il a ete ajouter a cette contrainte
                                else:
                                        contraintes[i].insert(-1,0)     ## et avec le coefficient 0 ailleurs
        return contraintes



        
def nouvelle_fonction_objective(fonction,contraintes,base,varArt):
        """ cette fonction determine les nouveaux coefficient des variables du probleme par la methode du grand M

fonction = la liste des coefficients de la fonction objective du depart
contraines = la liste des differentes contraintes
base =les variables formant la base realisable du probleme
var = les variables du probleme de depart
vartArt = les variables artificielles ajoutees"""

        
        tab = [ ]

        ##la liste tab contiendra les expressions des differentes variables de base en fonction des variables hors base
        for k in range(len(base)):
                xn=[]
                ## xn permet de recuperer l'oppose des coefficients(sauf celui de bi) de chaque variable hors base pour ensuites les inserer dans tab
                for j in range(len(contraintes[k]) -1):
                        if j not in [int(elt[1]) - 1 for elt in base ]:
                                xn.append( - contraintes[k][j])
                xn.append(contraintes[k][-1])
                
                tab.append(xn)
        ### a ce niveau tab est remplie comme il faut

        somme = [ ]
        ### somme recuperera les expressions des differentes variables de base en fonction des variables hors base
        ###pour les variables initiales du probleme  ###et les variable d'ecart
        ind =0
        #ind represente l'indice de l'expression de tab succeptible d'etre recuperee par somme

        nul = [ ]
        for i in range(len(fonction) - len(base)):
                nul.append(0)
        
        for i in range( len(fonction) ):##pour chaque variable du probleme
                
                if "x"+str(i+1) in base:##si cette variable est dans la base alors...
                        
                        coeff = fonction.pop(ind)##on recupere son coefficient
                        if "x"+str(i+1) not in varArt:##si de plus cette variable n'est pas artificielle
                                somme.append(tab[base.index("x"+str(i+1))])##on recupere son expression en fonctions des variables hors base dans somme
                                tab[base.index("x"+str(i+1))] = nul ##on remplace cette expression par des 0
                                
                                for j in range(len(somme[-1])):                                 ##puis on multiplie chaque coefficient par coeff
                                        somme[-1][j]*=coeff
                        ind-=1 #puisque tab a un element de moins
                ind +=1
        ##a ce niveau somme est remplie comme il faut
                
        ##on fait maintenant la somme des differentes expressions dans somme
        for k in range(len(somme) - 1):
                for j in range(len(somme[0]) ):
                        somme[0][j] +=somme[1][j]
                somme.pop(1)

        ##ensuite ceux dans tab
        for k in range(len(tab) - 1):
                for j in range(len(tab[0]) ):
                        tab[0][j]+=tab[1][j]
                tab.pop(1)
             
        ##puis on retrouve les nouveaux coefficients de la fonction objective en sommant le tout
        for k in range(len(fonction)):
                if len(somme) != 0:
                        fonction[k]+=somme[0][k]
                fonction[k] = produit_M([1,0],fonction[k])
                if len(tab) !=0:
                        tab[0][k] = produit_M([0,1],tab[0][k])
                        fonction[k] = somme_M(fonction[k],tab[0][k])
                        
        return fonction



def coeff_M_nul(deltaj):
        """ fonction qui renvoie False si au moins un coefficient de M est non nul et True sinon"""
        for i in range(len(deltaj)):
                if deltaj[i][1] !=0:            ##si on trouve un coefficient non nul
                        return False
        return True



def condition_d_arret(delta):
        """ cette fontion renvoi un tuple qu'on peut traduit par (arret,commentChoisirLepivot) """
        deltaj = copy.deepcopy(delta)
        del deltaj[-1]
        
        ##si  au moins un coefficient de M est non nul
        if not coeff_M_nul(deltaj):
                for i in range(len(deltaj)):
                        if deltaj[i][1] < 0:##si on trouve un coefficient de M negatif on continue
                                return (False,1)
                return (True,0) #si aucun des coefficients n'est negatif alors la condition d'arret est realisee

        ##si tous les coefficients de M sont nuls
        else:                                           
                for i in range(len(deltaj)):            
                        if deltaj[i][0] <0:##si on trouve un deltaj negative on continue
                                return (False,0)
                return (True,0) ##sinon la condition d'arret est realisee



def lcpivot(contraintes,choix_colonne):
        """ permet de determiner la ligne et la colonne du pivot

choix_colonne permet de savoir s'il faut utiliser le coefficient de M ou la constante pour le choix de
la colonne du pivot"""
        
        deltaj = copy.deepcopy( contraintes[-1] )
        deltaj.pop()
        
        ##choix de la colonne
        dj = [ d[ choix_colonne ] for d in deltaj ]
       
        cp = dj.index(min(dj))

        ##choix de la ligne
        choix_pivot = [ ]# choix_pivot les differents rapports bi/contraintes[i][cp] pour le choix de la ligne
        for i in range(len(contraintes) - 1):
                if (contraintes[i][cp] == 0 or contraintes[i][cp] < 0):
                        ##dans ces conditions contraintes[i][cp] ne peut pas etre le pivot
                        ##choix_pivot ajoute alors l'infini a cause de min 
                        choix_pivot.append(float("inf"))
                else:
                         choix_pivot.append(contraintes[i][-1] / contraintes[i][cp])
                lp = choix_pivot.index(min(choix_pivot))
                ## Attention !!! lp peut avoir la valeur inf, dans ce cas le probleme n'admet pas de solution
                
        return (lp,cp)




def del_colonne(contraintes,colonne):
        """ permet de supprimer la colonne des contraintres """
        
        for j in range(len(contraintes)):
                contraintes[j].pop(colonne)


                

def pivoter(contraintes,lp,cp,base,varHb,var,varArt):
        """ Cette fonction permet de pivoter le tableau par la methode des carres """

        pivot = contraintes[lp][cp]
        for i in range(len(base)):
                if i != lp:
                        for j in range(len(varHb)+1):
                                if j != cp:
                                        contraintes[i][j] -= contraintes[lp][j]*contraintes[i][cp]/pivot
        for k in range(len(varHb)+1):
                if k != cp:
                        mul = produit_M(contraintes[-1][cp],contraintes[lp][k])
                        div = division_M(mul,pivot)
                        opp = oppose_M(div)
                        contraintes[-1][k] = somme_M(contraintes[-1][k],opp)
                        
        contraintes[lp][cp] = 1/pivot
        
        for i in range(len(base) +1 ):
                if i != lp:
                        if i != len(base):
                                contraintes[i][cp]/=-pivot
                        else:
                                contraintes[i][cp] = division_M(contraintes[i][cp], - pivot)
        for j in range(len(varHb) +1):
                if j != cp:
                        contraintes[lp][j]/=pivot
                  
        sortir = base[lp]
        base[lp] = varHb[cp]
        varHb[cp] = sortir
        if(sortir in varArt):
                del varHb[cp]
                del_colonne(contraintes,cp)

        return (contraintes,base,varHb)


                                
                
        
def calcul_du_cout(contraintes,base,varHb,var,varArt,contraintes1):
        """Cette fonction permet de determiner si on a atteint l'optimum """

        arret = condition_d_arret(contraintes[-1])
        
        while(not  arret[0]):
                
                lp,cp = lcpivot(contraintes,arret[1])
                pivot = contraintes[lp][cp]
                if (lp == float("inf") ):
                        return (False,None,None,None) ##" Le problème est non borné et de ce fait n’admet pas de solution optimale."

                contraintes,base,varHb = pivoter(contraintes,lp,cp,base,varHb,var,varArt)
                
                print(contraintes)
                arret = condition_d_arret(contraintes[-1])
                if contraintes == contraintes1:
                        return (False,contraintes,base,varHb)

        return (True,contraintes,base,varHb)



def solution(contraintes,base,var,varArt,cout):
        """ Juste pour retouner la solution s'il y en a une """

        if contraintes[-1][-1][1] != 0:
                return ("inf","Le problème est non borné et de ce fait n’admet pas de solution optimale.")
        
        for elt in base:
                if ( (elt  in varArt) and contraintes[base.index(elt)][-1] != 0) :
                        return ("0", "le probleme est impossible c’est-a-dire qu’il ne possede pas de solutions realisables.")
        
        solution=str( - contraintes[-1][-1][0])
        
        message = ""
        for elt in var:
                if elt in base:
                        message+= elt + " = " + str((contraintes[base.index(elt)][-1])) + "    "
                else:
                        message+= elt + " = " + "0" + "    "

        return (solution,message)



#################  Fonction Principale de resolution d'un PL ##################        

def simplexe(typeProb, fonction, *contraintes):
        """
 soit a resoudre le probleme:
                                                 min Z = 8x_1 + 7x_2 + 3x _3
                                                 sous contraintes:
                                                2x_1 + x_2 ≥ 1
                                                x_1 + 2x_2 + x_3 ≥ 1
                                                x i ≥ 0, i = 1,··· ,3

        >>>simplexe("min",[8,7,3,0],[2,1,0,1,">"],[1,2,1,1,">"])
        'solution optimal: 5.0  x1 = 0.3333333333333333    x3 = 0.3333333333333333    '
        """
        
        contraintes = list(contraintes)
        var = ["x"+str(i+1) for i in range(len(fonction) - 1)] #definition des variables de depart
        
        contraintes = forme_standard(fonction,contraintes)
        
        base,varArt = base_realisable(contraintes)
        
        contraintes = nouvelles_contraintes(contraintes,base)

        #ajout des variables artifielles et d'ecart a la fonction objective
        e = len(contraintes[0]) -1 - len(var)
        for i in range(e):
                fonction.insert(-1,0)
              
        #definition des variables Hors base
        varHb = [v  for v in [ "x"+str(i+1) for i in range(len(contraintes[0]) - 1) ] if (v not in base)]
        
        fonction =  nouvelle_fonction_objective(fonction,contraintes,base,varArt)
      
        ##suppression des colonnes du tableau des variables hors base realisable
        asupr = [ int( elt[1] ) -1 for elt in base ]
        asupr.sort()
        asupr = [asupr[i] - i for i in range(len(asupr))]
        for i in asupr:
                del_colonne(contraintes, i)


        fonction = fonctionObjective(typeProb,fonction)#redefinition de la foction objective en fonction du type de probleme
        contraintes.append(fonction)

        contraintes1 = contraintes
        
        if typeProb == "max":
                for i in range(len(contraintes[-1]) ):
                        contraintes[-1][i] = oppose_M(contraintes[-1][i])####la aussi

        fonction[-1] = oppose_M(fonction[-1])
        contraintes = fractionner(contraintes)
        
        
        cout,contraintes,base,varHb = calcul_du_cout(contraintes,base,varHb,var,varArt,contraintes1)

        if not cout:
                if contraintes == contraintes1:
                        return ("Impossible", "Probleme insolvable")
                return ("inf","Le problème est non borné et de ce fait n’admet pas de solution optimale.")

        if typeProb == "max":
                        contraintes[-1][-1][0] = - contraintes[-1][-1][0]
        return solution(contraintes, base, var,varArt, cout)

#############################################################################################


def recupFonction(fonction):
        if(fonction==""):
                return []
        
        fonction = fonction.split(" ")
        #print(fonction)
        for i in range(len(fonction)):
                fonction[i] = fraction(fonction[i])
        return fonction


def recupContraintes(contraintes):
        contraintes = contraintes.strip(";")
        contraintes = contraintes.split(";")
        #print(contraintes)
        for i in range(len(contraintes)):
                contraintes[i] = contraintes[i].split(" ")
                signe = contraintes[i][-2]
                contraintes[i][-2] = contraintes[i][-1]
                contraintes[i][-1] = signe
                for j in range(len(contraintes[i]) - 1):
                        contraintes[i][j] = fraction(contraintes[i][j])
        return contraintes


##lulu = simplexe("min",[8,7,3,0],[2,1,0,1,">"],[1,2,1,1,">"])
##
##lala = simplexe("min",[-3,2,0],[2,1,5,"<"],[1,-1,1,"<"],[1,2,3,"<"])


def fonctionObjectif(coefficients):
        """ """
        validitee = controle_fonction(coefficients)
        if validitee:
                coefficients = recupFonction(coefficients)
                fonction="Z =  "
                for i in range(len(coefficients)):
                        signe=""
                        if i !=0 and fraction(coefficients[i]) >= 0:
                                signe = "+"
                        if i != len(coefficients)-1:
                                fonction += signe +str(fraction(coefficients[i])) + "*"  + "X{}".format(i+1)+"  "
                        else:
                                fonction+=signe+str(fraction(coefficients[i]))
                return fonction
        return coefficients

def contraintes(contraintes, fonction):
        """ """
        validitee = controle_contrainte(contrainte, fonction)
        if validitee:
                if contraintes == "":
                        return []
                contraintes = contraintes.strip(";")
                contraintes = contraintes.split(";")
                message=""
                for i in range(len(contraintes)):
                        message+="Contrainte{}:  ".format(i+1)
                        contraintes[i] = contraintes[i].split(" ")
                        for j in range(len(contraintes[i]) ):
                                if j != len(contraintes[i]) -2:
                                        if j != len(contraintes[i]) -1:
                                                signe=""
                                                if j !=0 and fraction(contraintes[i][j]) >= 0:
                                                        signe = "+"                       
                                                message+=signe+str(fraction(contraintes[i][j]))+"*"  + "X{}".format(j+1) +"  "
                                        else:
                                                message+="  "+ str(fraction(contraintes[i][j]))+"\n"                
                                else:
                                        message+=contraintes[i][j]
                return message
        return contraintes

def controle_fonction(fonction):
        """ """
        fonction = fonction.strip(" ")
        fonction = fonction.split(" ")
        if len(fonction) == 1:
                return False
        for i in range(len(fonction)):
                try:
                        fraction(fonction[i])
                except:
                        return False
        return True


def controle_contrainte(contrainte, fonction):
        """ """
        
        contrainte = contrainte.strip(";")
        contrainte = contrainte.split(" ")
        if len(contrainte) -1 != len(fonction):
                return False
        for i in range(len(contrainte)):
                if i != len(contrainte) - 2: 
                        try:
                                fraction(contrainte[i])
                        except:
                                return False
                else:
                        if contrainte[i] not in [">","<","="]:
                                return False
        return True



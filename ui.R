#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

pacman :: p_load(shiny, shinythemes,colourpicker, DT, rAmCharts, leaflet)

# Define UI for application that draws a histogram
fluidPage(theme = shinytheme("superhero"),
  
  # Application title
  titlePanel("Carte instantanée de l'actualité"), 
  
  
  navbarPage(
    
    #Titre navbar et logo rennes metropole
    title = div( tags$a(img(src = "RENNES_logo_noir.png", 
                            width = '96px' ),
                
                  href="https://metropole.rennes.fr/")
                
                ),#Fermeture du div()
    
    
    
    #Onglet : Actualité générale
    tabPanel( "Actualité générale ", 
             h3("Actualités du jour et en direct"),
             fluidRow(
               #siderebarPanel
               column(width = 4, 
                      wellPanel(
                        
                        #Rechercher un sujet en particulier
                        textInput(input="sujet", 
                                  label = "Recherche : ", 
                                  value = "Sujet"),
                        
                        #Choix du quartier
                        radioButtons(inputId = "quartier", 
                                     choices = c("Sainte-Anne", "République", "Gare", "Cesson"), 
                                     label = "Choisissez un quartier"),
                        
                        #Affiche les 5er article
                        h6("titre: -------"),
                        h6("date : ------ "),
                        h6("lien: -------"),
                        h6("date : ------ "),
                        h6("titre: -------"),
                        h6("lien : ------ "),
                        
                        #Ajout du boutton GO
                        actionButton("go_graph", "Appliquer le filtre"))),
               
               
               #mainPanel
               column(width = 8,
                      leafletOutput("test", height=500))
                        
               )
             
             ),
    
    
    
    
    #Onglet : Economie
    tabPanel("Economie", 
             h3("Résumé statistique de la table"),
             #Ajout de la sortie du summary
             plotOutput("boxPlot")),
    
    
    #Onglet :Faits divers
    tabPanel("Faits divers", 
             h3("Présentation de la table")),
    
    
    #Onglet : Société
    tabPanel("Société", 
             h3("Présentation de la table"))
    
               
             
    
  )# Ferme navbarPage
  
)#Ferme fluidPage

# 1. required packages --------------------------------------------------------
# 
# 
# 

pacman :: p_load(shiny,colourpicker, DT, rAmCharts, leaflet)


fonction_test = function(){
     
                x1 = runif(10)
                y1 = rnorm(10)
                plot(x1, y1)
 
}



carte_rennes <- function(){
  
  Rennes <- c( -1.67778,48.1173)
  leaflet() |> addTiles() |>
  setView(lng = Rennes[1], lat = Rennes[2],zoom=12.5)
  
}




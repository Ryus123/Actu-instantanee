# 1. required packages --------------------------------------------------------
# 
# 
pacman :: p_load(rvest, dplyr,tidyverse, parallel)

# 2. Fonction --------------------------------------------------------

#Recupere les liens des 15 arcticle les plus récent
lien_article <- function(tag){
    lien = tag %>% 
              html_nodes("li.element") %>% 
              head(15) %>% 
              html_element("a") %>% 
              html_attr("href") %>% 
              str_c("https://rennes.maville.com/", . , sep="")
  return(lien)
  }


#Applique un traitement pour les articles complets et ceux non complet
text_Pub_noPub <- function(tag) {
  texte = tag %>% html_nodes("h2.elmt-text")  %>% html_text2()
  if(texte ==""){
    texte = tag %>% html_nodes("section.clearB.bloc") %>% 
      html_nodes("p") %>% html_text() %>% paste(collapse = ' ') 
  }
  return(str_squish(texte))
}



#Recupere l' (bout) articles, le titre et la date sur chaque lien
scrap_article <- function(url){
    tag <- read_html(url)
    df <- tibble(date = tag %>% html_nodes("time.elmt-date") %>% html_text(),
                 titre = tag %>% html_nodes("h1") %>% html_text(), 
                 text = tag %>% text_Pub_noPub(), 
                 lien = url )
    return(df)
  }






# 3. Fouille --------------------------------------------------------
# 
# 

#Page d'acceuil Ouest-France Rennes

html_actu = read_html("https://rennes.maville.com/info/info-locale/") 

#Recuperation des 15 articles sur la page d'acceuil
url_news = lien_article(html_actu)

#Multiprocessing pour le parcours des pages
system.time(
  resultat <- mclapply(url_news, scrap_article, mc.cores = 7)
 )

#Dataframe qui contient pour chaque article, la date, le titre, le texte et le lien
resultat = resultat %>% map_dfr(bind_rows)





Choose_Dataset <- function(data, choix_filiere, choix_famille, choix_reseau, choix_coefficient){
  if (length(filiere_reactive$filiere)==1){
    effectifs <- data %>%  filter(filiere %in%  choix_filiere) %>% group_by(famille)  %>% summarise(count=n()) %>% mutate(categorie_choisie=famille)
  } else {
    effectifs <- data %>%  group_by(filiere)  %>% summarise(count=n()) %>% mutate(categorie_choisie=filiere)
  }
  
  if (length(famille_reactive$famille)==1){
    effectifs <- data %>%  filter(famille %in%  choix_famille) %>% group_by(code_repere)  %>% summarise(count=n()) %>% mutate(categorie_choisie=code_repere)
  }
  
  if (length(reseau_reactive$reseau)==1){
    effectifs <- effectifs %>% filter(reseau %in% choix_reseau)
  }
  
  if (length(coef_reactive$coef)==1){
    effectifs <- effectifs %>% filter(reseau %in% choix_reseau)
  }
  return(effectifs)
}
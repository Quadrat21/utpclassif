#Import packages
library(DT)
library(shinyWidgets)
library(shiny)
library(highcharter)
library(writexl)
library(readr)
library(tidyr)
library(shinydashboard)
library(shinyalert)
library(shinyjs)
library(readxl)
library(htmltools)
library(stringr)
library(glue)
# library(shinyBS)
library(dplyr)


#Chargement des packages

#Chargement des bases de données 

salaires <- readRDS('Data/BaseSalaries.rds')


#Création de certaines variables vouées à être statiques 

salaires <- salaires %>%  mutate(filiere=case_when(
  filiere=="1 - EXPLOITATION" ~ "1 - Exploitation",
  filiere=="2 - MAINTENANCE"~ "2 - Maintenance", 
  filiere=="3 - SÛRETÉ"~ "3 - Sûreté", 
  filiere=="4 - QHSE" ~ "4 - QHSE",
  filiere=="5 - SYSTEMES INFORMATIQUES ET D'INFORMATION" ~ "5 - Systèmes informatiques et d'information",
  filiere=="6 - BUREAU D'ETUDES ET METHODES" ~ "6 - Bureau d'études et méthodes",
  filiere=="7 - DEVELOPPEMENT COMMERCIAL, MARKETING ET COMMUNICATION" ~ "7 - Développement commercial, marketing et communication",
  filiere=="8 - METIERS TRANSVERSES" ~ "8 - Métiers transverses",
  TRUE ~ filiere
  
)) %>% filter(tps_partiel == "1") 


salaires <- salaires %>% mutate(
  EMPLOI = casefold(EMPLOI, upper=F)
) %>% mutate(
  EMPLOI = iconv(EMPLOI, from = "UTF-8", to = "ASCII//TRANSLIT")
) %>% mutate(
  EMPLOI = str_replace_all(EMPLOI, "-", " "),
  EMPLOI = str_replace_all(EMPLOI, "\\(trice\\)", ""),
  EMPLOI = str_replace_all(EMPLOI, "\\(ne\\)", ""),
  EMPLOI = str_replace_all(EMPLOI, "\\(e\\)", ""),
  EMPLOI = str_replace_all(EMPLOI, "\\(\\)", ""),
  EMPLOI = str_replace_all(EMPLOI, "chargee", "charge"),
  EMPLOI = str_replace_all(EMPLOI, "conductrice", "conducteur"),
  EMPLOI = str_replace_all(EMPLOI, "technicienne", "technicien"),
  EMPLOI = str_replace_all(EMPLOI, "conseillere", "conseiller"),
  EMPLOI = str_replace_all(EMPLOI, "assistante", "assistant"),
  EMPLOI = str_replace_all(EMPLOI, "cond\\.", "conducteur "),
  EMPLOI = str_replace_all(EMPLOI, "conduct\\.", "conducteur"),
  EMPLOI = str_replace_all(EMPLOI, "rec\\.", "receveur "),
  EMPLOI = str_replace_all(EMPLOI, "recev\\.", "receveur"),
  EMPLOI = str_replace_all(EMPLOI, "CONDUCTEUR-RECEVEUR.", "CONDUCTEUR RECEVEUR"),
  EMPLOI = str_replace_all(EMPLOI, "CONDUCT. RECEV.", "CONDUCTEUR RECEVEUR"),
  
  
  q_primevac_old = q_primevac,
  q_prime13_old = q_prime13,
  q_prime14_old = q_prime14,
  q_primeobj_old = q_primeobj,
  q_primepol_old = q_primepol,
  q_primeorg_old = q_primeorg,
  q_primecar_old = q_primecar,
  q_primeanc_old = q_primeanc,
  q_salmens_old = q_salmens,
  q_salanc_old = q_salanc,
  q_remannu_old = q_remannu
  
    
)

seuil_significativite = 10
seuil_pourcentage_libelle_emploi = 0.02
#salaires <- salaires %>%  mutate(code_repere_1 = as.numeric(code_repere_1)) %>% order(code_repere_1) 

list_filieres=sort(unique(salaires$filiere))
list_familles=unique(salaires$famille) 
list_codes_repere=unique(salaires$code_repere)

#Appel et création de fonctions

QsetSliderColor <- source(file = "Funs/QsetSliderColor.R")
Choose_Dataset <- source(file = "Funs/Choose_Dataset.R")



# Création d'une fonction qui, en entrée, prend le salaire et le minimum social et calcul le cout:
Calcul_cout_mois <- function(salaire, minimum) {
  ifelse(minimum - salaire > 0, round(minimum - salaire), 0)
}


#Assimile les valeurs des scores seuils par défaut pour chaque nombre de classifications ####

default_values <- list(
  "8" = list(A = 6, B = 7, C = 8, D = 9, E = 10, F = 11, G = 12, H = 30),
  "9" = list(A = 6, B = 7, C = 8, D = 9, E = 10, F = 11, G = 12, H = 13, I = 30),
  "10" = list(A = 6, B = 7, C = 8, D = 9, E = 10, F = 11, G = 12, H = 13, I = 14, J = 30),
  "11" = list(A = 6, B = 7, C = 8, D = 9, E = 10, F = 11, G = 12, H = 13, I = 14, J = 15, K = 30),
  "12" = list(A = 6, B = 7, C = 8, D = 9, E = 10, F = 11, G = 12, H = 13, I = 14, J = 15, K = 16, L = 30),
  "13" = list(A = 6, B = 7, C = 8, D = 9, E = 10, F = 11, G = 12, H = 13, I = 14, J = 15, K = 16, L = 17, M = 30),
  "14" = list(A = 6, B = 7, C = 8, D = 9, E = 10, F = 11, G = 12, H = 13, I = 14, J = 15, K = 16, L = 17, M = 18, N = 30)
)
default_values <- append(default_values, list(
  "15" = list(A = 6, B = 7, C = 8, D = 9, E = 10, F = 11, G = 12, H = 13, I = 14, J = 15, K = 16, L = 17, M = 18, N = 19, O = 30),
  "16" = list(A = 6, B = 7, C = 8, D = 9, E = 10, F = 11, G = 12, H = 13, I = 14, J = 15, K = 16, L = 17, M = 18, N = 19, O = 20, P = 30)
))
default_values <- append(default_values, list(
  "17" = list(A = 6, B = 7, C = 8, D = 9, E = 10, F = 11, G = 12, H = 13, I = 14, J = 15, K = 16, L = 17, M = 18, N = 19, O = 20, P = 21, Q = 30),
  "18" = list(A = 6, B = 7, C = 8, D = 9, E = 10, F = 11, G = 12, H = 13, I = 14, J = 15, K = 16, L = 17, M = 18, N = 19, O = 20, P = 21, Q = 22, R = 30)
))
default_values <- append(default_values, list(
  "19" = list(A = 6, B = 7, C = 8, D = 9, E = 10, F = 11, G = 12, H = 13, I = 14, J = 15, K = 16, L = 17, M = 18, N = 19, O = 20, P = 21, Q = 22, R = 23, S = 30),
  "20" = list(A = 6, B = 7, C = 8, D = 9, E = 10, F = 11, G = 12, H = 13, I = 14, J = 15, K = 16, L = 17, M = 18, N = 19, O = 20, P = 21, Q = 22, R = 23, S = 24, T = 30),
  "21" = list(A = 6, B = 7, C = 8, D = 9, E = 10, F = 11, G = 12, H = 13, I = 14, J = 15, K = 16, L = 17, M = 18, N = 19, O = 20, P = 21, Q = 22, R = 23, S = 24, T = 25, U = 30)
))

tp_emploi_repere_code_repere <- read_excel("Data/tp_emploi_repere_code_repere.xlsx")

#Création d'une variable de tranche d'ancienneté.
salaires <- salaires %>%
  mutate(tranc = case_when(
    anc < 2.5 ~ "1 - À l'embauche",
    anc >= 2.5 & anc < 5 ~ "2 - [ 2,5 ans; 5 ans [",
    anc >= 5 & anc < 7.5 ~ "3 - [ 5 ans; 7,5 ans [",
    anc >= 7.5 & anc < 10 ~ "4 - [ 7,5 ans; 10 ans [",
    anc >= 10 & anc < 15 ~ "5 - [ 10 ans; 15 ans [",
    anc >= 15 & anc < 20 ~ "6 - [ 15 ans; 20 ans [",
    anc >= 20 & anc < 25 ~ "7 - [ 20 ans; 25 ans [",
    anc >= 25 & anc < 30 ~ "8 - [ 25 ans; 30 ans [",
    TRUE ~ "9 - plus de 30 ans"
  ))

#On renomme les catégories


salaires <- salaires %>%
  mutate(CAT= case_when(
    CAT == "1O"~ "1 - Ouvriers",
    CAT == "2E" ~ "2 - Employés",
    CAT == "3T" ~ "3 - Maîtrises techniciens",
    CAT == "4C" ~ "4 - Ingénieurs et cadres",
  ))

# Enlever les apostrophes des emplois-repère

salaires <- salaires %>% mutate(lib_repere = gsub("\'", " ", lib_repere))

# Scores initiaux pour les emplois-repère

# 5--

# 6--

# 7--

# 8--

score_init_agent_manoeuvre = 8

score_init_gestionnaire_parc_velo = 8

# 9--

# 10--

score_init_agent_surete = 10
score_init_aiguilleur = 10
score_init_assistant_controle_gestion = 10
score_init_collecteur_recettes = 10
score_init_mediateur = 10

# 11--

score_init_agent_back_office = 11
score_init_conducteur_mobilite_reduite = 11
score_init_conducteur_receveur = 11
score_init_conseiller_commercial = 11
score_init_gestionnaire_approvisionnement_stock = 11
score_init_verificateur = 11
score_init_conducteur_bus = 11
score_init_conducteur_metro = 11
score_init_conducteur_multimodal = 11

# 12--

score_init_agent_charge_methodes_exploitation = 12
score_init_agent_planning = 12
score_init_assistant_commercial_marketing = 12
score_init_assistant_rh = 12
score_init_manager_verificateur = 12
score_init_operateur_technique_information_voyageur = 12
score_init_technicien_maintenance_parc = 12
score_init_technicien_maintenance = 12

# 13--

score_init_technicien_intervention_systeme_automatique_autonome = 13

# 14--

score_init_animateur_qualite = 14
score_init_animateur_securite_prevention = 14
score_init_assistant_direction = 14
score_init_charge_communication = 14
score_init_charge_web_editorial = 14
score_init_gestionnaire_paie = 14
score_init_infographiste = 14
score_init_regulateur = 14

# 15--

score_init_charge_marketing = 15
score_init_charge_recrutement = 15
score_init_community_manager = 15
score_init_formateur = 15

# 16--

score_init_agent_surete_port_armes = 16
score_init_charge_etudes = 16
score_init_comptable = 16
score_init_controleur_gestion = 16
score_init_manager_conducteur = 16
score_init_manager_conseiller_commerciaux = 16
score_init_manager_equipe_agent_surete = 16
score_init_operateur_pc_surete = 16
score_init_responsable_approvisionnement_gestion_stocks = 16
score_init_technicien_exploitation = 16

# 17--

score_init_acheteur_commande_publique = 17
score_init_administrateur_systeme_reseau = 17
score_init_charge_developpeur = 17
score_init_technicien_superieur_communication = 17

# 18--

score_init_manager_technicien_maintenance = 18
score_init_manager_technicien_maintenance_parc = 18
score_init_manager_equipe_agent_surete_port_arme = 18
score_init_responsable_agent_commercial = 18
score_init_responsable_formation = 18
score_init_responsable_service_client= 18
score_init_technicien_methode = 18

# 19--

score_init_chef_projet_appel_offre = 19
score_init_gestionnaire_assurance = 19
score_init_ingenieur_cybersecurite = 19
score_init_ingenieur_maintenance = 19
score_init_responsable_bureau_etudes_methodes = 19

# 20--

score_init_gestionnaire_contrats = 20
score_init_juriste = 20
score_init_responsable_communication = 20
score_init_responsable_comptabilite = 20
score_init_responsable_fraude = 20
score_init_responsable_performance_operationnelle = 20
score_init_responsable_secteur = 20

# 21--

score_init_ingenieur_financier = 21
score_init_responsable_equipe_achat_commande_publique = 21
score_init_responsable_maintenance = 21
score_init_responsable_RSE = 21

# 22--

score_init_ingenieur_methodes = 22
score_init_responsable_exploitation = 22
score_init_responsable_qualite = 22

# 23--

score_init_chef_projet_ingenieur_si = 23
score_init_responsable_appel_offre = 23
score_init_responsable_securite_prevention = 23

# 24--

score_init_responsable_HSE = 24
score_init_responsable_juridique = 24
score_init_responsable_relations_institutionnelles = 24

# 25--

score_init_responsable_administratif_financier = 25
score_init_responsable_production_operation = 25
score_init_responsable_Si = 25
score_init_responsable_marketing = 25
score_init_responsable_rh = 25

# 26--

# 27--

# 28--

# 29--

# 30--

score_init_responsable_societe = 30
###################################
############### Seuils de départ
###################################

plafond_init_8_A = 7
plafond_init_8_B = 10
plafond_init_8_C = 13
plafond_init_8_D = 16
plafond_init_8_E = 19
plafond_init_8_F = 22
plafond_init_8_G = 25
plafond_init_8_H = 30

plafond_init_9_A=6
plafond_init_9_B=7
plafond_init_9_C=10
plafond_init_9_D=13
plafond_init_9_E=16
plafond_init_9_F=19
plafond_init_9_G=22
plafond_init_9_H=25
plafond_init_9_I=30

plafond_init_10_A=6
plafond_init_10_B=7
plafond_init_10_C=10
plafond_init_10_D=12
plafond_init_10_E=14
plafond_init_10_F=16
plafond_init_10_G=19
plafond_init_10_H=22
plafond_init_10_I=25
plafond_init_10_J=30


plafond_init_11_A = 6
plafond_init_11_B = 8
plafond_init_11_C = 10
plafond_init_11_D = 12
plafond_init_11_E = 14
plafond_init_11_F = 16
plafond_init_11_G = 18
plafond_init_11_H = 20
plafond_init_11_I = 22
plafond_init_11_J = 24
plafond_init_11_K = 30

plafond_init_12_A=6
plafond_init_12_B=8
plafond_init_12_C=9
plafond_init_12_D=10
plafond_init_12_E=12
plafond_init_12_F=14
plafond_init_12_G=16
plafond_init_12_H=18
plafond_init_12_I=20
plafond_init_12_J=22
plafond_init_12_K=24
plafond_init_12_L=30
plafond_init_13_A=6
plafond_init_13_B=7
plafond_init_13_C=8
plafond_init_13_D=9
plafond_init_13_E=10
plafond_init_13_F=12
plafond_init_13_G=14
plafond_init_13_H=16
plafond_init_13_I=18
plafond_init_13_J=20
plafond_init_13_K=22
plafond_init_13_L=24
plafond_init_13_M=30

plafond_init_14_A=5
plafond_init_14_B=6
plafond_init_14_C=7
plafond_init_14_D=8
plafond_init_14_E=9
plafond_init_14_F=10
plafond_init_14_G=12
plafond_init_14_H=14
plafond_init_14_I=16
plafond_init_14_J=18
plafond_init_14_K=20
plafond_init_14_L=22
plafond_init_14_M=24
plafond_init_14_N=30

plafond_init_15_A=5
plafond_init_15_B=6
plafond_init_15_C=7
plafond_init_15_D=8
plafond_init_15_E=9
plafond_init_15_F=10
plafond_init_15_G=11
plafond_init_15_H=12
plafond_init_15_I=14
plafond_init_15_J=16
plafond_init_15_K=18
plafond_init_15_L=20
plafond_init_15_M=22
plafond_init_15_N=24
plafond_init_15_O=30

plafond_init_16_A=5
plafond_init_16_B=6
plafond_init_16_C=7
plafond_init_16_D=8
plafond_init_16_E=9
plafond_init_16_F=10
plafond_init_16_G=11
plafond_init_16_H=12
plafond_init_16_I=13
plafond_init_16_J=14
plafond_init_16_K=16
plafond_init_16_L=18
plafond_init_16_M=20
plafond_init_16_N=22
plafond_init_16_O=24
plafond_init_16_P=30

plafond_init_17_A=5
plafond_init_17_B=6
plafond_init_17_C=7
plafond_init_17_D=8
plafond_init_17_E=9
plafond_init_17_F=10
plafond_init_17_G=11
plafond_init_17_H=12
plafond_init_17_I=13
plafond_init_17_J=14
plafond_init_17_K=15
plafond_init_17_L=16
plafond_init_17_M=18
plafond_init_17_N=20
plafond_init_17_O=22
plafond_init_17_P=24
plafond_init_17_Q=30

plafond_init_18_A=5
plafond_init_18_B=6
plafond_init_18_C=7
plafond_init_18_D=8
plafond_init_18_E=9
plafond_init_18_F=10
plafond_init_18_G=11
plafond_init_18_H=12
plafond_init_18_I=13
plafond_init_18_J=14
plafond_init_18_K=15
plafond_init_18_L=16
plafond_init_18_M=17
plafond_init_18_N=18
plafond_init_18_O=20
plafond_init_18_P=22
plafond_init_18_Q=24
plafond_init_18_R=30

plafond_init_19_A=5
plafond_init_19_B=6
plafond_init_19_C=7
plafond_init_19_D=8
plafond_init_19_E=9
plafond_init_19_F=10
plafond_init_19_G=11
plafond_init_19_H=12
plafond_init_19_I=13
plafond_init_19_J=14
plafond_init_19_K=15
plafond_init_19_L=16
plafond_init_19_M=17
plafond_init_19_N=18
plafond_init_19_O=19
plafond_init_19_P=20
plafond_init_19_Q=22
plafond_init_19_R=24
plafond_init_19_S=30

plafond_init_20_A=5
plafond_init_20_B=6
plafond_init_20_C=7
plafond_init_20_D=8
plafond_init_20_E=9
plafond_init_20_F=10
plafond_init_20_G=11
plafond_init_20_H=12
plafond_init_20_I=13
plafond_init_20_J=14
plafond_init_20_K=15
plafond_init_20_L=16
plafond_init_20_M=17
plafond_init_20_N=18
plafond_init_20_O=19
plafond_init_20_P=20
plafond_init_20_Q=21
plafond_init_20_R=22
plafond_init_20_S=24
plafond_init_20_T=30

plafond_init_21_A=5
plafond_init_21_B=6
plafond_init_21_C=7
plafond_init_21_D=8
plafond_init_21_E=9
plafond_init_21_F=10
plafond_init_21_G=11
plafond_init_21_H=12
plafond_init_21_I=13
plafond_init_21_J=14
plafond_init_21_K=15
plafond_init_21_L=16
plafond_init_21_M=17
plafond_init_21_N=18
plafond_init_21_O=19
plafond_init_21_P=20
plafond_init_21_Q=21
plafond_init_21_R=22
plafond_init_21_S=23
plafond_init_21_T=24
plafond_init_21_U=30


plafond_init_21_A = 5
plafond_init_21_B = 6
plafond_init_21_C = 7
plafond_init_21_D = 8
plafond_init_21_E = 9
plafond_init_21_F = 10
plafond_init_21_G = 11
plafond_init_21_H = 12
plafond_init_21_I = 13
plafond_init_21_J = 14
plafond_init_21_K = 15
plafond_init_21_L = 16
plafond_init_21_M = 17
plafond_init_21_N = 18
plafond_init_21_O = 19
plafond_init_21_P = 20
plafond_init_21_Q = 21
plafond_init_21_R = 22
plafond_init_21_S = 23
plafond_init_21_T = 24
plafond_init_21_U = 30


plafond_init_22_A = 5
plafond_init_22_B = 6
plafond_init_22_C = 7
plafond_init_22_D = 8
plafond_init_22_E = 9
plafond_init_22_F = 10
plafond_init_22_G = 11
plafond_init_22_H = 12
plafond_init_22_I = 13
plafond_init_22_J = 14
plafond_init_22_K = 15
plafond_init_22_L = 16
plafond_init_22_M = 17
plafond_init_22_N = 18
plafond_init_22_O = 19
plafond_init_22_P = 20
plafond_init_22_Q = 21
plafond_init_22_R = 22
plafond_init_22_S = 23
plafond_init_22_T = 24
plafond_init_22_U = 25
plafond_init_22_V = 30

plafond_init_23_A = 5
plafond_init_23_B = 6
plafond_init_23_C = 7
plafond_init_23_D = 8
plafond_init_23_E = 9
plafond_init_23_F = 10
plafond_init_23_G = 11
plafond_init_23_H = 12
plafond_init_23_I = 13
plafond_init_23_J = 14
plafond_init_23_K = 15
plafond_init_23_L = 16
plafond_init_23_M = 17
plafond_init_23_N = 18
plafond_init_23_O = 19
plafond_init_23_P = 20
plafond_init_23_Q = 21
plafond_init_23_R = 22
plafond_init_23_S = 23
plafond_init_23_T = 24
plafond_init_23_U = 25
plafond_init_23_V = 26
plafond_init_23_W = 30

plafond_init_24_A = 5
plafond_init_24_B = 6
plafond_init_24_C = 7
plafond_init_24_D = 8
plafond_init_24_E = 9
plafond_init_24_F = 10
plafond_init_24_G = 11
plafond_init_24_H = 12
plafond_init_24_I = 13
plafond_init_24_J = 14
plafond_init_24_K = 15
plafond_init_24_L = 16
plafond_init_24_M = 17
plafond_init_24_N = 18
plafond_init_24_O = 19
plafond_init_24_P = 20
plafond_init_24_Q = 21
plafond_init_24_R = 22
plafond_init_24_S = 23
plafond_init_24_T = 24
plafond_init_24_U = 25
plafond_init_24_V = 26
plafond_init_24_W = 27
plafond_init_24_X = 30


plafond_init_25_A = 5
plafond_init_25_B = 6
plafond_init_25_C = 7
plafond_init_25_D = 8
plafond_init_25_E = 9
plafond_init_25_F = 10
plafond_init_25_G = 11
plafond_init_25_H = 12
plafond_init_25_I = 13
plafond_init_25_J = 14
plafond_init_25_K = 15
plafond_init_25_L = 16
plafond_init_25_M = 17
plafond_init_25_N = 18
plafond_init_25_O = 19
plafond_init_25_P = 20
plafond_init_25_Q = 21
plafond_init_25_R = 22
plafond_init_25_S = 23
plafond_init_25_T = 24
plafond_init_25_U = 25
plafond_init_25_V = 26
plafond_init_25_W = 27
plafond_init_25_X = 28
plafond_init_25_Y = 30


QuseShinydashboard <- function() {
  if (!requireNamespace(package = "shinydashboard"))
    message("Package 'shinydashboard' is required to run this function")
  deps <- findDependencies(shinydashboard::dashboardPage(
    header = shinydashboard::dashboardHeader(),
    sidebar = shinydashboard::dashboardSidebar(),
    body = shinydashboard::dashboardBody()
  ))
  attachDependencies(tags$div(class = "main-sidebar", style = "display: none;"), value = deps)
}

translate_var_col = list("CODPOS" = "Code postal", "trage2" = "Tranche d'âge", "EMPLOI" = "Libellé emploi", "grp" = "Groupe", "scores" = "Score",
                         "revalorise_oui" = "Salarié revalorisé", "depetab" = "Département", "regetab" = "Région", "nom_entr" = "Réseau",
                         "libcom" = "Ville", "CLASSE" = "Classe de réseau", "groupe_empl" = "Groupe employeur", "ID" = "Identifiant UTP", "age" = "Âge",
                         "MOD_ANC" = "Ancienneté intégrée au salaire", "MOD_CAR" = "Évolution de carrière intégrée au salaire","q_primeorg" = "Primes liées à sujétion",
                         "tranc" = "Ancienneté",  "anc" = "Ancienneté", "q_prime14" = "Montants au-delà du 13e mois",
                         "q_prime13" = "13e mois", "taille_entr" = "Taille d'entreprise", "trage2" = "Tranche d'âge", "etp_tp" = "ETP",
                         "q_primeobj"  = "Bonus, primes de performance, primes de qualité / non accident", "q_primepol" = "Prime de polyvalence",
                         "q_remannu" = "Rémunération totale", "q_salmens" = "Salaire de base",
                         "q_primeanc" = "Prime/majoration pour ancienneté", "q_primecar" = "Prime de déroulement de carrière", "q_primevac" = "Prime de vacances",
                         "CAT" = "Catégorie socio-professionnelle", "tps_partiel" = "Temps partiel", "filiere" = "Filière repère", "coef" = "Coefficient",
                         "famille" = "Famille repère", "code_repere" = "Code repère", "lib_repere" = "Emploi repère", "GENRE" = "Genre", "q_primepol" = "Prime de polyvalence",
                         "q_newmin" = "Salaire minimum", "CONTRAT" = "Contrat", "coef_tr" = "Coefficient de base", "q_newsal" = "Rémunération effective", "cout_reval" = "Coût de la revalorisation")

alerte <- function(title, text, type = "error") {
  shinyalert(
    title = title,
    text = text,
    closeOnEsc = TRUE,
    closeOnClickOutside = TRUE,
    html = FALSE,
    type = type,
    showConfirmButton = TRUE,
    showCancelButton = FALSE,
    confirmButtonText = "OK",
    confirmButtonCol = "#AEDEF4",
    timer = 0,
    imageUrl = "",
    animation = TRUE
  )
}

#Import de la base de score vide qui permet d'importer des fichier excel partiel

base_score = read_xlsx("Data/liste_emploi_score.xlsx")

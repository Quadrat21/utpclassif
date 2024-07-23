server <- function(input, output, session) {

  ######
  # Initialisation des fonctions réactives
  ######
  
  out_dataset <- salaires
  
  code_reactive <- reactiveValues(code=unique(salaires$code_repere))
  filiere_reactive <- reactiveValues(filiere=unique(salaires$filiere))
  famille_reactive <- reactiveValues(famille=unique(salaires$famille))
  reseau_reactive <- reactiveValues(reseau=unique(salaires$groupe_empl))
  grp_reactive <- reactiveValues(grp = c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V","W", "X","Y"))
  CAT_reactive = reactiveValues(CAT = unique(salaires$CAT))
  ANC_reactive <- reactiveValues(tranc= unique(salaires$tranc))
  variable_reactive <- reactiveValues(variable="Effectifs")
  variable2_reactive <- reactiveValues(variable2="Libellés emplois")
  variable_carte_reactive <- reactiveValues(variable_carte="Effectifs par département")
  react_data_indiv <- reactiveValues(data=NULL)
  period_title <- reactiveValues(text="mensuel")
  multiple_mini_reactive = reactiveValues(val  = 12)
  
######
# PERMET DE FILTRER LES CHOIX DE FAMILLES DE FACON À FAIRE APPARAITRE SEULEMENT LES FAMILLES DE LA FILIERE SELECTIONNEE
###### 

  #changer les familles disponibles en fonction de filière

  observeEvent(input$choixfiliere, {
    dta_2 = salaires %>%
      select(filiere,famille)%>%
      unique() %>%
      filter(filiere %in% input$choixfiliere)


    choix_fam = sort(dta_2$famille)
      


    updatePickerInput(session = session,inputId = "choixfamille",choices = choix_fam, selected = choix_fam)
    filiere_reactive$filiere <- input$choixfiliere
  })
  
  observeEvent(input$choixfamille, {
    updatePickerInput(session = session, inputId = "choixfamille", selected = input$choixfamille)
    famille_reactive$famille <- input$choixfamille
  })
  
  #   if ("Toutes les filières" %in% input$choixfiliere) {
  # 
  #     #RQ ELIE : choisir une option plus légère
  #     dta_2 <- salaires
  #     updateSelectizeInput(session = session, inputId = "choixfiliere", selected = input$choixfiliere)
  #     updateSelectizeInput(session = session, inputId = "choixfamille", selected = "Toutes les familles", choices=c("Toutes les familles", sort(unique(dta_2$famille))))
  #   } else {
  #   dta_2 <- salaires %>% filter(filiere %in% input$choixfiliere)
  #   updateSelectizeInput(session = session, inputId = "choixfiliere", selected = input$choixfiliere)
  #   updateSelectizeInput(session = session, inputId = "choixfamille", selected = "Toutes les familles", choices=c(sort(unique(dta_2$famille))))
  #   filiere_reactive$filiere <- input$choixfiliere
  # 
  #   }
  # 
  # 
  # observeEvent(input$choixfamille, {
  #   if ("Toutes les familles" %in% input$choixfamille) {
  #     updateSelectizeInput(session = session, inputId = "choixfamille", selected = input$choixfamille)
  #     famille_reactive$famille <- unique(salaires$famille)
  #   } else {
  #   updateSelectizeInput(session = session, inputId = "choixfamille", selected = input$choixfamille)
  #   famille_reactive$famille <- input$choixfamille
  #   }
  # })

  
#########
# POUR CHAQUE ELEMENT DE SELECTION CREE UNE LISTE DE FILTRES A APPLIQUER AUX DONNEES.
# Condition : prend en entrée le choix de l'utilisateur: si "tous les..." est sélectionné alors toutes les valeurs de la variable sont prises en compte il n'y a donc pas de filtres. Sinon, seulement la valeur choisie sera prise en compte 
#Chaque bloc renvoie une liste de valeurs que peuvent prendre les variables groupe_empl, tranc, coef, csp. qui constituera un filtre a appliquer sur les données. 
#########
  
  observeEvent(input$choixreseau, {
    # updatePickerInput(session = session, inputId = "choixreseau", selected = input$choixreseau)
    # if ("Tous les groupes" %in% input$choixreseau) {
    #   reseau_reactive$reseau <- unique(salaires$groupe_empl)
    # } else {
      reseau_reactive$reseau <- input$choixreseau
    # }
  })
  observeEvent(input$choixtranc, {
    # updatePickerInput(session = session, inputId = "choixtranc", selected = input$choixtranc)
    # if ("Toutes les tranches"%in% input$choixtranc ) {
    #   ANC_reactive$tranc <- unique(salaires$tranc)
    # } else {
      ANC_reactive$tranc <- input$choixtranc
    # }
  })

  observeEvent(input$choixcsp, {
    # updatePickerInput(session = session, inputId = "choixcsp", selected = input$choixcsp)
    # if ("Toutes les catégories" %in% input$choixcsp ) {
    #   CAT_reactive$CAT <- unique(salaires$CAT)
    # } else {
      CAT_reactive$CAT <- input$choixcsp
    # }
  })
  observeEvent(input$choixgrp, {
    # updatePickerInput(session = session, inputId = "choixgrp", selected = input$choixgrp)
    # if ("Tous les groupes" %in% input$choixgrp) {
    #   grp_reactive$grp <- c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V","W", "X","Y")
    # } else {
      grp_reactive$grp <- input$choixgrp
    # }
  })
  
  observeEvent(input$choixvariable,{
    updateSelectizeInput(session = session, inputId = "choixvariable", selected = input$choixvariable)
      variable_reactive$variable <- input$choixvariable
 } )
  
  observeEvent(input$multiple_mini,{
    updateSelectizeInput(session = session, inputId = "multiple_mini", selected = input$multiple_mini)
    multiple_mini_reactive$val = input$multiple_mini
  } )
  
  
#####
#POUR CHACUN DES TROIS GROUPES? CONSTRUIT UN POURCENTAGE DE MAJORATION DU MINIMA SELON LA TRANCHE D'ANC
#En entrée, les tranches d'ages et les pourcentages associés à chaque trache de CHAQUE groupe.
#En sortie, crée les courbes pour chaque groupes: maitrises et employés, ouvriers et cadres
#####
  
  make_vector_ouvriers = eventReactive(list(
    input$Ouvriers_Anc_1_tranches, input$Ouvriers_Anc_2_tranches, input$Ouvriers_Anc_3_tranches,
    input$Ouvriers_Anc_4_tranches, input$Ouvriers_Anc_5_tranches, input$Ouvriers_Anc_6_tranches,
    input$Ouvriers_Anc_7_tranches, input$Ouvriers_Anc_8_tranches, input$Ouvriers_Anc_9_tranches,
    input$Ouvriers_Anc_10_tranches, input$maj_ouvriers_tranche_1, input$maj_ouvriers_tranche_2,
    input$maj_ouvriers_tranche_3, input$maj_ouvriers_tranche_4, input$maj_ouvriers_tranche_5,
    input$maj_ouvriers_tranche_6, input$maj_ouvriers_tranche_7, input$maj_ouvriers_tranche_8,
    input$maj_ouvriers_tranche_9, input$maj_ouvriers_tranche_10), {
      
      
      
      max_length <- max(input$Ouvriers_Anc_10_tranches[2], input$Cadres_Anc_10_tranches[2], input$Techniciens_Anc_10_tranches[2])
      
      
      x_data_maj_ouvriers <- rep(input$maj_ouvriers_tranche_10, max_length)
      
      
      tranche_bounds <- c(
        0,
        input$Ouvriers_Anc_1_tranches[1], input$Ouvriers_Anc_2_tranches[1], input$Ouvriers_Anc_3_tranches[1],
        input$Ouvriers_Anc_4_tranches[1], input$Ouvriers_Anc_5_tranches[1], input$Ouvriers_Anc_6_tranches[1],
        input$Ouvriers_Anc_7_tranches[1], input$Ouvriers_Anc_8_tranches[1], input$Ouvriers_Anc_9_tranches[1],
        input$Ouvriers_Anc_10_tranches[1]
      )
      tranche_values <- c(
        0, input$maj_ouvriers_tranche_1, input$maj_ouvriers_tranche_2, input$maj_ouvriers_tranche_3,
        input$maj_ouvriers_tranche_4, input$maj_ouvriers_tranche_5, input$maj_ouvriers_tranche_6,
        input$maj_ouvriers_tranche_7, input$maj_ouvriers_tranche_8, input$maj_ouvriers_tranche_9,
        input$maj_ouvriers_tranche_10
      )
      
      
      for (i in head(1:length(tranche_bounds),-1)) {
        start_idx <- round(tranche_bounds[i]) + 1
        end_idx <- round(tranche_bounds[i + 1])
        
        if (start_idx <= end_idx) {
          x_data_maj_ouvriers[start_idx:end_idx] <- tranche_values[i + 1]
        }
      }
      x_data_maj_ouvriers
    })
  
  make_vector_cadres = eventReactive(list(
    input$Cadres_Anc_1_tranches, input$Cadres_Anc_2_tranches, input$Cadres_Anc_3_tranches,
    input$Cadres_Anc_4_tranches, input$Cadres_Anc_5_tranches, input$Cadres_Anc_6_tranches,
    input$Cadres_Anc_7_tranches, input$Cadres_Anc_8_tranches, input$Cadres_Anc_9_tranches,
    input$Cadres_Anc_10_tranches, input$maj_Cadres_tranche_1, input$maj_Cadres_tranche_2,
    input$maj_Cadres_tranche_3, input$maj_Cadres_tranche_4, input$maj_Cadres_tranche_5,
    input$maj_Cadres_tranche_6, input$maj_Cadres_tranche_7, input$maj_Cadres_tranche_8,
    input$maj_Cadres_tranche_9, input$maj_Cadres_tranche_10), {
      
      max_length <- max(input$Ouvriers_Anc_10_tranches[2], input$Cadres_Anc_10_tranches[2], input$Techniciens_Anc_10_tranches[2])
      x_data_maj_cadres <- rep(input$maj_Cadres_tranche_10, max_length)
      
      tranche_bounds <- c(
        0,
        input$Cadres_Anc_1_tranches[1], input$Cadres_Anc_2_tranches[1], input$Cadres_Anc_3_tranches[1],
        input$Cadres_Anc_4_tranches[1], input$Cadres_Anc_5_tranches[1], input$Cadres_Anc_6_tranches[1],
        input$Cadres_Anc_7_tranches[1], input$Cadres_Anc_8_tranches[1], input$Cadres_Anc_9_tranches[1],
        input$Cadres_Anc_10_tranches[1]
      )
      tranche_values <- c(
        0, input$maj_Cadres_tranche_1, input$maj_Cadres_tranche_2, input$maj_Cadres_tranche_3,
        input$maj_Cadres_tranche_4, input$maj_Cadres_tranche_5, input$maj_Cadres_tranche_6,
        input$maj_Cadres_tranche_7, input$maj_Cadres_tranche_8, input$maj_Cadres_tranche_9,
        input$maj_Cadres_tranche_10
      )
      
      for (i in head(1:length(tranche_bounds),-1)) {
        start_idx <- round(tranche_bounds[i]) + 1
        end_idx <- round(tranche_bounds[i + 1])
        if (start_idx <= end_idx) {
          x_data_maj_cadres[start_idx:end_idx] <- tranche_values[i + 1]
        }
      }
      
      x_data_maj_cadres
    })
  
  make_vector_techniciens = eventReactive(list(
    input$Techniciens_Anc_1_tranches, input$Techniciens_Anc_2_tranches, input$Techniciens_Anc_3_tranches,
    input$Techniciens_Anc_4_tranches, input$Techniciens_Anc_5_tranches, input$Techniciens_Anc_6_tranches,
    input$Techniciens_Anc_7_tranches, input$Techniciens_Anc_8_tranches, input$Techniciens_Anc_9_tranches,
    input$Techniciens_Anc_10_tranches, input$maj_Techniciens_tranche_1, input$maj_Techniciens_tranche_2,
    input$maj_Techniciens_tranche_3, input$maj_Techniciens_tranche_4, input$maj_Techniciens_tranche_5,
    input$maj_Techniciens_tranche_6, input$maj_Techniciens_tranche_7, input$maj_Techniciens_tranche_8,
    input$maj_Techniciens_tranche_9, input$maj_Techniciens_tranche_10), {
      
      max_length <- max(input$Ouvriers_Anc_10_tranches[2], input$Cadres_Anc_10_tranches[2], input$Techniciens_Anc_10_tranches[2])
      x_data_maj_techniciens <- rep(input$maj_Techniciens_tranche_10, max_length)
      
      tranche_bounds <- c(
        0,
        input$Techniciens_Anc_1_tranches[1], input$Techniciens_Anc_2_tranches[1], input$Techniciens_Anc_3_tranches[1],
        input$Techniciens_Anc_4_tranches[1], input$Techniciens_Anc_5_tranches[1], input$Techniciens_Anc_6_tranches[1],
        input$Techniciens_Anc_7_tranches[1], input$Techniciens_Anc_8_tranches[1], input$Techniciens_Anc_9_tranches[1],
        input$Techniciens_Anc_10_tranches[1]
      )
      tranche_values <- c(
        0, input$maj_Techniciens_tranche_1, input$maj_Techniciens_tranche_2, input$maj_Techniciens_tranche_3,
        input$maj_Techniciens_tranche_4, input$maj_Techniciens_tranche_5, input$maj_Techniciens_tranche_6,
        input$maj_Techniciens_tranche_7, input$maj_Techniciens_tranche_8, input$maj_Techniciens_tranche_9,
        input$maj_Techniciens_tranche_10
      )
      
      for (i in head(1:length(tranche_bounds),-1)) {
        start_idx <- round(tranche_bounds[i]) + 1
        end_idx <- round(tranche_bounds[i + 1])
        if (start_idx <= end_idx) {
          x_data_maj_techniciens[start_idx:end_idx] <- tranche_values[i + 1]
        }
      }
      
      x_data_maj_techniciens
    })
  
  
  
  
  output$plot_majoration_anciennete <- renderHighchart({
    
    x_data <- seq(from = 0, to = max(input$Ouvriers_Anc_10_tranches[2], input$Techniciens_Anc_10_tranches[2],
                                     input$Cadres_Anc_10_tranches[2]))
    x_data_labels = x_data
    
    ouvriers_vectors <- make_vector_ouvriers()
    
    if (length(ouvriers_vectors) > 46){
      ouvriers_vectors = ouvriers_vectors[1:46]
    }
    
    cadres_vectors <- make_vector_cadres()
    
    if (length(cadres_vectors) > 46){
      cadres_vectors = cadres_vectors[1:46]
    }
    
    techniciens_vectors <- make_vector_techniciens()
    
    if (length(techniciens_vectors) > 46){
      techniciens_vectors = techniciens_vectors[1:46]
    }
    
    y_data_labels <- paste(1:30, "%", sep = " ")
    
    highchart() %>%
      hc_chart(type = "line", backgroundColor = "#fff") %>%
      hc_title(
        text = str_glue("Majoration par tranche d'ancienneté "),
        align = "left",
        style = list(
          fontSize = "16px",
          #fontWeight = "bold",
          color = "#8192AE"
        )
      ) %>%
      hc_xAxis(
        title = list(text = "Ancienneté, en années"),
        type = "line",
        categories = as.list(x_data_labels),
        labels = list(step = 1,style = list(color = "#8192AE"))
      ) %>%
      hc_yAxis(
        title = list(text = "Majoration , en %")
      ) %>%
      hc_series(list(
        name = "Ouvriers",
        type="spline",
        data = as.list(ouvriers_vectors),
        color = "#8346AD"
      )) %>%
      hc_add_series(
        name = "Cadres",
        type="spline",
        data = as.list(cadres_vectors),
        color = "#0000FF"
      ) %>%
      hc_add_series(
        name = "Maîtrises et techniciens",
        type="spline",
        data = as.list(techniciens_vectors),
        color = "#008000"
      ) %>%
      hc_legend(enabled = TRUE) %>%
      hc_exporting(enabled=TRUE, color = "#fff") %>%
      hc_plotOptions(series = list(marker =list(enabled=FALSE)))
  })  

  
 
##### 
#DEFINITION DE LA REACTIVE QUI ASSOCIE A CHAQUE SCORE UN EMPLOI REPERE.
#En entrée, prend les inputs "scores_" choisis par l'utilisateur.
#En sortie, un dataframe qui associe pour a chaque score un libellé repère.
#####
  
 #premièrement stocker les scores:
 
 reactive_SCORE <- eventReactive(list(input$launch_simulation_button,input$choixfamille, input$choixfiliere, input$choixreseau, input$choixcoef, input$choixcsp, input$choixtranc),{
   # Definir les scores
   scores = c(
     input$score_acheteur_commande_publique,
     input$score_administrateur_systemes_reseaux,
     input$score_agent_charge_methodes_exploitation,
     input$score_agent_manoeuvre,
     input$score_agent_planning,
     input$score_agent_surete,
     input$score_agent_back_office,
     input$score_aiguilleur,
     input$score_animateur_qualite,
     input$score_animateur_securite_prevention,
     input$score_assistant_commercial_marketing,
     input$score_assistant_controle_gestion,
     input$score_assistant_direction,
     input$score_assistant_rh,
     input$score_charge_communication,
     input$score_charge_marketing,
     input$score_charge_recrutement,
     input$score_charge_web_editorial,
     input$score_charge_etudes,
     input$score_charge_developpeur,
     input$score_chef_projet_appel_offres,
     input$score_chef_projet_SI,
     input$score_collecteur_recettes,
     input$score_community_manager,
     input$score_comptable,
     input$score_conducteur_bus,
     input$score_conducteur_metro,
     input$score_conducteur_polyvalent_multimodal,
     input$score_conducteur_polyvalent_verificateur_agent_commercial,
     input$score_conducteur_pmr_tad,
     input$score_conducteur_tram,
     input$score_conseiller_commercial,
     input$score_controleur_gestion,
     input$score_formateur,
     input$score_gestionnaire_approvisionnement_stock,
     input$score_gestionnaire_assurance,
     input$score_gestionnaire_paie,
     input$score_gestionnaire_parc_velo,
     input$score_gestionnaire_contrats,
     input$score_infographiste,
     input$score_ingenieur_cybersecurite,
     input$score_ingenieur_maintenance,
     input$score_ingenieur_methodes_maintenance,
     input$score_ingenieur_financier,
     input$score_juriste,
     input$score_manager_conducteurs,
     input$score_manager_conseiller_commercial,
     input$score_manager_techniciens_maintenance,
     input$score_manager_techniciens_maintenance_parc,
     input$score_manager_verificateurs,
     input$score_manager_equipe_agents_surete,
     input$score_mediateur,
     input$score_operateur_pc_surete,
     input$score_operateur_technique_informations_voyageurs,
     input$score_regulateur,
     input$score_responsable_administrateur_financier,
     input$score_responsable_approvisionnement_stock,
     input$score_responsable_commercial,
     input$score_responsable_communication,
     input$score_responsable_comptabilite,
     input$score_responsable_formation,
     input$score_responsable_maintenance,
     input$score_responsable_production_operation,
     input$score_responsable_societe,
     input$score_responsable_equipe_achat_commande_publique,
     input$score_responsable_SI,
     input$score_responsable_exploitation,
     input$score_responsable_bureau_etudes_methodes_exploitation,
     input$score_responsable_service_client,
     input$score_responsable_fraude,
     input$score_responsable_HSE,
     input$score_responsable_juridique,
     input$score_responsable_marketing,
     input$score_responsable_performance_operationnelle,
     input$score_responsable_qualite,
     input$score_relations_institutionnelles,
     input$score_responsable_rh,
     input$score_responsable_RSE,
     input$score_responsable_secteur,
     input$score_responsable_securite_prevention,
     input$score_responsable_appels_offre,
     input$score_technicien_maintenance_parc,
     input$score_technicien_exploitation,
     input$score_technicien_maintenance,
     input$score_technicien_methodes_maintenance,
     input$score_technicien_intervention_systemes_automatiques_autonomes,
     input$score_technicien_superieur_exploitation,
     input$score_verificateur
     
   )
   

   score_repere = cbind(as.data.frame(scores),tp_emploi_repere_code_repere)
   return(score_repere)
   
 })

#Fonction qui va remplacer le score d'un emploi par une valeur manquante à chaque fois qu'il n'apparait plus dans la liste des emplois à considérer   
observe({
  test0 = input$Exclure_emplois
  test0<<-test0
  updateNumericInput(session = session, "score_acheteur_commande_publique", value = ifelse('Acheteur (se) / commande publique' %in% input$Exclure_emplois, input$score_acheteur_commande_publique, NA))
  updateNumericInput(session = session, "score_administrateur_systemes_reseaux", value = ifelse("Administrateur(trice) systèmes réseaux" %in% input$Exclure_emplois, input$score_administrateur_systemes_reseaux,NA))
  updateNumericInput(session = session, "score_agent_charge_methodes_exploitation", value = ifelse("Agent / Chargé(e) des méthodes d'exploitation" %in% input$Exclure_emplois, input$score_agent_charge_methodes_exploitation,NA))
  updateNumericInput(session = session, "score_agent_manoeuvre", value = ifelse("Agent de manoeuvre" %in% input$Exclure_emplois, input$score_agent_manoeuvre,NA))
  updateNumericInput(session = session, "score_agent_planning", value = ifelse("Agent de planning" %in% input$Exclure_emplois, input$score_agent_planning,NA))
  updateNumericInput(session = session, "score_agent_surete", value = ifelse("Agent de sûreté" %in% input$Exclure_emplois, input$score_agent_surete,NA))
  updateNumericInput(session = session, "score_agent_back_office", value = ifelse("Agents de back-office" %in% input$Exclure_emplois, input$score_agent_back_office,NA))
  updateNumericInput(session = session, "score_aiguilleur", value = ifelse("Aiguilleur(e)" %in% input$Exclure_emplois, input$score_aiguilleur,NA))
  updateNumericInput(session = session, "score_animateur_qualite", value = ifelse("Animateur(trice) de la qualité" %in% input$Exclure_emplois, input$score_animateur_qualite,NA))
  updateNumericInput(session = session, "score_animateur_securite_prevention", value = ifelse("Animateur(trice) HSE / sécurité prévention" %in% input$Exclure_emplois, input$score_animateur_securite_prevention,NA))
  updateNumericInput(session = session, "score_assistant_commercial_marketing", value = ifelse("Assistant(e) commercial(e) et marketing" %in% input$Exclure_emplois, input$score_assistant_commercial_marketing,NA))
  updateNumericInput(session = session, "score_assistant_controle_gestion", value = ifelse("Assistant(e) contrôle de gestion" %in% input$Exclure_emplois, input$score_assistant_controle_gestion,NA))
  updateNumericInput(session = session, "score_assistant_direction", value = ifelse("Assistant(e) de direction" %in% input$Exclure_emplois, input$score_assistant_direction,NA))
  updateNumericInput(session = session, "score_assistant_rh", value = ifelse("Assistant(e) RH" %in% input$Exclure_emplois, input$score_assistant_rh,NA))
  updateNumericInput(session = session, "score_charge_etudes", value = ifelse("Chargé(e) d études" %in% input$Exclure_emplois, input$score_charge_etudes,NA))
  updateNumericInput(session = session, "score_charge_communication", value = ifelse("Chargé(e) de communication" %in% input$Exclure_emplois, input$score_charge_communication,NA))
  updateNumericInput(session = session, "score_charge_marketing", value = ifelse("Chargé(e) de marketing" %in% input$Exclure_emplois, input$score_charge_marketing,NA))
  updateNumericInput(session = session, "score_charge_recrutement", value = ifelse("Chargé(e) de recrutement" %in% input$Exclure_emplois, input$score_charge_recrutement,NA))
  updateNumericInput(session = session, "score_charge_web_editorial", value = ifelse("Chargé(e) de web éditorial" %in% input$Exclure_emplois, input$score_charge_web_editorial,NA))
  updateNumericInput(session = session, "score_charge_developpeur", value = ifelse("Chargé(e) développeur(se)" %in% input$Exclure_emplois, input$score_charge_developpeur,NA))
  updateNumericInput(session = session, "score_chef_projet_appel_offres", value = ifelse("Chef(fe) de projet appels d offres" %in% input$Exclure_emplois, input$score_chef_projet_appel_offres,NA))
  updateNumericInput(session = session, "score_chef_projet_SI", value = ifelse("Chef(fe) de projet SI" %in% input$Exclure_emplois, input$score_chef_projet_SI,NA))
  updateNumericInput(session = session, "score_collecteur_recettes", value = ifelse("Collecteur(trice) de recettes" %in% input$Exclure_emplois, input$score_collecteur_recettes,NA))
  updateNumericInput(session = session, "score_community_manager", value = ifelse("Community manager" %in% input$Exclure_emplois, input$score_community_manager,NA))
  updateNumericInput(session = session, "score_comptable", value = ifelse("Comptable" %in% input$Exclure_emplois, input$score_comptable,NA))
  updateNumericInput(session = session, "score_conducteur_bus", value = ifelse("Conducteurs (trices ) bus" %in% input$Exclure_emplois, input$score_conducteur_bus,NA))
  updateNumericInput(session = session, "score_conducteur_metro", value = ifelse("Conducteurs (trices ) métro" %in% input$Exclure_emplois, input$score_conducteur_metro,NA))
  updateNumericInput(session = session, "score_conducteur_polyvalent_multimodal", value = ifelse("Conducteurs (trices ) polyvalent multimodal" %in% input$Exclure_emplois, input$score_conducteur_polyvalent_multimodal,NA))
  updateNumericInput(session = session, "score_conducteur_polyvalent_verificateur_agent_commercial", value = ifelse("Conducteurs (trices ) polyvalent vérificateur / agent commercial" %in% input$Exclure_emplois, input$score_conducteur_polyvalent_verificateur_agent_commercial,NA))
  updateNumericInput(session = session, "score_conducteur_pmr_tad", value = ifelse("Conducteurs (trices ) pour PMR / TAD" %in% input$Exclure_emplois, input$score_conducteur_pmr_tad,NA))
  updateNumericInput(session = session, "score_conducteur_tram", value = ifelse("Conducteurs (trices ) tram" %in% input$Exclure_emplois, input$score_conducteur_tram,NA))
  updateNumericInput(session = session, "score_conseiller_commercial", value = ifelse("Conseiller(ère) commercial(e)" %in% input$Exclure_emplois, input$score_conseiller_commercial,NA))
  updateNumericInput(session = session, "score_controleur_gestion", value = ifelse("Contrôleur(euse) de gestion" %in% input$Exclure_emplois, input$score_controleur_gestion,NA))
  updateNumericInput(session = session, "score_formateur", value = ifelse("Formateur(trice)" %in% input$Exclure_emplois, input$score_formateur,NA))
  updateNumericInput(session = session, "score_gestionnaire_assurance", value = ifelse("Gestionnaire d assurance" %in% input$Exclure_emplois, input$score_gestionnaire_assurance,NA))
  updateNumericInput(session = session, "score_gestionnaire_approvisionnement_stock", value = ifelse("Gestionnaire d’approvisionnement et/ou de stock" %in% input$Exclure_emplois, input$score_gestionnaire_approvisionnement_stock,NA))
  updateNumericInput(session = session, "score_gestionnaire_paie", value = ifelse("Gestionnaire de paie" %in% input$Exclure_emplois, input$score_gestionnaire_paie,NA))
  updateNumericInput(session = session, "score_gestionnaire_parc_velo", value = ifelse("Gestionnaire de parc vélo" %in% input$Exclure_emplois, input$score_gestionnaire_parc_velo,NA))
  updateNumericInput(session = session, "score_gestionnaire_contrats", value = ifelse("Gestionnaire des contrats" %in% input$Exclure_emplois, input$score_gestionnaire_contrats,NA))
  updateNumericInput(session = session, "score_infographiste", value = ifelse("Infographiste" %in% input$Exclure_emplois, input$score_infographiste,NA))
  updateNumericInput(session = session, "score_ingenieur_cybersecurite", value = ifelse("Ingénieur(e) cybersécurité" %in% input$Exclure_emplois, input$score_ingenieur_cybersecurite,NA))
  updateNumericInput(session = session, "score_ingenieur_maintenance", value = ifelse("Ingénieur(e) de maintenance" %in% input$Exclure_emplois, input$score_ingenieur_maintenance,NA))
  updateNumericInput(session = session, "score_ingenieur_methodes_maintenance", value = ifelse("Ingénieur(e) des méthodes de maintenance" %in% input$Exclure_emplois, input$score_ingenieur_methodes_maintenance,NA))
  updateNumericInput(session = session, "score_ingenieur_financier", value = ifelse("Ingénieur(e) financier(ère)" %in% input$Exclure_emplois, input$score_ingenieur_financier,NA))
  updateNumericInput(session = session, "score_juriste", value = ifelse("Juriste" %in% input$Exclure_emplois, input$score_juriste,NA))
  updateNumericInput(session = session, "score_manager_conducteurs", value = ifelse("Manager de conducteurs (trices)" %in% input$Exclure_emplois, input$score_manager_conducteurs,NA))
  updateNumericInput(session = session, "score_manager_conseiller_commercial", value = ifelse("Manager de conseillers(ères) commerciaux(ales)" %in% input$Exclure_emplois, input$score_manager_conseiller_commercial,NA))
  updateNumericInput(session = session, "score_manager_techniciens_maintenance", value = ifelse("Manager de techniciens de maintenance" %in% input$Exclure_emplois, input$score_manager_techniciens_maintenance,NA))
  updateNumericInput(session = session, "score_manager_techniciens_maintenance_parc", value = ifelse("Manager de techniciens de maintenance parc" %in% input$Exclure_emplois, input$score_manager_techniciens_maintenance_parc,NA))
  updateNumericInput(session = session, "score_manager_verificateurs", value = ifelse("Manager de vérificateurs (trices)" %in% input$Exclure_emplois, input$score_manager_verificateurs,NA))
  updateNumericInput(session = session, "score_manager_equipe_agents_surete", value = ifelse("Manager équipe agent de sûreté" %in% input$Exclure_emplois, input$score_manager_equipe_agents_surete,NA))
  updateNumericInput(session = session, "score_mediateur", value = ifelse("Médiateur(trice)" %in% input$Exclure_emplois, input$score_mediateur,NA))
  updateNumericInput(session = session, "score_operateur_pc_surete", value = ifelse("Opérateur (trice) PC sûreté" %in% input$Exclure_emplois, input$score_operateur_pc_surete,NA))
  updateNumericInput(session = session, "score_operateur_technique_informations_voyageurs", value = ifelse("Opérateur(trice) technique informations voyageurs" %in% input$Exclure_emplois, input$score_operateur_technique_informations_voyageurs,NA))
  updateNumericInput(session = session, "score_regulateur", value = ifelse("Régulateur(trice)" %in% input$Exclure_emplois, input$score_regulateur,NA))
  updateNumericInput(session = session, "score_responsable_administrateur_financier", value = ifelse("Responsable administratif(ve) et financier(ère)" %in% input$Exclure_emplois, input$score_responsable_administrateur_financier,NA))
  updateNumericInput(session = session, "score_responsable_approvisionnement_stock", value = ifelse("Responsable approvisionnement et/ou de stock" %in% input$Exclure_emplois, input$score_responsable_approvisionnement_stock,NA))
  updateNumericInput(session = session, "score_responsable_commercial", value = ifelse("Responsable commercial(e)" %in% input$Exclure_emplois, input$score_responsable_commercial,NA))
  updateNumericInput(session = session, "score_responsable_communication", value = ifelse("Responsable communication" %in% input$Exclure_emplois, input$score_responsable_communication,NA))
  updateNumericInput(session = session, "score_responsable_comptabilite", value = ifelse("Responsable Comptabilités" %in% input$Exclure_emplois, input$score_responsable_comptabilite,NA))
  updateNumericInput(session = session, "score_responsable_equipe_achat_commande_publique", value = ifelse("Responsable d équipe d  achat /commande publique" %in% input$Exclure_emplois, input$score_responsable_equipe_achat_commande_publique,NA))
  updateNumericInput(session = session, "score_responsable_exploitation", value = ifelse("Responsable d exploitation" %in% input$Exclure_emplois, input$score_responsable_exploitation,NA))
  updateNumericInput(session = session, "score_responsable_formation", value = ifelse("Responsable de formation" %in% input$Exclure_emplois, input$score_responsable_formation,NA))
  updateNumericInput(session = session, "score_responsable_maintenance", value = ifelse("Responsable de la maintenance" %in% input$Exclure_emplois, input$score_responsable_maintenance,NA))
  updateNumericInput(session = session, "score_responsable_production_operation", value = ifelse("Responsable de production / opération" %in% input$Exclure_emplois, input$score_responsable_production_operation,NA))
  updateNumericInput(session = session, "score_responsable_societe", value = ifelse("Responsable de société" %in% input$Exclure_emplois, input$score_responsable_societe,NA))
  updateNumericInput(session = session, "score_responsable_SI", value = ifelse("Responsable des SI" %in% input$Exclure_emplois, input$score_responsable_SI,NA))
  updateNumericInput(session = session, "score_responsable_bureau_etudes_methodes_exploitation", value = ifelse("Responsable du bureu d études et/ou méthoides d exploitation" %in% input$Exclure_emplois, input$score_responsable_bureau_etudes_methodes_exploitation,NA))
  updateNumericInput(session = session, "score_responsable_service_client", value = ifelse("Responsable du service client" %in% input$Exclure_emplois, input$score_responsable_service_client,NA))
  updateNumericInput(session = session, "score_responsable_fraude", value = ifelse("Responsable fraude" %in% input$Exclure_emplois, input$score_responsable_fraude,NA))
  updateNumericInput(session = session, "score_responsable_RSE", value = ifelse("Responsable RSE" %in% input$Exclure_emplois, input$score_responsable_RSE,NA))
  updateNumericInput(session = session, "score_responsable_juridique", value = ifelse("Responsable juridique" %in% input$Exclure_emplois, input$score_responsable_juridique,NA))
  updateNumericInput(session = session, "score_responsable_marketing", value = ifelse("Responsable marketing" %in% input$Exclure_emplois, input$score_responsable_marketing,NA))
  updateNumericInput(session = session, "score_responsable_performance_operationnelle", value = ifelse("Responsable performance opérationnelle" %in% input$Exclure_emplois, input$score_responsable_performance_operationnelle,NA))
  updateNumericInput(session = session, "score_responsable_qualite", value = ifelse("Responsable qualité" %in% input$Exclure_emplois, input$score_responsable_qualite,NA))
  updateNumericInput(session = session, "score_relations_institutionnelles", value = ifelse("Responsable relations institutionnelles" %in% input$Exclure_emplois, input$score_relations_institutionnelles,NA))
  updateNumericInput(session = session, "score_responsable_rh", value = ifelse("Responsable RH" %in% input$Exclure_emplois, input$score_responsable_rh,NA))
  updateNumericInput(session = session, "score_responsable_HSE", value = ifelse("Responsable HSE" %in% input$Exclure_emplois, input$score_responsable_HSE,NA))
  updateNumericInput(session = session, "score_responsable_secteur", value = ifelse("Responsable secteur" %in% input$Exclure_emplois, input$score_responsable_secteur,NA))
  updateNumericInput(session = session, "score_responsable_securite_prevention", value = ifelse("Responsable sécurité prévention" %in% input$Exclure_emplois, input$score_responsable_securite_prevention,NA))
  updateNumericInput(session = session, "score_responsable_appels_offre", value = ifelse("Responsable appels d offres" %in% input$Exclure_emplois, input$score_responsable_appels_offre,NA))
  updateNumericInput(session = session, "score_technicien_maintenance_parc", value = ifelse("Technicien (ne) de maintenance parc" %in% input$Exclure_emplois, input$score_technicien_maintenance_parc,NA))
  updateNumericInput(session = session, "score_technicien_exploitation", value = ifelse("Technicien(ne) d exploitation" %in% input$Exclure_emplois, input$score_technicien_exploitation,NA))
  updateNumericInput(session = session, "score_technicien_maintenance", value = ifelse("Technicien(ne) de maintenance" %in% input$Exclure_emplois, input$score_technicien_maintenance,NA))
  updateNumericInput(session = session, "score_technicien_methodes_maintenance", value = ifelse("Technicien(ne) des méthodes de maintenance" %in% input$Exclure_emplois, input$score_technicien_methodes_maintenance,NA))
  updateNumericInput(session = session, "score_technicien_intervention_systemes_automatiques_autonomes", value = ifelse("Technicien(ne) intervention systèmes automatiques/autonomes" %in% input$Exclure_emplois, input$score_technicien_intervention_systemes_automatiques_autonomes,NA))
  updateNumericInput(session = session, "score_technicien_superieur_exploitation", value = ifelse("Technicien(ne) supérieur(e) d exploitation" %in% input$Exclure_emplois, input$score_technicien_superieur_exploitation,NA))
  updateNumericInput(session = session, "score_verificateur", value = ifelse("Vérificateur (trice)" %in% input$Exclure_emplois, input$score_verificateur,NA))
})
 
 ### Définition d'une réactive qui permet d'associer à chaque score un groupe puis à chaque groupe un minima #### 

 
 
 observeEvent(input$custom_number_classifications, {
   num <- as.character(input$custom_number_classifications)
   if (num %in% names(default_values)) {
     updateNumericInput(session, "score_plafond_A", value = default_values[[num]]$A)
     updateNumericInput(session, "score_plafond_B", value = default_values[[num]]$B)
     updateNumericInput(session, "score_plafond_C", value = default_values[[num]]$C)
     updateNumericInput(session, "score_plafond_D", value = default_values[[num]]$D)
     updateNumericInput(session, "score_plafond_E", value = default_values[[num]]$E)
     updateNumericInput(session, "score_plafond_F", value = default_values[[num]]$F)
     updateNumericInput(session, "score_plafond_G", value = default_values[[num]]$G)
     updateNumericInput(session, "score_plafond_H", value = default_values[[num]]$H)
     updateNumericInput(session, "score_plafond_I", value = default_values[[num]]$I)
     updateNumericInput(session, "score_plafond_J", value = default_values[[num]]$J)
     updateNumericInput(session, "score_plafond_K", value = default_values[[num]]$K)
     updateNumericInput(session, "score_plafond_L", value = default_values[[num]]$L)
     updateNumericInput(session, "score_plafond_M", value = default_values[[num]]$M)
     updateNumericInput(session, "score_plafond_N", value = default_values[[num]]$N)
     updateNumericInput(session, "score_plafond_O", value = default_values[[num]]$O)
     updateNumericInput(session, "score_plafond_P", value = default_values[[num]]$P)
     updateNumericInput(session, "score_plafond_Q", value = default_values[[num]]$Q)
     updateNumericInput(session, "score_plafond_R", value = default_values[[num]]$R)
     updateNumericInput(session, "score_plafond_S", value = default_values[[num]]$S)
     updateNumericInput(session, "score_plafond_T", value = default_values[[num]]$T)
     updateNumericInput(session, "score_plafond_U", value = default_values[[num]]$U)
     updateNumericInput(session, "score_plafond_V", value = default_values[[num]]$V)
     updateNumericInput(session, "score_plafond_W", value = default_values[[num]]$W)
     updateNumericInput(session, "score_plafond_X", value = default_values[[num]]$X)
     updateNumericInput(session, "score_plafond_Y", value = default_values[[num]]$Y)
     
   }
 })
 #Nous utilisons choosedatsets2() ce qui permet d'avoir un dataset pour le calcul des coûts qui varie selon les choix de filière, famille etc.. du début.
 #Afin que l'utilisateur ait à tout moment, le portrait (cadre en haut) et l'estimation (cadre au milieu) de la meme selection.
 reactive_GROUPE <- observeEvent(list(input$launch_simulation_button,input$choixfamille, input$choixfiliere, input$choixreseau, input$choixcoef, input$choixcsp, input$choixtranc), {          
   
   #Ici on part plutôt de la base initiale salaires et non de choosedataset car on s'occupera des filtres après
   
   scored_df = salaires %>%
   left_join(reactive_SCORE(),  by = "code_repere")
   
   
   
   nb_classes <- input$custom_number_classifications
   
   # Créer des listes pour stocker les plafonds et les groupes
   
   
   
   plafonds <- list(input[[paste0("score_plafond_",nb_classes,"_A")]], input[[paste0("score_plafond_",nb_classes,"_B")]], 
                  input[[paste0("score_plafond_",nb_classes,"_C")]], input[[paste0("score_plafond_",nb_classes,"_D")]], 
                  input[[paste0("score_plafond_",nb_classes,"_E")]], input[[paste0("score_plafond_",nb_classes,"_F")]], 
                  input[[paste0("score_plafond_",nb_classes,"_G")]], input[[paste0("score_plafond_",nb_classes,"_H")]],
                  input[[paste0("score_plafond_",nb_classes,"_I")]], input[[paste0("score_plafond_",nb_classes,"_J")]], 
                  input[[paste0("score_plafond_",nb_classes,"_K")]], input[[paste0("score_plafond_",nb_classes,"_L")]], 
                  input[[paste0("score_plafond_",nb_classes,"_M")]], input[[paste0("score_plafond_",nb_classes,"_N")]], 
                  input[[paste0("score_plafond_",nb_classes,"_O")]], input[[paste0("score_plafond_",nb_classes,"_P")]], 
                  input[[paste0("score_plafond_",nb_classes,"_Q")]], input[[paste0("score_plafond_",nb_classes,"_R")]], 
                  input[[paste0("score_plafond_",nb_classes,"_S")]], input[[paste0("score_plafond_",nb_classes,"_T")]], 
                  input[[paste0("score_plafond_",nb_classes,"_U")]], input[[paste0("score_plafond_",nb_classes,"_V")]],
                  input[[paste0("score_plafond_",nb_classes,"_W")]], input[[paste0("score_plafond_",nb_classes,"_X")]],
                  input[[paste0("score_plafond_",nb_classes,"_Y")]])
   

   
   groupes <- LETTERS[1:nb_classes]
   
   # Générer dynamiquement les conditions pour case_when (utilisé pour catégoriser les individus en groupes selon entre quel plafond est situé le score associé à leur code-repère), le but étant de faire une condition du genre => si 8 catégories le plafond de A se situe à moins de 6 par exemple, le plafond de B est def de plafond de A à plafond de B etc... juqu'au groupe H
   conditions <- paste0("scores < ", plafonds[[1]], " ~ '", groupes[1], "', ")
   for (i in 2:nb_classes) {
     if (i == nb_classes) {
       conditions <- paste0(conditions, "scores > ", plafonds[[i-1]], " & scores <= ", plafonds[[i]], " ~ '", groupes[i], "'")
     } else {
       conditions <- paste0(conditions, "scores > ", plafonds[[i-1]], " & scores <= ", plafonds[[i]], " ~ '", groupes[i], "', ")
     }
   }
   
   ## RQ ELIE --> Attention aux fonctions générées par ChatGPT car rarement exactes, dures à debug et créent de mauvaises habitudes
   ## Ici il faut sans doute écrire ">" plutôt que ">=" dans le premier et le troisième arguments si je comprends bien et
   ## "<=" plutôt que "<" dans le tout dernier
   
   
   scored_df2 <- scored_df %>%
     mutate(grp = eval(parse(text = paste0("case_when(", conditions, ")"))))
   
   # Fixer les minimas selon les réponses
   minima <- c(input$classif_1, input$classif_2, input$classif_3, input$classif_4, input$classif_5, 
               input$classif_6, input$classif_7, input$classif_8, input$classif_9, input$classif_10, 
               input$classif_11, input$classif_12, input$classif_13, input$classif_14, input$classif_15, 
               input$classif_16, input$classif_17, input$classif_18, input$classif_19, input$classif_20, 
               input$classif_21, input$classif_22, input$classif_23, input$classif_24, input$classif_25)[1:nb_classes]
   

   # Créer le dataframe dictionnaire pour associer les groupes et leurs minima
   mic_df <- data.frame(grp = groupes, minima = minima)
   
   
   ## RQ ELIE : Ici il faut faire deux choses :
   ## Ajouter la majoration des minima selon l'ancienneté  en créant une variable mini de travail
   
# On définit 3 dataframe une colonne tranche ancienneté et une autre reval 1 df pour chaque catégorie socio-pro.
  
   
   #On crée une variable qui associe a chacun, le pourcentage d'ancienneté selon son ancienneté mais aussi selon sa csp.
   
   scored_df3 = scored_df2 %>%  #Si il y a des NAs alors les tranches sont mal définies il y certaines temps d'ancienneté qui sont entre 2 tranches
     left_join(mic_df, by = "grp") %>%
     mutate(pourcent_anc = case_when(
                anc < input$Techniciens_Anc_1_tranches[1] & (CAT == "3 - Maîtrises techniciens" | CAT == "2 - Employés") ~ 0,
                anc >= input$Techniciens_Anc_1_tranches[1] & anc < input$Techniciens_Anc_1_tranches[2] & (CAT == "3 - Maîtrises techniciens" | CAT == "2 - Employés" ) ~ input$maj_Techniciens_tranche_1/100,
                anc >= input$Techniciens_Anc_2_tranches[1] & anc < input$Techniciens_Anc_2_tranches[2] & (CAT == "3 - Maîtrises techniciens" | CAT == "2 - Employés") ~ input$maj_Techniciens_tranche_2/100,
                anc >= input$Techniciens_Anc_3_tranches[1] & anc < input$Techniciens_Anc_3_tranches[2] & (CAT == "3 - Maîtrises techniciens" | CAT == "2 - Employés")~ input$maj_Techniciens_tranche_3/100,
                anc >= input$Techniciens_Anc_4_tranches[1] & anc < input$Techniciens_Anc_4_tranches[2] & (CAT == "3 - Maîtrises techniciens" | CAT == "2 - Employés") ~ input$maj_Techniciens_tranche_4/100,
                anc >= input$Techniciens_Anc_5_tranches[1] & anc < input$Techniciens_Anc_5_tranches[2] & (CAT == "3 - Maîtrises techniciens" | CAT == "2 - Employés")~ input$maj_Techniciens_tranche_5/100,
                anc >= input$Techniciens_Anc_6_tranches[1] & anc < input$Techniciens_Anc_6_tranches[2] & (CAT == "3 - Maîtrises techniciens" | CAT == "2 - Employés")~ input$maj_Techniciens_tranche_6/100,
                anc >= input$Techniciens_Anc_7_tranches[1] & anc < input$Techniciens_Anc_7_tranches[2] & (CAT == "3 - Maîtrises techniciens" | CAT == "2 - Employés")~ input$maj_Techniciens_tranche_7/100,
                anc >= input$Techniciens_Anc_8_tranches[1] & anc < input$Techniciens_Anc_8_tranches[2] & (CAT == "3 - Maîtrises techniciens" | CAT == "2 - Employés")~ input$maj_Techniciens_tranche_8/100,
                anc >= input$Techniciens_Anc_9_tranches[1] & anc < input$Techniciens_Anc_9_tranches[2] & (CAT == "3 - Maîtrises techniciens" | CAT == "2 - Employés")~ input$maj_Techniciens_tranche_9/100,
                anc >= input$Techniciens_Anc_10_tranches[1] & (CAT == "3 - Maîtrises techniciens" | CAT == "2 - Employés") ~ input$maj_Techniciens_tranche_10/100,
                
                anc < input$Ouvriers_Anc_1_tranches[1] & CAT == "1 - Ouvriers" ~ 0,
                anc >= input$Ouvriers_Anc_1_tranches[1] & anc < input$Ouvriers_Anc_1_tranches[2] & CAT == "1 - Ouvriers" ~ input$maj_ouvriers_tranche_1/100,
                anc >= input$Ouvriers_Anc_2_tranches[1] & anc < input$Ouvriers_Anc_2_tranches[2] & CAT == "1 - Ouvriers" ~ input$maj_ouvriers_tranche_2/100,
                anc >= input$Ouvriers_Anc_3_tranches[1] & anc < input$Ouvriers_Anc_3_tranches[2] & CAT == "1 - Ouvriers"~ input$maj_ouvriers_tranche_3/100,
                anc >= input$Ouvriers_Anc_4_tranches[1] & anc < input$Ouvriers_Anc_4_tranches[2] & CAT == "1 - Ouvriers"~ input$maj_ouvriers_tranche_4/100,
                anc >= input$Ouvriers_Anc_5_tranches[1] & anc < input$Ouvriers_Anc_5_tranches[2] & CAT == "1 - Ouvriers"~ input$maj_ouvriers_tranche_5/100,
                anc >= input$Ouvriers_Anc_6_tranches[1] & anc < input$Ouvriers_Anc_6_tranches[2] & CAT == "1 - Ouvriers"~ input$maj_ouvriers_tranche_6/100,
                anc >= input$Ouvriers_Anc_7_tranches[1] & anc < input$Ouvriers_Anc_7_tranches[2] & CAT == "1 - Ouvriers"~ input$maj_ouvriers_tranche_7/100,
                anc >= input$Ouvriers_Anc_8_tranches[1] & anc < input$Ouvriers_Anc_8_tranches[2] & CAT == "1 - Ouvriers"~ input$maj_ouvriers_tranche_8/100,
                anc >= input$Ouvriers_Anc_9_tranches[1] & anc < input$Ouvriers_Anc_9_tranches[2] & CAT == "1 - Ouvriers"~ input$maj_ouvriers_tranche_9/100,
                anc >= input$Ouvriers_Anc_10_tranches[1] & CAT == "1 - Ouvriers" ~ input$maj_ouvriers_tranche_10/100,
                
                anc < input$Cadres_Anc_1_tranches[1] & CAT == "4 - Ingénieurs et cadres" ~ 0,
                anc >= input$Cadres_Anc_1_tranches[1] & anc < input$Cadres_Anc_1_tranches[2] & CAT == "4 - Ingénieurs et cadres" ~ input$maj_Cadres_tranche_1/100,
                anc >= input$Cadres_Anc_2_tranches[1] & anc < input$Cadres_Anc_2_tranches[2] & CAT == "4 - Ingénieurs et cadres" ~ input$maj_Cadres_tranche_2/100,
                anc >= input$Cadres_Anc_3_tranches[1] & anc < input$Cadres_Anc_3_tranches[2] & CAT == "4 - Ingénieurs et cadres"~ input$maj_Cadres_tranche_3/100,
                anc >= input$Cadres_Anc_4_tranches[1] & anc < input$Cadres_Anc_4_tranches[2] & CAT == "4 - Ingénieurs et cadres"~ input$maj_Cadres_tranche_4/100,
                anc >= input$Cadres_Anc_5_tranches[1] & anc < input$Cadres_Anc_5_tranches[2] & CAT == "4 - Ingénieurs et cadres"~ input$maj_Cadres_tranche_5/100,
                anc >= input$Cadres_Anc_6_tranches[1] & anc < input$Cadres_Anc_6_tranches[2] & CAT == "4 - Ingénieurs et cadres"~ input$maj_Cadres_tranche_6/100,
                anc >= input$Cadres_Anc_7_tranches[1] & anc < input$Cadres_Anc_7_tranches[2] & CAT == "4 - Ingénieurs et cadres"~ input$maj_Cadres_tranche_7/100,
                anc >= input$Cadres_Anc_8_tranches[1] & anc < input$Cadres_Anc_8_tranches[2] & CAT == "4 - Ingénieurs et cadres"~ input$maj_Cadres_tranche_8/100,
                anc >= input$Cadres_Anc_9_tranches[1] & anc < input$Cadres_Anc_9_tranches[2] & CAT == "4 - Ingénieurs et cadres"~ input$maj_Cadres_tranche_9/100,
                anc >= input$Cadres_Anc_10_tranches[1] & CAT == "4 - Ingénieurs et cadres" ~ input$maj_Cadres_tranche_10/100,
                TRUE ~ 0
              )
            #On prend en compte le fait que la personne n'a pas suffisement d'ancienneté pour recevoir une prime sur la première ligne de chaque paragraphe. La dernière ligne sert à prendre en compte que l'utilisateur peut ne pas mettre des valeurs suffisement hautes pour la borne supérieure de la dernière tranche entrainant des NAs.
            
) %>%
     mutate(minima_maj = round(minima*(1+pourcent_anc))) %>%
     mutate(minima_maj_an = minima_maj*12)
   
  
  

   
   #salaire_trav 
   ## Créer la variable de salaire de travail
   ## En entrée : prendre l'info annuel/mensuel puis l'info primes cochées (vecteur)
   #On fait un if/else pour annuel ou mensuel puis son prend le vecteur de choix = coches correspondant. On map les choix avec les variables puis on fait les ajustement sur ce meme vecteur, il suiffira de faire la correspondance aprés dans le calcul.
  
   

   map_primes = c("Prime ancienneté" = "q_primeanc","Primes de sujetion" = "q_primeorg", "Prime de déroulement de carrière" = "q_primecar", "Prime vacances" = "q_primevac", "Prime de polyvalence" = "q_primepol","13e mois et au-delà" = "q_prime13_14","Bonus et primes de performance" = "q_primeobj")
   
   #On crée le vecteur de variable choisie.

   
   
   #renvois pour chaque variable le nom de la variable rattachée il faut appellé map_prime["Prime ancienneté"] pour obtenir "q_primanc" que l'on peut utiliser dans select() par exemple.
   
   #On prépare deux dataframes pour les deux cas, annuel et mensuel pour lesquels on va, soit diviser, soit multiplier des variables.
   
   
    
    if (is.null(input$primes_choisies_salmens)){
      primes_choisies_salmens = c()
    } else {
      primes_choisies_salmens = input$primes_choisies_salmens
    }
   
   if (is.null(input$primes_choisies_remannu)){
     primes_choisies_remannu = c()
   } else {
     primes_choisies_remannu = input$primes_choisies_remannu
   }
   
     variables_choisies_mois = c("q_salmens", "q_primeanc",map_primes[primes_choisies_salmens])
     variables_choisies_an = c("q_salmens","q_primeanc",map_primes[primes_choisies_remannu])
     
     
     
      #Renvoie un vecteur de la rémunération choisie à chaque salarié par mois
     if (input$remannu_ou_salmens == "Mensuelle") {
       period_title$text = "mensuel"
       
       scored_df4 =  scored_df3 %>%
       mutate(q_primevac = round(q_primevac_old/12)) %>%
       mutate(q_prime13_14 = round((q_prime13_old + q_prime14_old)/12)) %>%
       mutate(q_primeobj = round(q_primeobj_old/12)) %>%
       mutate(q_remannu = round(q_remannu_old/12)) %>%
       mutate(q_prime13 = round(q_prime13_old/12)) %>%
       mutate(q_prime14 = round(q_prime14_old/12)) %>%
       mutate(q_primepol = round(q_primepol_old/12)) %>%
       mutate(q_primeorg = round(q_primeorg_old/12)) %>%
       mutate(q_newsal = rowSums(.[,variables_choisies_mois],na.rm = T)) %>%
       mutate(q_newmin = minima_maj) %>%
       mutate(cout_reval = Calcul_cout_mois(q_newsal, q_newmin))
         
      
       }

       #Renvoie un vecteur de la rémunération choisie à chaque salarié par an
      else {
        period_title$text = "annuel"
       scored_df4 =  scored_df3 %>%
       mutate(q_salmens=q_salmens_old*12) %>%
      mutate(q_salanc=q_salanc_old*12) %>%
      
       mutate(q_primeanc =q_primeanc_old*12) %>%
       mutate(q_primecar = q_primecar_old*12) %>%
       mutate(q_prime13_14 = q_prime13_old+q_prime14_old) %>%
       mutate(q_newsal = rowSums(.[,variables_choisies_an],na.rm = T)) %>%
       mutate(q_newmin = minima_maj*multiple_mini_reactive$val) %>%
       mutate(cout_reval = Calcul_cout_mois(q_newsal, q_newmin))}

   ## newsal est la nouvelle variable de salaire
   
   ## Si annuel et si uniquement prime d'ancienneté cochée 
   ## newmin = minima_maj*12
   ## newsal = q_salmens*12 + q_primeanc*12

   

   
   # Fusionner et calculer les coûts
     scored_df5 <- scored_df4 %>%
     mutate(revalorise = ifelse(cout_reval > 0, 1, 0)) %>%
     mutate(revalorise_oui = ifelse(revalorise == 1, "Oui", "Non")) %>%
     left_join(tp_emploi_repere_code_repere, by = c("code_repere")) 
   
   
   #Ici stocke le résultat de notre base de calcul dans un objet réactif
     


   react_data_indiv$data = scored_df5

   

  
})
 
 
 choosedataset2 = reactive({
   

   
   out_dataset <- react_data_indiv$data %>%  
     filter(groupe_empl %in% reseau_reactive$reseau) %>%  
     filter(tranc %in%  ANC_reactive$tranc) %>%
     filter(grp %in%  grp_reactive$grp) %>%
     filter(CAT %in%  CAT_reactive$CAT) %>%
     filter(groupe_empl %in% reseau_reactive$reseau) %>%
     filter(famille %in% famille_reactive$famille)  %>%
     filter(filiere %in% filiere_reactive$filiere)
   return(out_dataset)
 })
 
 
 
 output$table <- renderDT({
   #Il est important que l'id de l'input soit le même que le nom de la variable. La liste va permettre de crée une liste qui va afficher le nom des variables dans la fonction select.
   #Dans l'iu, les switch sont soit sur position T ou F donc il suffit de prendre tous les inputs pour lesquels la position est T puis les affiché dans la fonction select de manière réactive dans le dataframe "data".

   switch_ids = list('EMPLOI' = input$EMPLOI,
                     'groupe_empl' = input$groupe_empl,
                     'lib_repere' = input$lib_repere,
                     'scores' = input$scores,
                     'grp' = input$grp,
                     'q_newmin' = input$q_newmin,
                     'revalorise_oui' = input$revalorise_oui,
                     'q_newsal' = input$q_newsal,
                     'nom_entr' = input$nom_entr,
                     'taille_entr' = input$taille_entr,
                     'CLASSE' = input$CLASSE,
                     'ID' = input$ID,
                     'CODPOS' = input$CODPOS,
                     'libcom' = input$libcom,
                     'depetab' = input$depetab,
                     'regetab' = input$regetab,
                     'filiere' = input$filiere,
                     'famille' = input$famille,
                     'code_repere' = input$code_repere,
                     'GENRE' = input$GENRE,
                     'CONTRAT' = input$CONTRAT,
                     'CAT' = input$CAT,
                     'age' = input$age,
                     'anc' = input$anc,
                     'coef' = input$coef,
                     'tps_partiel' = input$tps_partiel,
                     'coef_tr' = input$coef_tr,
                     'etp_tp' = input$etp_tp,
                     'MOD_ANC' = input$MOD_ANC,
                     'MOD_CAR' = input$MOD_CAR,
                     'q_salmens' = input$q_salmens,
                     'q_primeanc' = input$q_primeanc,
                     'q_primecar' = input$q_primecar,
                     'q_prime13' = input$q_prime13,
                     'q_prime14' = input$q_prime14,
                     'q_primeobj' = input$q_primeobj,
                     'q_primepol' = input$q_primepol,
                     'q_primeorg' = input$q_primeorg,
                     'q_primevac' = input$q_primevac,
                     'q_remannu' = input$q_remannu,
                     'cout_reval' = input$cout_reval
   )
   

   
   
   col_switch_ids = names(as.data.frame(switch_ids) %>% dplyr::select(where(~isTRUE(.x))))
   

   
   data = choosedataset2() %>%
     #Les différents mutate() à ce niveau ne servent qu'à rendre le tableau plus lisible pour l'utilisateur
     mutate(filiere = substr(filiere,4,100)) %>%
     mutate(famille = substr(famille,4,100)) %>%
     mutate(tranc = case_when(
       tranc == "1 - À l'embauche" ~ "Moins d'un an",
       tranc == "2 - [ 2,5 ans; 5 ans [" ~ "Entre 2,5 ans et 5 ans",
       tranc == "3 - [ 5 ans; 7,5 ans ["  ~ "Entre 5 ans et 7,5 ans",
       tranc == "4 - [ 7,5 ans; 10 ans ["  ~ "Entre 7,5 ans et 10 ans",
       tranc == "5 - [ 10 ans; 15 ans ["  ~ "Entre 10 ans et 15 ans",
       tranc == "6 - [ 15 ans; 20 ans ["  ~ "Entre 15 ans et 20 ans",
       tranc == "7 - [ 20 ans; 25 ans ["  ~ "Entre 20 ans et 25 ans",
       tranc == "8 - [ 25 ans; 30 ans ["  ~ "Entre 25 ans et 30 ans",
       tranc == "9 - plus de 30 ans"  ~ "Plus de 30 ans",
     )) %>%
     mutate(CAT= case_when(
       CAT == "1 - Ouvriers"~ "Ouvrier",
       CAT == "2 - Employés" ~ "Employé",
       CAT == "3 - Maîtrises techniciens" ~ "Maîtrise technicien",
       CAT == "4 - Ingénieurs et cadres" ~ "Ingénieur et cadre",
     )) %>%
     mutate(tps_partiel = case_when(
       tps_partiel == 1 ~ "Temps complet",
       tps_partiel == 2 ~ "Temps partiel",
     )) %>%
     mutate(taille_entr = case_when(
       taille_entr == "01" ~ "Moins de 50 salariés",
       taille_entr == "02" ~ "Entre 50 et 300 salariés",
       taille_entr == "03" ~ "Entre 300 et 1 000 salariés",
       taille_entr == "04" ~ "Plus de 1 000 salariés",
     ))
   
   #Condition: gère le cas ou l'utilisteur désélectionne toutes les colonnes
   if (length(col_switch_ids) == 0) {
     return(datatable(data.frame(Message = "Veuillez sélectionner au moins une colonne.")))
   }
   else if (nrow(data) == 0) {
     return(datatable(data.frame(Message = "Aucun salarié ne correspond aux filtres sélectionnés.")))
   }
   else {
     data <- data %>% dplyr::select(all_of(col_switch_ids))
     datatable(data, filter = 'top', colnames = as.character(translate_var_col[col_switch_ids]), options = list(dom='tp',iDisplayLength = 20))}
 })
 
 output$texttab = renderText(
   HTML(paste0("<p style='color:;font-size:15px;font-weight:bold;'>"," Les montants indiqués pour l'ensemble des éléments de rémunération sont des montants ",period_title$text,"s"))
 )
 
 output$downloadindiv <- downloadHandler(
   filename = function() {
     "donnees_individuelles.xlsx"
   },
   content = function(fname) {
     df = choosedataset2()
     writexl::write_xlsx(df, fname)
   }
 )
 
 
 output$eff_reval <- renderValueBox({ 
   data = choosedataset2()
   nb_sal_reval=nrow(data[data$revalorise,])
   
   
   valueBox(
     value = tags$div(
       icon("person", class = "fa-1x", style = "color: #D37EF9;"), format(nb_sal_reval, big.mark= " "), " salariés",
       style = "font-size : 25px ;display: inline-block; margin-left: 10px; vertical-align: middle;",
       #round(mean(data_set$age), 0)
     ),
     subtitle = "Nombre de salariés revalorisés",
     color = "purple"
   )}
 )
 

 
 
 output$eff_part <- renderValueBox({ 
   data =  choosedataset2()
   part_eff_reval = round((nrow(data[data$revalorise,])/nrow(data))*100,2)
   part_eff_reval = ifelse(nrow(data) == 0,0, part_eff_reval)
   valueBox(
     value = tags$div(
       icon("person", class = "fa-1x", style = "color: #D37EF9;"), format(part_eff_reval, big.mark= " "), " %",
       style = "font-size : 25px ;display: inline-block; margin-left: 10px; vertical-align: middle;",
       #round(mean(data_set$age), 0)
     ),
     subtitle = "Part des effectifs revalorisés",
     color = "purple"
   )}
 )
 
 output$cout_an_tot <- renderValueBox({ 
   data = choosedataset2()
   montant_reval=round(sum(as.numeric(data$cout_reval), na.rm = TRUE))
   montant_reval=montant_reval
   valueBox(
     value = tags$div(
       icon("euro-sign", class = "fa-1x", style = "color: #D37EF9;"), format(montant_reval, big.mark= " "), HTML("euros"),
       style = "font-size : 25px ;display: inline-block; margin-left: 10px; vertical-align: middle;",
     ),
     subtitle = paste0("Montant ",period_title$text," en euros des revalorisations"),
     color = "purple"
   )}
 )
 
 output$cout_part <- renderValueBox({ 
   data = choosedataset2()
   part_cout=round(100*((sum(as.numeric(data$cout_reval), na.rm = TRUE))/sum(as.numeric(data$q_remannu), na.rm = TRUE)),3)
   part_cout=ifelse(sum(as.numeric(data$q_remannu), na.rm = TRUE)==0, 0, part_cout)
   valueBox(
     value = tags$div(
       icon("euro-sign", class = "fa-1x", style = "color: #D37EF9;"), format(part_cout, big.mark= " "), " %",
       style = "font-size : 25px ;display: inline-block; margin-left: 10px; vertical-align: middle;",
       #round(mean(data_set$age), 0)
     ),
     subtitle = "Montant des revalorisations en % de la M.S.",
     color = "purple"
   )}
 ) 
 

 
 
 output$revalorise_chart <- renderHighchart({
   df <- choosedataset2()
   validate(
     need(nrow(df)>0, "Aucun salarié ne correspond aux filtres sélectionnés")
   )
   metric_names <- c("revalorise" = "Nombre de salariés revalorisés",
                     "cout_reval" = paste0("Montant ",period_title$text," en euros des revalorisations"),
                     "part_effectif" = "Part de salariés revalorisés",
                     "part_cout" = "Coût en % de la masse salariale")
   
   
   metric <- input$metric_choice
   metric_name <- metric_names[[metric]]
   
   
   
   #Paramètre qui modifie le format de l'étiquettes des données du graphique.
   
   tooltip_formatter <- switch(metric,
                               "revalorise" = "function() { return '<b>' + this.x + '</b>: ' + this.y + ' salariés'; }",
                               "cout_reval" = "function() { return '<b>' + this.x + '</b>: ' + this.y + ' euros'; }",
                               "part_effectif" = "function() { return '<b>' + this.x + '</b>: ' + this.y + ' % des effectifs'; }",
                               "part_cout" = "function() { return '<b>' + this.x + '</b>: ' + this.y + ' % de la masse salariale'; }"
   )
   
   #Paramètre qui modifie le format des données de l'axe
   y_axis_formatter <- switch(metric,
                              "revalorise" = "function() { return Highcharts.numberFormat(this.value, 0); }",
                              "cout_reval" = "function() { return Highcharts.numberFormat(this.value, 0) + ' €'; }",
                              "part_effectif" = "function() { return this.value + ' %'; }",
                              "part_cout" = "function() { return this.value + ' %'; }"
   )
   
   #Paramètre qui modifie le formatdes valeurs indiquées à l'intérieur du graphique :
   
   data_labels_formatter <- switch(metric,
                                   "revalorise" = "function() { return Highcharts.numberFormat(this.y, 0); }",
                                   "cout_reval" = "function() { return Highcharts.numberFormat(this.y, 0) + ' €'; }",
                                   "part_effectif" = "function() { return this.y + ' %'; }",
                                   "part_cout" = "function() { return this.y + ' %'; }"
   )
   
   #dataframe avec les variables d'intérêt pour le graphique
 
if (input$Exclure0 == F) {
   aggregated_data <- df %>%
     group_by(eval(parse(text = input$grouping))) %>%
     summarise(
       revalorise = sum(revalorise, na.rm = TRUE),
       cout_reval = sum(cout_reval,na.rm = TRUE),
       part_effectif = round((sum(as.numeric(revalorise),na.rm=TRUE)/n())*100,2),
       part_cout = round(100*((sum(as.numeric(cout_reval), na.rm = TRUE))/sum(as.numeric(q_remannu), na.rm = TRUE)),3)
     )
   names(aggregated_data) = c(input$grouping,"revalorise","cout_reval","part_effectif","part_cout")}
   
   else {aggregated_data <- df %>%
     group_by(eval(parse(text = input$grouping))) %>%
     summarise(
       revalorise = sum(revalorise, na.rm = TRUE),
       cout_reval = sum(cout_reval,na.rm = TRUE),
       part_effectif = round((sum(as.numeric(revalorise),na.rm=TRUE)/n())*100,2),
       part_cout = round(100*((sum(as.numeric(cout_reval), na.rm = TRUE))/sum(as.numeric(q_remannu), na.rm = TRUE)),3)
     ) %>%
     filter(revalorise > 0 & cout_reval > 0)
   names(aggregated_data) = c(input$grouping,"revalorise","cout_reval","part_effectif","part_cout")}
   

   
   #Change le titre si on considère une part ou un nombre.
   
   title_text <-
     if (input$grouping == "filiere" ) {
       paste(metric_name, "selon les filières")
     } else if (input$grouping == "famille") {
       paste(metric_name, "selon les familles")

     } else if (input$grouping == "lib_repere") {
       paste(metric_name, "selon les emplois-repères")
     } else if (input$grouping == "tranc") {
       paste(metric_name, "selon les tranches d'ancienneté")
     } else if (input$grouping == "grp") {
       paste(metric_name, "selon les groupes")
     }
  
   rotate =
     if (input$grouping == "grp") {
       rotate = 0 
     } else if (length(aggregated_data[[input$grouping]])<9) {
       rotate = 0
     } else if (length(aggregated_data[[input$grouping]])<20) {
       rotate = -50
       
     } else {
       rotate = -90
     } 
   #change la rotation du texte du graphique.
   
   
   
   highchart() %>%
     hc_chart(type = "column", backgroundColor = "#fff") %>%
     hc_title(
       text = title_text,
       align = "left",
       style = list(
         fontSize = "16px",
         color = "#8192AE"
       )
     ) %>%
     hc_xAxis(categories = aggregated_data[[input$grouping]], labels = list(step = 1, style = list(color = "#8192AE"), rotation = rotate)) %>%
     hc_yAxis(labels = list(formatter = JS(y_axis_formatter))) %>%
     hc_series(list(
       name = metric_name,
       data = aggregated_data[[metric]],
       color = "#8346AD",
       dataLabels = list(enabled = TRUE, formatter = JS(data_labels_formatter))
     )) %>%
     hc_plotOptions(column = list(dataLabels = list(enabled = TRUE))) %>%
     hc_plotOptions(allowOverlap = TRUE) %>%
     hc_legend(enabled = FALSE) %>%
     hc_exporting(enabled = TRUE, color = "#fff") %>%
     hc_tooltip(formatter = JS(tooltip_formatter))
 })
 
 ###### Boutons Download 
 
 # Bouton pour les minima
 
 
 output$dl_minima_sliders <- downloadHandler(
   
   filename = function() {
     paste0("scenario_minima-", format(Sys.time(), format = "%Y-%m-%d_%H%M"), ".xlsx")
   },
   content = function(con) {
     if (input$custom_number_classifications  == 8) {
       res <- unlist(lapply(
         X = paste0("classif_", c("1","2","3","4","5","6","7","8")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Minima"
       res$Classe <- c("1","2","3","4","5","6","7","8")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     } else if (input$custom_number_classifications  == 9) {
       res <- unlist(lapply(
         X = paste0("classif_", c("1","2","3","4","5","6","7","8","9")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Minima"
       res$Classe <- c("1","2","3","4","5","6","7","8","9")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     } else if (input$custom_number_classifications  == 10) {
       res <- unlist(lapply(
         X = paste0("classif_", c("1","2","3","4","5","6","7","8","9", "10")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Minima"
       res$Classe <- c("1","2","3","4","5","6","7","8","9", "10")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     } else if (input$custom_number_classifications  == 11) {
       res <- unlist(lapply(
         X = paste0("classif_", c("1","2","3","4","5","6","7","8","9", "10", "11")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Minima"
       res$Classe <- c("1","2","3","4","5","6","7","8","9", "10", "11")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     } else if (input$custom_number_classifications  == 12) {
       res <- unlist(lapply(
         X = paste0("classif_", c("1","2","3","4","5","6","7","8","9", "10", "11", "12")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Minima"
       res$Classe <- c("1","2","3","4","5","6","7","8","9", "10", "11", "12")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     } else if (input$custom_number_classifications  == 13) {
       res <- unlist(lapply(
         X = paste0("classif_", c("1","2","3","4","5","6","7","8","9", "10", "11", "12", "13")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Minima"
       res$Classe <- c("1","2","3","4","5","6","7","8","9", "10", "11", "12", "13")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     } else if (input$custom_number_classifications  == 14) {
       res <- unlist(lapply(
         X = paste0("classif_", c("1","2","3","4","5","6","7","8","9", "10", "11", "12", "13", "14")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Minima"
       res$Classe <- c("1","2","3","4","5","6","7","8","9", "10", "11", "12", "13", "14")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     } else if (input$custom_number_classifications  == 15) {
       res <- unlist(lapply(
         X = paste0("classif_", c("1","2","3","4","5","6","7","8","9", "10", "11", "12", "13", "14", "15")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Minima"
       res$Classe <- c("1","2","3","4","5","6","7","8","9", "10", "11", "12", "13", "14", "15")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     } else if (input$custom_number_classifications  == 16) {
       res <- unlist(lapply(
         X = paste0("classif_", c("1","2","3","4","5","6","7","8","9", "10", "11", "12", "13", "14", "15", "16")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Minima"
       res$Classe <- c("1","2","3","4","5","6","7","8","9", "10", "11", "12", "13", "14", "15", "16")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     } else if (input$custom_number_classifications  == 17) {
       res <- unlist(lapply(
         X = paste0("classif_", c("1","2","3","4","5","6","7","8","9", "10", "11", "12", "13", "14", "15", "16", "17")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Minima"
       res$Classe <- c("1","2","3","4","5","6","7","8","9", "10", "11", "12", "13", "14", "15", "16", "17")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     } else if (input$custom_number_classifications  == 18) {
       res <- unlist(lapply(
         X = paste0("classif_", c("1","2","3","4","5","6","7","8","9", "10", "11", "12", "13", "14", "15", "16", "17", "18")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Minima"
       res$Classe <- c("1","2","3","4","5","6","7","8","9", "10", "11", "12", "13", "14", "15", "16", "17", "18")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     } else if (input$custom_number_classifications  == 19) {
       res <- unlist(lapply(
         X = paste0("classif_", c("1","2","3","4","5","6","7","8","9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Minima"
       res$Classe <- c("1","2","3","4","5","6","7","8","9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     } else if (input$custom_number_classifications  == 20) {
       res <- unlist(lapply(
         X = paste0("classif_", c("1","2","3","4","5","6","7","8","9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Minima"
       res$Classe <- c("1","2","3","4","5","6","7","8","9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     }
     else if (input$custom_number_classifications  == 21){
       res <- unlist(lapply(
         X = paste0("classif_", c("1","2","3","4","5","6","7","8","9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Minima"
       res$Classe <- c("1","2","3","4","5","6","7","8","9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     }
     else if (input$custom_number_classifications == 22)  {
       res <- unlist(lapply(
         X = paste0("classif_", c("1","2","3","4","5","6","7","8","9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21","22")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Minima"
       res$Classe <- c("1","2","3","4","5","6","7","8","9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21","22")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     }
     else if (input$custom_number_classifications == 23) {
       res <- unlist(lapply(
         X = paste0("classif_", c("1","2","3","4","5","6","7","8","9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21","22","23")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Minima"
       res$Classe <- c("1","2","3","4","5","6","7","8","9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21","22","23")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     }
     else if (input$custom_number_classifications == 24) {
       res <- unlist(lapply(
         X = paste0("classif_", c("1","2","3","4","5","6","7","8","9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21","22","23","24")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Minima"
       res$Classe <- c("1","2","3","4","5","6","7","8","9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21","22","23","24")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     }
     else if (input$custom_number_classifications == 25) {
       res <- unlist(lapply(
         X = paste0("classif_", c("1","2","3","4","5","6","7","8","9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21","22","23","24","25")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Minima"
       res$Classe <- c("1","2","3","4","5","6","7","8","9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21","22","23","24","25")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     }
   }
 )
 
 
 # Bouton pour les emplois-repères
 
 output$dl_scores_emploi_reperes_sliders <- downloadHandler(
   
   filename = function() {
     paste0("scenario_scores_emplois_reperes-", format(Sys.time(), format = "%Y-%m-%d_%H%M"), ".xlsx")
   },
   content = function(con) {
     res <- unlist(lapply(
       X = paste0("score_", c("acheteur_commande_publique", "administrateur_systemes_reseaux", "agent_charge_methodes_exploitation", "agent_manoeuvre",
                              "agent_planning", "agent_surete", "agent_back_office",
                              "aiguilleur", "animateur_qualite", "animateur_securite_prevention", "assistant_commercial_marketing", "assistant_controle_gestion", 
                              "assistant_direction","assistant_rh", "charge_etudes", "charge_communication", "charge_marketing", "charge_recrutement", 
                              
                              "charge_web_editorial", "charge_developpeur", "chef_projet_appel_offres", "chef_projet_SI", "collecteur_recettes", "community_manager",
                              "comptable", "conducteur_bus", "conducteur_metro", "conducteur_polyvalent_multimodal", "conducteur_polyvalent_verificateur_agent_commercial",
                              "conducteur_pmr_tad", "conducteur_tram", "conseiller_commercial", "controleur_gestion", "formateur", "gestionnaire_assurance",
                              "gestionnaire_approvisionnement_stock", "gestionnaire_paie", "gestionnaire_parc_velo", "gestionnaire_contrats", "infographiste",
                              
                              "ingenieur_cybersecurite", "ingenieur_maintenance", "ingenieur_methodes_maintenance", "ingenieur_financier", "juriste", "manager_conducteurs",
                              "manager_conseiller_commercial", "manager_techniciens_maintenance", "manager_techniciens_maintenance_parc", "manager_verificateurs",
                              "manager_equipe_agents_surete", "mediateur", "operateur_pc_surete", "operateur_technique_informations_voyageurs", "regulateur", 
                              "responsable_administrateur_financier", "responsable_approvisionnement_stock", "responsable_commercial", "responsable_communication", 
                              "responsable_comptabilite", "responsable_equipe_achat_commande_publique", "responsable_exploitation", "responsable_formation",
                              
                              "responsable_maintenance", "responsable_production_operation", "responsable_societe", "responsable_SI", "responsable_bureau_etudes_methodes_exploitation",
                              "responsable_service_client", "responsable_fraude", "responsable_RSE", "responsable_juridique", "responsable_marketing", 
                              "responsable_performance_operationnelle", "responsable_qualite", "relations_institutionnelles", "responsable_rh", "responsable_HSE",
                              "responsable_secteur", "responsable_securite_prevention", "responsable_appels_offre", "technicien_maintenance_parc", "technicien_exploitation",
                              "technicien_maintenance", "technicien_methodes_maintenance", "technicien_intervention_systemes_automatiques_autonomes",
                              "technicien_superieur_exploitation", "verificateur")),
       FUN = function(x) {
         input[[x]]
       }
     ))
     res <- as.data.frame(res)
     names(res) <- "Scores"
     res$lib_emploi <- c("acheteur_commande_publique", "administrateur_systemes_reseaux", "agent_charge_methodes_exploitation", "agent_manoeuvre",
                         "agent_planning", "agent_surete", "agent_back_office",
                         "aiguilleur", "animateur_qualite", "animateur_securite_prevention", "assistant_commercial_marketing", "assistant_controle_gestion", 
                         "assistant_direction","assistant_rh", "charge_etudes", "charge_communication", "charge_marketing", "charge_recrutement", 
                         
                         "charge_web_editorial", "charge_developpeur", "chef_projet_appel_offres", "chef_projet_SI", "collecteur_recettes", "community_manager",
                         "comptable", "conducteur_bus", "conducteur_metro", "conducteur_polyvalent_multimodal", "conducteur_polyvalent_verificateur_agent_commercial",
                         "conducteur_pmr_tad", "conducteur_tram", "conseiller_commercial", "controleur_gestion", "formateur", "gestionnaire_assurance",
                         "gestionnaire_approvisionnement_stock", "gestionnaire_paie", "gestionnaire_parc_velo", "gestionnaire_contrats", "infographiste",
                         
                         "ingenieur_cybersecurite", "ingenieur_maintenance", "ingenieur_methodes_maintenance", "ingenieur_financier", "juriste", "manager_conducteurs",
                         "manager_conseiller_commercial", "manager_techniciens_maintenance", "manager_techniciens_maintenance_parc", "manager_verificateurs",
                         "manager_equipe_agents_surete", "mediateur", "operateur_pc_surete", "operateur_technique_informations_voyageurs", "regulateur", 
                         "responsable_administrateur_financier", "responsable_approvisionnement_stock", "responsable_commercial", "responsable_communication", 
                         "responsable_comptabilite", "responsable_equipe_achat_commande_publique", "responsable_exploitation", "responsable_formation",
                         
                         "responsable_maintenance", "responsable_production_operation", "responsable_societe", "responsable_SI", "responsable_bureau_etudes_methodes_exploitation",
                         "responsable_service_client", "responsable_fraude", "responsable_RSE", "responsable_juridique", "responsable_marketing", 
                         "responsable_performance_operationnelle", "responsable_qualite", "relations_institutionnelles", "responsable_rh", "responsable_HSE",
                         "responsable_secteur", "responsable_securite_prevention", "responsable_appels_offre", "technicien_maintenance_parc", "technicien_exploitation",
                         "technicien_maintenance", "technicien_methodes_maintenance", "technicien_intervention_systemes_automatiques_autonomes",
                         "technicien_superieur_exploitation", "verificateur")
     writexl::write_xlsx(x = res[, c(2, 1)], path = con)
   }
 )
 
 # Bouton pour les groupes
 
 
 output$dl_scores_plafond_groupes_sliders <- downloadHandler(
   
   filename = function() {
     paste0("scenario_groupes-", format(Sys.time(), format = "%Y-%m-%d_%H%M"), ".xlsx")
   },
   content = function(con) {
     if (input$custom_number_classifications  == 8) {
       res <- unlist(lapply(
         X = paste0("score_plafond_8_", c("A","B","C","D","E","F","G","H")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Score_Plafond"
       res$Groupe <- c("A","B","C","D","E","F","G","H")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     } else if (input$custom_number_classifications  == 9) {
       res <- unlist(lapply(
         X = paste0("score_plafond_9_", c("A","B","C","D","E","F","G","H", "I")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Score_Plafond"
       res$Groupe <- c("A","B","C","D","E","F","G","H", "I")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     } else if (input$custom_number_classifications  == 10) {
       res <- unlist(lapply(
         X = paste0("score_plafond_10_", c("A","B","C","D","E","F","G","H", "I", "J")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Score_Plafond"
       res$Groupe <- c("A","B","C","D","E","F","G","H", "I", "J")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     } else if (input$custom_number_classifications  == 11) {
       res <- unlist(lapply(
         X = paste0("score_plafond_11_", c("A","B","C","D","E","F","G","H", "I", "J", "K")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Score_Plafond"
       res$Groupe <- c("A","B","C","D","E","F","G","H", "I", "J", "K")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     } else if (input$custom_number_classifications  == 12) {
       res <- unlist(lapply(
         X = paste0("score_plafond_12_", c("A","B","C","D","E","F","G","H", "I", "J", "K", "L")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Score_Plafond"
       res$Groupe <- c("A","B","C","D","E","F","G","H", "I", "J", "K", "L")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     } else if (input$custom_number_classifications  == 13) {
       res <- unlist(lapply(
         X = paste0("score_plafond_13_", c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Score_Plafond"
       res$Groupe <- c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     } else if (input$custom_number_classifications  == 14) {
       res <- unlist(lapply(
         X = paste0("score_plafond_14_", c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Score_Plafond"
       res$Groupe <- c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     } else if (input$custom_number_classifications  == 15) {
       res <- unlist(lapply(
         X = paste0("score_plafond_15_", c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N", "O")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Score_Plafond"
       res$Groupe <- c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N", "O")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     } else if (input$custom_number_classifications  == 16) {
       res <- unlist(lapply(
         X = paste0("score_plafond_16_", c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N", "O", "P")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Score_Plafond"
       res$Groupe <- c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N", "O","P")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     } else if (input$custom_number_classifications  == 17) {
       res <- unlist(lapply(
         X = paste0("score_plafond_17_", c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N", "O", "P", "Q")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Score_Plafond"
       res$Groupe <- c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N", "O","P", "Q")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     } else if (input$custom_number_classifications  == 18) {
       res <- unlist(lapply(
         X = paste0("score_plafond_18_", c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Score_Plafond"
       res$Groupe <- c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N", "O","P", "Q", "R")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     } else if (input$custom_number_classifications  == 19) {
       res <- unlist(lapply(
         X = paste0("score_plafond_19_", c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Score_Plafond"
       res$Groupe <- c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N", "O","P", "Q", "R", "S")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     } else if (input$custom_number_classifications  == 20) {
       res <- unlist(lapply(
         X = paste0("score_plafond_20_", c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Score_Plafond"
       res$Groupe <- c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N", "O","P", "Q", "R", "S", "T")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     } else if (input$custom_number_classifications  == 21) {
       res <- unlist(lapply(
         X = paste0("score_plafond_21_", c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Score_Plafond"
       res$Groupe <- c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N", "O","P", "Q", "R", "S", "T", "U")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     } else if (input$custom_number_classifications  == 22) {
       res <- unlist(lapply(
         X = paste0("score_plafond_22_", c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Score_Plafond"
       res$Groupe <- c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N", "O","P", "Q", "R", "S", "T", "U","V")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     } else if (input$custom_number_classifications  == 23) {
       res <- unlist(lapply(
         X = paste0("score_plafond_23_", c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V","W")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Score_Plafond"
       res$Groupe <- c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N", "O","P", "Q", "R", "S", "T", "U","V", "W")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     } else if (input$custom_number_classifications  == 24) {
       res <- unlist(lapply(
         X = paste0("score_plafond_24_", c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V","W", "X")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Score_Plafond"
       res$Groupe <- c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N", "O","P", "Q", "R", "S", "T", "U","V", "W","X")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     } else if (input$custom_number_classifications  == 25) {
       res <- unlist(lapply(
         X = paste0("score_plafond_25_", c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V","W", "X","Y")),
         FUN = function(x) {
           input[[x]]
         }
       ))
       res <- as.data.frame(res)
       names(res) <- "Score_Plafond"
       res$Groupe <- c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N", "O","P", "Q", "R", "S", "T", "U","V", "W","X","Y")
       writexl::write_xlsx(x = res[, c(2, 1)], path = con)
     }
     
   }
   
 )
 
 ###############################
 ###### Boutons UPLOAD 
 ##############################
 
 
 # Bouton pour les minima
 
 observeEvent(input$up_minima_sliders, {
   value_sliders <<- try(read_excel(path=input$up_minima_sliders$datapath),silent=TRUE)
   
   if ("try-error" %in% class(value_sliders)) {
     
     alerte(
       title = "Échec de l'import",
       text = "Le fichier importé doit être un fichier .xlsx",
       type = "error"
     )
   } else {
     if (input$custom_number_classifications  == 8){
       if (all(c("Minima", "Classe") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Minima)) == 0) &
           (sum(is.na(value_sliders$Classe)) == 0) &
           all(as.character(value_sliders$Classe)==c("1","2","3","4","5","6","7","8"))) {
         
         ids <- value_sliders$Classe
         
         values <- as.numeric(value_sliders$Minima)
         for (i in seq_along(ids)) {
           updateSliderInput(session=session, inputId = paste0("classif_", ids[i]), value = values[i])
         }
       } else {
         alerte(
           title = "Échec de la mise à jour des minima",
           text = "Le fichier importé doit comporter une colonne intitulée 'Classe' et une colonne intitulée 'Minima'. Toutes les classes de 1 à 8 doivent être mentionnées et avoir un minimum associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
         
         
       }
     } else if (input$custom_number_classifications  == 9){
       if (all(c("Minima", "Classe") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Minima)) == 0) &
           (sum(is.na(value_sliders$Classe)) == 0) &
           all(as.character(value_sliders$Classe)==c("1","2","3","4","5","6","7","8","9"))) {
         
         ids <- value_sliders$Classe
         
         values <- as.numeric(value_sliders$Minima)
         for (i in seq_along(ids)) {
           updateSliderInput(session=session, inputId = paste0("classif_", ids[i]), value = values[i])
         }
       } else {
         alerte(
           title = "Échec de la mise à jour des minima",
           text = "Le fichier importé doit comporter une colonne intitulée 'Classe' et une colonne intitulée 'Minima'. Toutes les classes de 1 à 9 doivent être mentionnées et avoir un minimum associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
         
         
       }
     }else if (input$custom_number_classifications  == 10){
       if (all(c("Minima", "Classe") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Minima)) == 0) &
           (sum(is.na(value_sliders$Classe)) == 0) &
           all(as.character(value_sliders$Classe)==c("1","2","3","4","5","6","7","8","9", "10"))) {
         
         ids <- value_sliders$Classe
         
         values <- as.numeric(value_sliders$Minima)
         for (i in seq_along(ids)) {
           updateSliderInput(session=session, inputId = paste0("classif_", ids[i]), value = values[i])
         }
       } else {
         alerte(
           title = "Échec de la mise à jour des minima",
           text = "Le fichier importé doit comporter une colonne intitulée 'Classe' et une colonne intitulée 'Minima'. Toutes les classes de 1 à 10 doivent être mentionnées et avoir un minimum associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
         
         
       }
     } else if (input$custom_number_classifications  == 11){
       if (all(c("Minima", "Classe") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Minima)) == 0) &
           (sum(is.na(value_sliders$Classe)) == 0) &
           all(as.character(value_sliders$Classe)==c("1","2","3","4","5","6","7","8","9", "10", "11"))) {
         
         ids <- value_sliders$Classe
         
         values <- as.numeric(value_sliders$Minima)
         for (i in seq_along(ids)) {
           updateSliderInput(session=session, inputId = paste0("classif_", ids[i]), value = values[i])
         }
       } else {
         alerte(
           title = "Échec de la mise à jour des minima",
           text = "Le fichier importé doit comporter une colonne intitulée 'Classe' et une colonne intitulée 'Minima'. Toutes les classes de 1 à 11 doivent être mentionnées et avoir un minimum associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
         
         
       }
     } else if (input$custom_number_classifications  == 12){
       if (all(c("Minima", "Classe") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Minima)) == 0) &
           (sum(is.na(value_sliders$Classe)) == 0) &
           all(as.character(value_sliders$Classe)==c("1","2","3","4","5","6","7","8","9", "10", "11", "12"))) {
         
         ids <- value_sliders$Classe
         
         values <- as.numeric(value_sliders$Minima)
         for (i in seq_along(ids)) {
           updateSliderInput(session=session, inputId = paste0("classif_", ids[i]), value = values[i])
         }
       } else {
         alerte(
           title = "Échec de la mise à jour des minima",
           text = "Le fichier importé doit comporter une colonne intitulée 'Classe' et une colonne intitulée 'Minima'. Toutes les classes de 1 à 12 doivent être mentionnées et avoir un minimum associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
         
         
       }
     } else if (input$custom_number_classifications  == 13){
       if (all(c("Minima", "Classe") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Minima)) == 0) &
           (sum(is.na(value_sliders$Classe)) == 0) &
           all(as.character(value_sliders$Classe)==c("1","2","3","4","5","6","7","8","9","10", "11", "12", "13"))) {
         
         ids <- value_sliders$Classe
         
         values <- as.numeric(value_sliders$Minima)
         for (i in seq_along(ids)) {
           updateSliderInput(session=session, inputId = paste0("classif_", ids[i]), value = values[i])
         }
       } else {
         alerte(
           title = "Échec de la mise à jour des minima",
           text = "Le fichier importé doit comporter une colonne intitulée 'Classe' et une colonne intitulée 'Minima'. Toutes les classes de 1 à 13 doivent être mentionnées et avoir un minimum associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
         
         
       }
     } else if (input$custom_number_classifications  == 14){
       if (all(c("Minima", "Classe") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Minima)) == 0) &
           (sum(is.na(value_sliders$Classe)) == 0) &
           all(as.character(value_sliders$Classe)==c("1","2","3","4","5","6","7","8","9","10", "11", "12", "13", "14"))) {
         
         ids <- value_sliders$Classe
         
         values <- as.numeric(value_sliders$Minima)
         for (i in seq_along(ids)) {
           updateSliderInput(session=session, inputId = paste0("classif_", ids[i]), value = values[i])
         }
       } else {
         alerte(
           title = "Échec de la mise à jour des minima",
           text = "Le fichier importé doit comporter une colonne intitulée 'Classe' et une colonne intitulée 'Minima'. Toutes les classes de 1 à 14 doivent être mentionnées et avoir un minimum associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
         
         
       }
     } else if (input$custom_number_classifications  == 15){
       if (all(c("Minima", "Classe") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Minima)) == 0) &
           (sum(is.na(value_sliders$Classe)) == 0) &
           all(as.character(value_sliders$Classe)==c("1","2","3","4","5","6","7","8","9","10", "11", "12", "13", "14", "15"))) {
         
         ids <- value_sliders$Classe
         
         values <- as.numeric(value_sliders$Minima)
         for (i in seq_along(ids)) {
           updateSliderInput(session=session, inputId = paste0("classif_", ids[i]), value = values[i])
         }
       } else {
         alerte(
           title = "Échec de la mise à jour des minima",
           text = "Le fichier importé doit comporter une colonne intitulée 'Classe' et une colonne intitulée 'Minima'. Toutes les classes de 1 à 15 doivent être mentionnées et avoir un minimum associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
         
         
       }
     } else if (input$custom_number_classifications  == 16){
       if (all(c("Minima", "Classe") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Minima)) == 0) &
           (sum(is.na(value_sliders$Classe)) == 0) &
           all(as.character(value_sliders$Classe)==c("1","2","3","4","5","6","7","8","9","10", "11", "12", "13", "14", "15", "16"))) {
         
         ids <- value_sliders$Classe
         
         values <- as.numeric(value_sliders$Minima)
         for (i in seq_along(ids)) {
           updateSliderInput(session=session, inputId = paste0("classif_", ids[i]), value = values[i])
         }
       } else {
         alerte(
           title = "Échec de la mise à jour des minima",
           text = "Le fichier importé doit comporter une colonne intitulée 'Classe' et une colonne intitulée 'Minima'. Toutes les classes de 1 à 16 doivent être mentionnées et avoir un minimum associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
         
         
       }
     }  else if (input$custom_number_classifications  == 17){
       if (all(c("Minima", "Classe") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Minima)) == 0) &
           (sum(is.na(value_sliders$Classe)) == 0) &
           all(as.character(value_sliders$Classe)==c("1","2","3","4","5","6","7","8","9","10", "11", "12", "13", "14", "15", "16", "17"))) {
         
         ids <- value_sliders$Classe
         
         values <- as.numeric(value_sliders$Minima)
         for (i in seq_along(ids)) {
           updateSliderInput(session=session, inputId = paste0("classif_", ids[i]), value = values[i])
         }
       } else {
         alerte(
           title = "Échec de la mise à jour des minima",
           text = "Le fichier importé doit comporter une colonne intitulée 'Classe' et une colonne intitulée 'Minima'. Toutes les classes de 1 à 17 doivent être mentionnées et avoir un minimum associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
         
         
       }
     } else if (input$custom_number_classifications  == 18){
       if (all(c("Minima", "Classe") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Minima)) == 0) &
           (sum(is.na(value_sliders$Classe)) == 0) &
           all(as.character(value_sliders$Classe)==c("1","2","3","4","5","6","7","8","9","10", "11", "12", "13", "14", "15", "16", "17", "18"))) {
         
         ids <- value_sliders$Classe
         
         values <- as.numeric(value_sliders$Minima)
         for (i in seq_along(ids)) {
           updateSliderInput(session=session, inputId = paste0("classif_", ids[i]), value = values[i])
         }
       } else {
         alerte(
           title = "Échec de la mise à jour des minima",
           text = "Le fichier importé doit comporter une colonne intitulée 'Classe' et une colonne intitulée 'Minima'. Toutes les classes de 1 à 18 doivent être mentionnées et avoir un minimum associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
         
         
       }
     }  else if (input$custom_number_classifications  == 19){
       if (all(c("Minima", "Classe") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Minima)) == 0) &
           (sum(is.na(value_sliders$Classe)) == 0) &
           all(as.character(value_sliders$Classe)==c("1","2","3","4","5","6","7","8","9","10", "11", "12", "13", "14", "15", "16", "17", "18", "19"))) {
         
         ids <- value_sliders$Classe
         
         values <- as.numeric(value_sliders$Minima)
         for (i in seq_along(ids)) {
           updateSliderInput(session=session, inputId = paste0("classif_", ids[i]), value = values[i])
         }
       } else {
         alerte(
           title = "Échec de la mise à jour des minima",
           text = "Le fichier importé doit comporter une colonne intitulée 'Classe' et une colonne intitulée 'Minima'. Toutes les classes de 1 à 19 doivent être mentionnées et avoir un minimum associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
         
         
       }
     }  else if (input$custom_number_classifications  == 20){
       if (all(c("Minima", "Classe") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Minima)) == 0) &
           (sum(is.na(value_sliders$Classe)) == 0) &
           all(as.character(value_sliders$Classe)==c("1","2","3","4","5","6","7","8","9","10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"))) {
         
         ids <- value_sliders$Classe
         
         values <- as.numeric(value_sliders$Minima)
         for (i in seq_along(ids)) {
           updateSliderInput(session=session, inputId = paste0("classif_", ids[i]), value = values[i])
         }
       } else {
         alerte(
           title = "Échec de la mise à jour des minima",
           text = "Le fichier importé doit comporter une colonne intitulée 'Classe' et une colonne intitulée 'Minima'. Toutes les classes de 1 à 20 doivent être mentionnées et avoir un minimum associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
         
         
       }
     }  else if (input$custom_number_classifications  == 21) {
       if (all(c("Minima", "Classe") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Minima)) == 0) &
           (sum(is.na(value_sliders$Classe)) == 0) &
           all(as.character(value_sliders$Classe)==c("1","2","3","4","5","6","7","8","9","10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21"))) {
         
         ids <- value_sliders$Classe
         
         values <- as.numeric(value_sliders$Minima)
         for (i in seq_along(ids)) {
           updateSliderInput(session=session, inputId = paste0("classif_", ids[i]), value = values[i])
         }
       } else {
         alerte(
           title = "Échec de la mise à jour des minima",
           text = "Le fichier importé doit comporter une colonne intitulée 'Classe' et une colonne intitulée 'Minima'. Toutes les classes de 1 à 21 doivent être mentionnées et avoir un minimum associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
         
         
       }
     }  else if (input$custom_number_classifications  == 22) {
       if (all(c("Minima", "Classe") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Minima)) == 0) &
           (sum(is.na(value_sliders$Classe)) == 0) &
           all(as.character(value_sliders$Classe)==c("1","2","3","4","5","6","7","8","9","10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22"))) {
         
         ids <- value_sliders$Classe
         
         values <- as.numeric(value_sliders$Minima)
         for (i in seq_along(ids)) {
           updateSliderInput(session=session, inputId = paste0("classif_", ids[i]), value = values[i])
         }
       } else {
         alerte(
           title = "Échec de la mise à jour des minima",
           text = "Le fichier importé doit comporter une colonne intitulée 'Classe' et une colonne intitulée 'Minima'. Toutes les classes de 1 à 22 doivent être mentionnées et avoir un minimum associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
         
         
       }
     }  else if (input$custom_number_classifications  == 23) {
       if (all(c("Minima", "Classe") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Minima)) == 0) &
           (sum(is.na(value_sliders$Classe)) == 0) &
           all(as.character(value_sliders$Classe)==c("1","2","3","4","5","6","7","8","9","10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"))) {
         
         ids <- value_sliders$Classe
         
         values <- as.numeric(value_sliders$Minima)
         for (i in seq_along(ids)) {
           updateSliderInput(session=session, inputId = paste0("classif_", ids[i]), value = values[i])
         }
       } else {
         alerte(
           title = "Échec de la mise à jour des minima",
           text = "Le fichier importé doit comporter une colonne intitulée 'Classe' et une colonne intitulée 'Minima'. Toutes les classes de 1 à 23 doivent être mentionnées et avoir un minimum associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
         
         
       }
     }  else if (input$custom_number_classifications  == 24) {
       if (all(c("Minima", "Classe") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Minima)) == 0) &
           (sum(is.na(value_sliders$Classe)) == 0) &
           all(as.character(value_sliders$Classe)==c("1","2","3","4","5","6","7","8","9","10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"))) {
         
         ids <- value_sliders$Classe
         
         values <- as.numeric(value_sliders$Minima)
         for (i in seq_along(ids)) {
           updateSliderInput(session=session, inputId = paste0("classif_", ids[i]), value = values[i])
         }
       } else {
         alerte(
           title = "Échec de la mise à jour des minima",
           text = "Le fichier importé doit comporter une colonne intitulée 'Classe' et une colonne intitulée 'Minima'. Toutes les classes de 1 à 24 doivent être mentionnées et avoir un minimum associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
         
         
       }
     }  else {
       if (all(c("Minima", "Classe") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Minima)) == 0) &
           (sum(is.na(value_sliders$Classe)) == 0) &
           all(as.character(value_sliders$Classe)==c("1","2","3","4","5","6","7","8","9","10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21","25"))) {
         
         ids <- value_sliders$Classe
         
         values <- as.numeric(value_sliders$Minima)
         for (i in seq_along(ids)) {
           updateSliderInput(session=session, inputId = paste0("classif_", ids[i]), value = values[i])
         }
       } else {
         alerte(
           title = "Échec de la mise à jour des minima",
           text = "Le fichier importé doit comporter une colonne intitulée 'Classe' et une colonne intitulée 'Minima'. Toutes les classes de 1 à 25 doivent être mentionnées et avoir un minimum associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
         
         
       }
     }
     
     
   }
 }
 )
 
 # Bouton pour les emplois-repères
 
 observeEvent(input$up_scores_emplois_reperes_sliders, {
   value_sliders <<- try(read_excel(path=input$up_scores_emplois_reperes_sliders$datapath),silent=TRUE)
   
   if ("try-error" %in% class(value_sliders)) {
     
     alerte(
       title = "Échec de l'import",
       text = "Le fichier importé doit être un fichier .xlsx",
       type = "error"
     )
   } else {
     if (all(c("lib_emploi", "Scores") %in% names(value_sliders))) {
       
       
       value_sliders = base_score %>%
         left_join(value_sliders, by = join_by(lib_emploi))
       
       ids = value_sliders$lib_emploi
       
       values = as.numeric(value_sliders$Scores)
       length_ids = length(ids)
       
       for (i in 1:length_ids) {
         updateNumericInput(session=session, inputId = paste0("score_", ids[i]), value = values[i])
       }
     } else {
       alerte(
         title = "Échec de la mise à jour des scores des lib_emploi",
         text = "Le fichier importé doit comporter une colonne intitulée 'lib_emploi' et une colonne intitulée 'Scores'. Tous les lib_emploi doivent être mentionnés et avoir un score associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
         type = "error"
       )
       
       
     }
   }
 }
 )
 
 
 # Bouton pour les groupes
 observeEvent(input$up_scores_plafond_groupes_sliders, {
   value_sliders <<- try(read_excel(path=input$up_scores_plafond_groupes_sliders$datapath),silent=TRUE)
   
   if ("try-error" %in% class(value_sliders)) {
     
     alerte(
       title = "Échec de l'import",
       text = "Le fichier importé doit être un fichier .xlsx",
       type = "error"
     )
   } else {
     if (input$custom_number_classifications  == 8){
       if (all(c("Groupe", "Score_Plafond") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Groupe)) == 0) &
           (sum(is.na(value_sliders$Score_Plafond)) == 0) &
           all(as.character(value_sliders$Groupe)==c("A","B","C","D","E","F","G","H"))) {
         
         ids <- value_sliders$Groupe
         
         length_ids = length(ids)
         
         values <- as.numeric(value_sliders$Score_Plafond)
         for (i in 1:length_ids) {
           updateSliderInput(session=session, inputId = paste0("score_plafond_", length_ids, "_", ids[i]), value = values[i])
         }
       } else {
         alerte(
           title = "Échec de la mise à jour des scores",
           text = "Le fichier importé doit comporter une colonne intitulée 'Groupe' et une colonne intitulée 'Score_Plafond'. Tous les groupes de A à H doivent être mentionnées et avoir un score plafond associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
       }
     }  else if (input$custom_number_classifications  == 9){
       if (all(c("Groupe", "Score_Plafond") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Groupe)) == 0) &
           (sum(is.na(value_sliders$Score_Plafond)) == 0) &
           all(as.character(value_sliders$Groupe)==c("A","B","C","D","E","F","G","H","I"))) {
         
         ids <- value_sliders$Groupe
         
         length_ids = length(ids)
         
         values <- as.numeric(value_sliders$Score_Plafond)
         for (i in 1:length_ids) {
           updateSliderInput(session=session, inputId = paste0("score_plafond_", length_ids, "_", ids[i]), value = values[i])
         }
       } else {
         alerte(
           title = "Échec de la mise à jour des scores",
           text = "Le fichier importé doit comporter une colonne intitulée 'Groupe' et une colonne intitulée 'Score_Plafond'. Tous les groupes de A à I doivent être mentionnées et avoir un score plafond associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
       }
     } else if (input$custom_number_classifications  == 10){
       if (all(c("Groupe", "Score_Plafond") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Groupe)) == 0) &
           (sum(is.na(value_sliders$Score_Plafond)) == 0) &
           all(as.character(value_sliders$Groupe)==c("A","B","C","D","E","F","G","H", "I", "J"))) {
         
         ids <- value_sliders$Groupe
         
         length_ids = length(ids)
         
         values <- as.numeric(value_sliders$Score_Plafond)
         for (i in 1:length_ids) {
           updateSliderInput(session=session, inputId = paste0("score_plafond_", length_ids, "_", ids[i]), value = values[i])
         }
       } else {
         alerte(
           title = "Échec de la mise à jour des scores",
           text = "Le fichier importé doit comporter une colonne intitulée 'Groupe' et une colonne intitulée 'Score_Plafond'. Tous les groupes de A à J doivent être mentionnées et avoir un score plafond associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
       }
     } else if (input$custom_number_classifications  == 11){
       if (all(c("Groupe", "Score_Plafond") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Groupe)) == 0) &
           (sum(is.na(value_sliders$Score_Plafond)) == 0) &
           all(as.character(value_sliders$Groupe)==c("A","B","C","D","E","F","G","H", "I", "J", "K"))) {
         
         ids <- value_sliders$Groupe
         
         length_ids = length(ids)
         
         values <- as.numeric(value_sliders$Score_Plafond)
         for (i in 1:length_ids) {
           updateSliderInput(session=session, inputId = paste0("score_plafond_", length_ids, "_", ids[i]), value = values[i])
         }
       } else {
         alerte(
           title = "Échec de la mise à jour des scores",
           text = "Le fichier importé doit comporter une colonne intitulée 'Groupe' et une colonne intitulée 'Score_Plafond'. Tous les groupes de A à K doivent être mentionnées et avoir un score plafond associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
       }
     } else if (input$custom_number_classifications  == 12){
       if (all(c("Groupe", "Score_Plafond") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Groupe)) == 0) &
           (sum(is.na(value_sliders$Score_Plafond)) == 0) &
           all(as.character(value_sliders$Groupe)==c("A","B","C","D","E","F","G","H", "I", "J", "K", "L",))) {
         
         ids <- value_sliders$Groupe
         
         length_ids = length(ids)
         
         values <- as.numeric(value_sliders$Score_Plafond)
         for (i in 1:length_ids) {
           updateSliderInput(session=session, inputId = paste0("score_plafond_", length_ids, "_", ids[i]), value = values[i])
         }
       } else {
         alerte(
           title = "Échec de la mise à jour des scores",
           text = "Le fichier importé doit comporter une colonne intitulée 'Groupe' et une colonne intitulée 'Score_Plafond'. Tous les groupes de A à L doivent être mentionnées et avoir un score plafond associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
       }
     } else if (input$custom_number_classifications  == 13){
       if (all(c("Groupe", "Score_Plafond") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Groupe)) == 0) &
           (sum(is.na(value_sliders$Score_Plafond)) == 0) &
           all(as.character(value_sliders$Groupe)==c("A","B","C","D","E","F","G","H", "I", "J", "K", "L","M"))) {
         
         ids <- value_sliders$Groupe
         
         length_ids = length(ids)
         
         values <- as.numeric(value_sliders$Score_Plafond)
         for (i in 1:length_ids) {
           updateSliderInput(session=session, inputId = paste0("score_plafond_", length_ids, "_", ids[i]), value = values[i])
         }
       } else {
         alerte(
           title = "Échec de la mise à jour des scores",
           text = "Le fichier importé doit comporter une colonne intitulée 'Groupe' et une colonne intitulée 'Score_Plafond'. Tous les groupes de A à M doivent être mentionnées et avoir un score plafond associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
       }
     } else if (input$custom_number_classifications  == 14){
       if (all(c("Groupe", "Score_Plafond") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Groupe)) == 0) &
           (sum(is.na(value_sliders$Score_Plafond)) == 0) &
           all(as.character(value_sliders$Groupe)==c("A","B","C","D","E","F","G","H", "I", "J", "K","L", "M", "N"))) {
         
         ids <- value_sliders$Groupe
         
         length_ids = length(ids)
         
         values <- as.numeric(value_sliders$Score_Plafond)
         for (i in 1:length_ids) {
           updateSliderInput(session=session, inputId = paste0("score_plafond_", length_ids, "_", ids[i]), value = values[i])
         }
       } else {
         alerte(
           title = "Échec de la mise à jour des scores",
           text = "Le fichier importé doit comporter une colonne intitulée 'Groupe' et une colonne intitulée 'Score_Plafond'. Tous les groupes de A à N doivent être mentionnées et avoir un score plafond associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
       }
     } else if (input$custom_number_classifications  == 15){
       if (all(c("Groupe", "Score_Plafond") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Groupe)) == 0) &
           (sum(is.na(value_sliders$Score_Plafond)) == 0) &
           all(as.character(value_sliders$Groupe)==c("A","B","C","D","E","F","G","H", "I", "J", "K","L", "M", "N", "O"))) {
         
         ids <- value_sliders$Groupe
         
         length_ids = length(ids)
         
         values <- as.numeric(value_sliders$Score_Plafond)
         for (i in 1:length_ids) {
           updateSliderInput(session=session, inputId = paste0("score_plafond_", length_ids, "_", ids[i]), value = values[i])
         }
       } else {
         alerte(
           title = "Échec de la mise à jour des plafonds",
           text = "Le fichier importé doit comporter une colonne intitulée 'Groupe' et une colonne intitulée 'Score_Plafond'. Tous les groupes de A à O doivent être mentionnées et avoir un score plafond associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
       }
     } else if (input$custom_number_classifications  == 16){
       if (all(c("Groupe", "Score_Plafond") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Groupe)) == 0) &
           (sum(is.na(value_sliders$Score_Plafond)) == 0) &
           all(as.character(value_sliders$Groupe)==c("A","B","C","D","E","F","G","H", "I", "J", "K","L", "M", "N", "O", "P"))) {
         
         ids <- value_sliders$Groupe
         
         length_ids = length(ids)
         
         values <- as.numeric(value_sliders$Score_Plafond)
         for (i in 1:length_ids) {
           updateSliderInput(session=session, inputId = paste0("score_plafond_", length_ids, "_", ids[i]), value = values[i])
         }
       } else {
         alerte(
           title = "Échec de la mise à jour des scores",
           text = "Le fichier importé doit comporter une colonne intitulée 'Groupe' et une colonne intitulée 'Score_Plafond'. Tous les groupes de A à P doivent être mentionnées et avoir un score plafond associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
       }
     } else if (input$custom_number_classifications  == 17){
       if (all(c("Groupe", "Score_Plafond") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Groupe)) == 0) &
           (sum(is.na(value_sliders$Score_Plafond)) == 0) &
           all(as.character(value_sliders$Groupe)==c("A","B","C","D","E","F","G","H", "I", "J", "K","L", "M", "N", "O", "P", "Q"))) {
         
         ids <- value_sliders$Groupe
         
         length_ids = length(ids)
         
         values <- as.numeric(value_sliders$Score_Plafond)
         for (i in 1:length_ids) {
           updateSliderInput(session=session, inputId = paste0("score_plafond_", length_ids, "_", ids[i]), value = values[i])
         }
       } else {
         alerte(
           title = "Échec de la mise à jour des scores",
           text = "Le fichier importé doit comporter une colonne intitulée 'Groupe' et une colonne intitulée 'Score_Plafond'. Tous les groupes de A à Q doivent être mentionnées et avoir un score plafond associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
       }
     } else if (input$custom_number_classifications  == 18){
       if (all(c("Groupe", "Score_Plafond") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Groupe)) == 0) &
           (sum(is.na(value_sliders$Score_Plafond)) == 0) &
           all(as.character(value_sliders$Groupe)==c("A","B","C","D","E","F","G","H", "I", "J", "K","L", "M", "N", "O", "P", "Q", "R"))) {
         
         ids <- value_sliders$Groupe
         
         length_ids = length(ids)
         
         values <- as.numeric(value_sliders$Score_Plafond)
         for (i in 1:length_ids) {
           updateSliderInput(session=session, inputId = paste0("score_plafond_", length_ids, "_", ids[i]), value = values[i])
         }
       } else {
         alerte(
           title = "Échec de la mise à jour des scores",
           text = "Le fichier importé doit comporter une colonne intitulée 'Groupe' et une colonne intitulée 'Score_Plafond'. Tous les groupes de A à R doivent être mentionnées et avoir un score plafond associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
       }
     } else if (input$custom_number_classifications  == 19){
       if (all(c("Groupe", "Score_Plafond") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Groupe)) == 0) &
           (sum(is.na(value_sliders$Score_Plafond)) == 0) &
           all(as.character(value_sliders$Groupe)==c("A","B","C","D","E","F","G","H", "I", "J", "K","L", "M", "N", "O", "P", "Q", "R", "S"))) {
         
         ids <- value_sliders$Groupe
         
         length_ids = length(ids)
         
         values <- as.numeric(value_sliders$Score_Plafond)
         for (i in 1:length_ids) {
           updateSliderInput(session=session, inputId = paste0("score_plafond_", length_ids, "_", ids[i]), value = values[i])
         }
       } else {
         alerte(
           title = "Échec de la mise à jour des scores",
           text = "Le fichier importé doit comporter une colonne intitulée 'Groupe' et une colonne intitulée 'Score_Plafond'. Tous les groupes de A à S doivent être mentionnées et avoir un score plafond associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
       }
     } else if (input$custom_number_classifications  == 20){
       if (all(c("Groupe", "Score_Plafond") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Groupe)) == 0) &
           (sum(is.na(value_sliders$Score_Plafond)) == 0) &
           all(as.character(value_sliders$Groupe)==c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T"))) {
         
         ids <- value_sliders$Groupe
         
         length_ids = length(ids)
         
         values <- as.numeric(value_sliders$Score_Plafond)
         for (i in 1:length_ids) {
           updateSliderInput(session=session, inputId = paste0("score_plafond_", length_ids, "_", ids[i]), value = values[i])
         }
       } else {
         alerte(
           title = "Échec de la mise à jour des scores",
           text = "Le fichier importé doit comporter une colonne intitulée 'Groupe' et une colonne intitulée 'Score_Plafond'. Tous les groupes de A à T doivent être mentionnées et avoir un score plafond associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
       }
     } else if (input$custom_number_classifications  == 21) {
       
       
       if (all(c("Groupe", "Score_Plafond") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Groupe)) == 0) &
           (sum(is.na(value_sliders$Score_Plafond)) == 0) &
           all(as.character(value_sliders$Groupe)==c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U"))) {
         
         ids <- value_sliders$Groupe
         
         length_ids = length(ids)
         
         values <- as.numeric(value_sliders$Score_Plafond)
         for (i in 1:length_ids) {
           updateSliderInput(session=session, inputId = paste0("score_plafond_", length_ids, "_", ids[i]), value = values[i])
         }
       } else {
         

         alerte(
           title = "Échec de la mise à jour des scores",
           text = "Le fichier importé doit comporter une colonne intitulée 'Groupe' et une colonne intitulée 'Score_Plafond'. Tous les groupes de A à U doivent être mentionnées et avoir un score plafond associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
       }
     }  else if (input$custom_number_classifications  == 22) {
       
       
       if (all(c("Groupe", "Score_Plafond") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Groupe)) == 0) &
           (sum(is.na(value_sliders$Score_Plafond)) == 0) &
           all(as.character(value_sliders$Groupe)==c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V"))) {
         
         ids <- value_sliders$Groupe
         
         length_ids = length(ids)
         
         values <- as.numeric(value_sliders$Score_Plafond)
         for (i in 1:length_ids) {
           updateSliderInput(session=session, inputId = paste0("score_plafond_", length_ids, "_", ids[i]), value = values[i])
         }
       } else {
         
         
         alerte(
           title = "Échec de la mise à jour des scores",
           text = "Le fichier importé doit comporter une colonne intitulée 'Groupe' et une colonne intitulée 'Score_Plafond'. Tous les groupes de A à V doivent être mentionnées et avoir un score plafond associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
       }
     }  else if (input$custom_number_classifications  == 23) {
       
       
       if (all(c("Groupe", "Score_Plafond") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Groupe)) == 0) &
           (sum(is.na(value_sliders$Score_Plafond)) == 0) &
           all(as.character(value_sliders$Groupe)==c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W"))) {
         
         ids <- value_sliders$Groupe
         
         length_ids = length(ids)
         
         values <- as.numeric(value_sliders$Score_Plafond)
         for (i in 1:length_ids) {
           updateSliderInput(session=session, inputId = paste0("score_plafond_", length_ids, "_", ids[i]), value = values[i])
         }
       } else {
         
         
         alerte(
           title = "Échec de la mise à jour des scores",
           text = "Le fichier importé doit comporter une colonne intitulée 'Groupe' et une colonne intitulée 'Score_Plafond'. Tous les groupes de A à W doivent être mentionnées et avoir un score plafond associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
       }
     }  else if (input$custom_number_classifications  == 24) {
       
       
       if (all(c("Groupe", "Score_Plafond") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Groupe)) == 0) &
           (sum(is.na(value_sliders$Score_Plafond)) == 0) &
           all(as.character(value_sliders$Groupe)==c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X"))) {
         
         ids <- value_sliders$Groupe
         
         length_ids = length(ids)
         
         values <- as.numeric(value_sliders$Score_Plafond)
         for (i in 1:length_ids) {
           updateSliderInput(session=session, inputId = paste0("score_plafond_", length_ids, "_", ids[i]), value = values[i])
         }
       } else {
         
         
         alerte(
           title = "Échec de la mise à jour des scores",
           text = "Le fichier importé doit comporter une colonne intitulée 'Groupe' et une colonne intitulée 'Score_Plafond'. Tous les groupes de A à X doivent être mentionnées et avoir un score plafond associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
       }
     } else {
       
       
       if (all(c("Groupe", "Score_Plafond") %in% names(value_sliders)) &
           (sum(is.na(value_sliders$Groupe)) == 0) &
           (sum(is.na(value_sliders$Score_Plafond)) == 0) &
           all(as.character(value_sliders$Groupe)==c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X","Y"))) {
         
         ids <- value_sliders$Groupe
         
         length_ids = length(ids)
         
         values <- as.numeric(value_sliders$Score_Plafond)
         for (i in 1:length_ids) {
           updateSliderInput(session=session, inputId = paste0("score_plafond_", length_ids, "_", ids[i]), value = values[i])
         }
       } else {
         
         
         alerte(
           title = "Échec de la mise à jour des scores",
           text = "Le fichier importé doit comporter une colonne intitulée 'Groupe' et une colonne intitulée 'Score_Plafond'. Tous les groupes de A à Y doivent être mentionnées et avoir un score plafond associé. Exporter le scénario actuel afin d'observer le format de fichier souhaité.",
           type = "error"
         )
       }
     }
     
   }
   
 }
 
 )
 
 
 
 
 
 ################################################
 
 ### Bouton d'imputation des valeurs de "Toutes catégories" aux catégories spécifiques (dans la section "Majoration selon l'ancienneté")
 
 ################################################
 
 
 observeEvent(input$appliquer_scores_toutes_categories, {
   
   
   ########## Ouvriers
   
   updateSliderInput(session = session, inputId= "Ouvriers_Anc_1_tranches", value = input$Toutes_cat_Anc_1_tranches)
   updateSliderInput(session = session,inputId= "Ouvriers_Anc_2_tranches", value = input$Toutes_cat_Anc_2_tranches)
   updateSliderInput(session = session,inputId= "Ouvriers_Anc_3_tranches", value = input$Toutes_cat_Anc_3_tranches)
   updateSliderInput(session = session,inputId= "Ouvriers_Anc_4_tranches", value = input$Toutes_cat_Anc_4_tranches)
   updateSliderInput(session = session,inputId= "Ouvriers_Anc_5_tranches", value = input$Toutes_cat_Anc_5_tranches)
   updateSliderInput(session = session,inputId= "Ouvriers_Anc_6_tranches", value = input$Toutes_cat_Anc_6_tranches)
   updateSliderInput(session = session,inputId= "Ouvriers_Anc_7_tranches", value = input$Toutes_cat_Anc_7_tranches)
   updateSliderInput(session = session,inputId= "Ouvriers_Anc_8_tranches", value = input$Toutes_cat_Anc_8_tranches)
   updateSliderInput(session = session,inputId= "Ouvriers_Anc_9_tranches", value = input$Toutes_cat_Anc_9_tranches)
   
   
   updateNumericInput(session = session,inputId = "maj_ouvriers_tranche_1", value = input$maj_Toutes_cat_tranche_1)
   updateNumericInput(session = session,inputId = "maj_ouvriers_tranche_2", value = input$maj_Toutes_cat_tranche_2)
   updateNumericInput(session = session,inputId = "maj_ouvriers_tranche_3", value = input$maj_Toutes_cat_tranche_3)
   updateNumericInput(session = session,inputId = "maj_ouvriers_tranche_4", value = input$maj_Toutes_cat_tranche_4)
   updateNumericInput(session = session,inputId = "maj_ouvriers_tranche_5", value = input$maj_Toutes_cat_tranche_5)
   updateNumericInput(session = session,inputId = "maj_ouvriers_tranche_6", value = input$maj_Toutes_cat_tranche_6)
   updateNumericInput(session = session,inputId = "maj_ouvriers_tranche_7", value = input$maj_Toutes_cat_tranche_7)
   updateNumericInput(session = session,inputId = "maj_ouvriers_tranche_8", value = input$maj_Toutes_cat_tranche_8)
   updateNumericInput(session = session,inputId = "maj_ouvriers_tranche_9", value = input$maj_Toutes_cat_tranche_9)
   
   
   ########## Techniciens de maintenance
   
   updateSliderInput(session = session,inputId= "Techniciens_Anc_1_tranches", value = input$Toutes_cat_Anc_1_tranches)
   updateSliderInput(session = session,inputId= "Techniciens_Anc_2_tranches", value = input$Toutes_cat_Anc_2_tranches)
   updateSliderInput(session = session,inputId= "Techniciens_Anc_3_tranches", value = input$Toutes_cat_Anc_3_tranches)
   updateSliderInput(session = session,inputId= "Techniciens_Anc_4_tranches", value = input$Toutes_cat_Anc_4_tranches)
   updateSliderInput(session = session,inputId= "Techniciens_Anc_5_tranches", value = input$Toutes_cat_Anc_5_tranches)
   updateSliderInput(session = session,inputId= "Techniciens_Anc_6_tranches", value = input$Toutes_cat_Anc_6_tranches)
   updateSliderInput(session = session,inputId= "Techniciens_Anc_7_tranches", value = input$Toutes_cat_Anc_7_tranches)
   updateSliderInput(session = session,inputId= "Techniciens_Anc_8_tranches", value = input$Toutes_cat_Anc_8_tranches)
   updateSliderInput(session = session,inputId= "Techniciens_Anc_9_tranches", value = input$Toutes_cat_Anc_9_tranches)
   
   updateNumericInput(session = session,inputId = "maj_Techniciens_tranche_1", value = input$maj_Toutes_cat_tranche_1)
   updateNumericInput(session = session,inputId = "maj_Techniciens_tranche_2", value = input$maj_Toutes_cat_tranche_2)
   updateNumericInput(session = session,inputId = "maj_Techniciens_tranche_3", value = input$maj_Toutes_cat_tranche_3)
   updateNumericInput(session = session,inputId = "maj_Techniciens_tranche_4", value = input$maj_Toutes_cat_tranche_4)
   updateNumericInput(session = session,inputId = "maj_Techniciens_tranche_5", value = input$maj_Toutes_cat_tranche_5)
   updateNumericInput(session = session,inputId = "maj_Techniciens_tranche_6", value = input$maj_Toutes_cat_tranche_6)
   updateNumericInput(session = session,inputId = "maj_Techniciens_tranche_7", value = input$maj_Toutes_cat_tranche_7)
   updateNumericInput(session = session,inputId = "maj_Techniciens_tranche_8", value = input$maj_Toutes_cat_tranche_8)
   updateNumericInput(session = session,inputId = "maj_Techniciens_tranche_9", value = input$maj_Toutes_cat_tranche_9)
   
   
   
   ########## Cadres
   
   updateSliderInput(session = session,inputId= "Cadres_Anc_1_tranches", value = input$Toutes_cat_Anc_1_tranches)
   updateSliderInput(session = session,inputId= "Cadres_Anc_2_tranches", value = input$Toutes_cat_Anc_2_tranches)
   updateSliderInput(session = session,inputId= "Cadres_Anc_3_tranches", value = input$Toutes_cat_Anc_3_tranches)
   updateSliderInput(session = session,inputId= "Cadres_Anc_4_tranches", value = input$Toutes_cat_Anc_4_tranches)
   updateSliderInput(session = session,inputId= "Cadres_Anc_5_tranches", value = input$Toutes_cat_Anc_5_tranches)
   updateSliderInput(session = session,inputId= "Cadres_Anc_6_tranches", value = input$Toutes_cat_Anc_6_tranches)
   updateSliderInput(session = session,inputId= "Cadres_Anc_7_tranches", value = input$Toutes_cat_Anc_7_tranches)
   updateSliderInput(session = session,inputId= "Cadres_Anc_8_tranches", value = input$Toutes_cat_Anc_8_tranches)
   updateSliderInput(session = session,inputId= "Cadres_Anc_9_tranches", value = input$Toutes_cat_Anc_9_tranches)
   
   
   updateNumericInput(session = session,inputId = "maj_Cadres_tranche_1", value = input$maj_Toutes_cat_tranche_1)
   updateNumericInput(session = session,inputId = "maj_Cadres_tranche_2", value = input$maj_Toutes_cat_tranche_2)
   updateNumericInput(session = session,inputId = "maj_Cadres_tranche_3", value = input$maj_Toutes_cat_tranche_3)
   updateNumericInput(session = session,inputId = "maj_Cadres_tranche_4", value = input$maj_Toutes_cat_tranche_4)
   updateNumericInput(session = session,inputId = "maj_Cadres_tranche_5", value = input$maj_Toutes_cat_tranche_5)
   updateNumericInput(session = session,inputId = "maj_Cadres_tranche_6", value = input$maj_Toutes_cat_tranche_6)
   updateNumericInput(session = session,inputId = "maj_Cadres_tranche_7", value = input$maj_Toutes_cat_tranche_7)
   updateNumericInput(session = session,inputId = "maj_Cadres_tranche_8", value = input$maj_Toutes_cat_tranche_8)
   updateNumericInput(session = session,inputId = "maj_Cadres_tranche_9", value = input$maj_Toutes_cat_tranche_9)
   
   
 }
 )
 
 
 
 ################################################
 
 ### Boutons de réinitialisation des valeurs
 
 ################################################
 
 ## Pour les scores des emplois-repère
 
 observeEvent(input$reset_scores_lib_emploi, {
   updateNumericInput(inputId= "score_acheteur_commande_publique", value = score_init_acheteur_commande_publique)
   updateNumericInput(inputId= "score_administrateur_systemes_reseaux", value = score_init_administrateur_systeme_reseau)
   updateNumericInput(inputId= "score_agent_charge_methodes_exploitation", value = score_init_agent_charge_methodes_exploitation)
   updateNumericInput(inputId= "score_agent_manoeuvre", value = score_init_agent_manoeuvre)
   updateNumericInput(inputId= "score_agent_planning", value = score_init_agent_planning)
   updateNumericInput(inputId= "score_agent_surete", value = score_init_agent_surete)
   updateNumericInput(inputId= "score_agent_back_office", value = score_init_agent_back_office)
   updateNumericInput(inputId= "score_aiguilleur", value = score_init_aiguilleur)
   updateNumericInput(inputId= "score_animateur_qualite", value = score_init_animateur_qualite)
   updateNumericInput(inputId= "score_animateur_securite_prevention", value = score_init_animateur_securite_prevention)
   updateNumericInput(inputId= "score_assistant_commercial_marketing", value = score_init_assistant_commercial_marketing)
   updateNumericInput(inputId= "score_assistant_controle_gestion", value = score_init_assistant_controle_gestion)
   updateNumericInput(inputId= "score_assistant_direction", value = score_init_assistant_direction)
   updateNumericInput(inputId= "score_assistant_rh", value = score_init_assistant_rh)
   updateNumericInput(inputId= "score_charge_etudes", value = score_init_charge_etudes)
   updateNumericInput(inputId= "score_charge_communication", value = score_init_charge_communication)
   updateNumericInput(inputId= "score_charge_marketing", value = score_init_charge_marketing)
   updateNumericInput(inputId= "score_charge_recrutement", value = score_init_charge_recrutement)
   updateNumericInput(inputId= "score_charge_web_editorial", value = score_init_charge_web_editorial)
   updateNumericInput(inputId= "score_charge_developpeur", value = score_init_charge_developpeur)
   updateNumericInput(inputId= "score_chef_projet_appel_offres", value = score_init_chef_projet_appel_offre)
   updateNumericInput(inputId= "score_chef_projet_SI", value = score_init_chef_projet_ingenieur_si)
   updateNumericInput(inputId= "score_collecteur_recettes", value = score_init_collecteur_recettes)
   updateNumericInput(inputId= "score_community_manager", value = score_init_community_manager)
   updateNumericInput(inputId= "score_comptable", value = score_init_comptable)
   updateNumericInput(inputId= "score_conducteur_bus", value = score_init_conducteur_bus)
   updateNumericInput(inputId= "score_conducteur_metro", value = score_init_conducteur_metro)
   updateNumericInput(inputId= "score_conducteur_polyvalent_multimodal", value = score_init_conducteur_multimodal)
   updateNumericInput(inputId= "score_conducteur_polyvalent_verificateur_agent_commercial", value = score_init_conducteur_receveur)
   updateNumericInput(inputId= "score_conducteur_pmr_tad", value = score_init_conducteur_mobilite_reduite)
   updateNumericInput(inputId= "score_conducteur_tram", value = score_init_conducteur_receveur)
   updateNumericInput(inputId= "score_conseiller_commercial", value = score_init_conseiller_commercial)
   updateNumericInput(inputId= "score_controleur_gestion", value = score_init_controleur_gestion)
   updateNumericInput(inputId= "score_formateur", value = score_init_formateur)
   updateNumericInput(inputId= "score_gestionnaire_assurance", value = score_init_gestionnaire_assurance)
   updateNumericInput(inputId= "score_gestionnaire_approvisionnement_stock", value = score_init_gestionnaire_approvisionnement_stock)
   updateNumericInput(inputId= "score_gestionnaire_paie", value = score_init_gestionnaire_paie)
   updateNumericInput(inputId= "score_gestionnaire_parc_velo", value = score_init_gestionnaire_parc_velo)
   updateNumericInput(inputId= "score_gestionnaire_contrats", value = score_init_gestionnaire_contrats)
   updateNumericInput(inputId= "score_infographiste", value = score_init_infographiste)
   updateNumericInput(inputId= "score_ingenieur_cybersecurite", value = score_init_ingenieur_cybersecurite)
   updateNumericInput(inputId= "score_ingenieur_maintenance", value = score_init_ingenieur_maintenance)
   updateNumericInput(inputId= "score_ingenieur_methodes_maintenance", value = score_init_ingenieur_methodes)
   updateNumericInput(inputId= "score_ingenieur_financier", value = score_init_ingenieur_financier)
   updateNumericInput(inputId= "score_juriste", value = score_init_juriste)
   updateNumericInput(inputId= "score_manager_conducteurs", value = score_init_manager_conducteur)
   updateNumericInput(inputId= "score_manager_conseiller_commercial", value = score_init_manager_conseiller_commerciaux)
   updateNumericInput(inputId= "score_manager_techniciens_maintenance", value = score_init_manager_technicien_maintenance)
   updateNumericInput(inputId= "score_manager_techniciens_maintenance_parc", value = score_init_manager_technicien_maintenance_parc)
   updateNumericInput(inputId= "score_manager_verificateurs", value = score_init_manager_verificateur)
   updateNumericInput(inputId= "score_manager_equipe_agents_surete", value = score_init_manager_equipe_agent_surete)
   updateNumericInput(inputId= "score_mediateur", value = score_init_mediateur)
   updateNumericInput(inputId= "score_operateur_pc_surete", value = score_init_operateur_pc_surete)
   updateNumericInput(inputId= "score_operateur_technique_informations_voyageurs", value = score_init_operateur_technique_information_voyageur)
   updateNumericInput(inputId= "score_regulateur", value = score_init_regulateur)
   updateNumericInput(inputId= "score_responsable_administrateur_financier", value = score_init_responsable_administratif_financier)
   updateNumericInput(inputId= "score_responsable_approvisionnement_stock", value = score_init_responsable_approvisionnement_gestion_stocks)
   updateNumericInput(inputId= "score_responsable_commercial", value = score_init_responsable_agent_commercial)
   updateNumericInput(inputId= "score_responsable_communication", value = score_init_responsable_communication)
   updateNumericInput(inputId= "score_responsable_comptabilite", value = score_init_responsable_comptabilite)
   updateNumericInput(inputId= "score_responsable_equipe_achat_commande_publique", value = score_init_responsable_equipe_achat_commande_publique)
   updateNumericInput(inputId= "score_responsable_exploitation", value = score_init_responsable_exploitation)
   updateNumericInput(inputId= "score_responsable_formation", value = score_init_responsable_formation)
   updateNumericInput(inputId= "score_responsable_maintenance", value = score_init_responsable_maintenance)
   updateNumericInput(inputId= "score_responsable_production_operation", value = score_init_responsable_production_operation)
   updateNumericInput(inputId= "score_responsable_societe", value = score_init_responsable_societe)
   updateNumericInput(inputId= "score_responsable_SI", value = score_init_responsable_Si)
   updateNumericInput(inputId= "score_responsable_bureau_etudes_methodes_exploitation", value = score_init_responsable_bureau_etudes_methodes)
   updateNumericInput(inputId= "score_responsable_service_client", value = score_init_responsable_service_client)
   updateNumericInput(inputId= "score_responsable_fraude", value = score_init_responsable_fraude)
   updateNumericInput(inputId= "score_responsable_RSE", value = score_init_responsable_RSE)
   updateNumericInput(inputId= "score_responsable_juridique", value = score_init_responsable_juridique)
   updateNumericInput(inputId= "score_responsable_marketing", value = score_init_responsable_marketing)
   updateNumericInput(inputId= "score_responsable_performance_operationnelle", value = score_init_responsable_performance_operationnelle)
   updateNumericInput(inputId= "score_responsable_qualite", value = score_init_responsable_qualite)
   updateNumericInput(inputId= "score_relations_institutionnelles", value = score_init_responsable_relations_institutionnelles)
   updateNumericInput(inputId= "score_responsable_rh", value = score_init_responsable_rh)
   updateNumericInput(inputId= "score_responsable_HSE", value = score_init_responsable_HSE)
   updateNumericInput(inputId= "score_responsable_secteur", value = score_init_responsable_secteur)
   updateNumericInput(inputId= "score_responsable_securite_prevention", value = score_init_responsable_securite_prevention)
   updateNumericInput(inputId= "score_responsable_appels_offre", value = score_init_responsable_appel_offre)
   updateNumericInput(inputId= "score_technicien_maintenance_parc", value = score_init_technicien_maintenance_parc)
   updateNumericInput(inputId= "score_technicien_exploitation", value = score_init_technicien_exploitation)
   updateNumericInput(inputId= "score_technicien_maintenance", value = score_init_technicien_maintenance)
   updateNumericInput(inputId= "score_technicien_methodes_maintenance", value = score_init_technicien_methode)
   updateNumericInput(inputId= "score_technicien_intervention_systemes_automatiques_autonomes", value = score_init_technicien_intervention_systeme_automatique_autonome)
   updateNumericInput(inputId= "score_technicien_superieur_exploitation", value = score_init_technicien_exploitation)
   updateNumericInput(inputId= "score_verificateur", value = score_init_verificateur)
 }
 )
 
 observeEvent(input$reset_plafonds_groupes, {
   
   if (input$custom_number_classifications <= 8){
     updateNumericInput(session = session,inputId= "score_plafond_8_A", value = plafond_init_8_A)
     updateNumericInput(session = session,inputId= "score_plafond_8_B", value = plafond_init_8_B)
     updateNumericInput(session = session,inputId= "score_plafond_8_C", value = plafond_init_8_C)
     updateNumericInput(session = session,inputId= "score_plafond_8_D", value = plafond_init_8_D)
     updateNumericInput(session = session,inputId= "score_plafond_8_E", value = plafond_init_8_E)
     updateNumericInput(session = session,inputId= "score_plafond_8_F", value = plafond_init_8_F)
     updateNumericInput(session = session,inputId= "score_plafond_8_G", value = plafond_init_8_G)
     updateNumericInput(session = session,inputId= "score_plafond_8_H", value = plafond_init_8_H)
   } else if (input$custom_number_classifications == 9){
     updateNumericInput(session = session,inputId= "score_plafond_9_A", value = plafond_init_9_A)
     updateNumericInput(session = session,inputId= "score_plafond_9_B", value = plafond_init_9_B)
     updateNumericInput(session = session,inputId= "score_plafond_9_C", value = plafond_init_9_C)
     updateNumericInput(session = session,inputId= "score_plafond_9_D", value = plafond_init_9_D)
     updateNumericInput(session = session,inputId= "score_plafond_9_E", value = plafond_init_9_E)
     updateNumericInput(session = session,inputId= "score_plafond_9_F", value = plafond_init_9_F)
     updateNumericInput(session = session,inputId= "score_plafond_9_G", value = plafond_init_9_G)
     updateNumericInput(session = session,inputId= "score_plafond_9_H", value = plafond_init_9_H)
     updateNumericInput(session = session,inputId= "score_plafond_9_I", value = plafond_init_9_I)
   } else if (input$custom_number_classifications == 10){
     updateNumericInput(session = session,inputId= "score_plafond_10_A", value = plafond_init_10_A)
     updateNumericInput(session = session,inputId= "score_plafond_10_B", value = plafond_init_10_B)
     updateNumericInput(session = session,inputId= "score_plafond_10_C", value = plafond_init_10_C)
     updateNumericInput(session = session,inputId= "score_plafond_10_D", value = plafond_init_10_D)
     updateNumericInput(session = session,inputId= "score_plafond_10_E", value = plafond_init_10_E)
     updateNumericInput(session = session,inputId= "score_plafond_10_F", value = plafond_init_10_F)
     updateNumericInput(session = session,inputId= "score_plafond_10_G", value = plafond_init_10_G)
     updateNumericInput(session = session,inputId= "score_plafond_10_H", value = plafond_init_10_H)
     updateNumericInput(session = session,inputId= "score_plafond_10_I", value = plafond_init_10_I)
     updateNumericInput(session = session,inputId= "score_plafond_10_J", value = plafond_init_10_J)
   } else if (input$custom_number_classifications == 11){
     updateNumericInput(session = session,inputId= "score_plafond_11_A", value = plafond_init_11_A)
     updateNumericInput(session = session,inputId= "score_plafond_11_B", value = plafond_init_11_B)
     updateNumericInput(session = session,inputId= "score_plafond_11_C", value = plafond_init_11_C)
     updateNumericInput(session = session,inputId= "score_plafond_11_D", value = plafond_init_11_D)
     updateNumericInput(session = session,inputId= "score_plafond_11_E", value = plafond_init_11_E)
     updateNumericInput(session = session,inputId= "score_plafond_11_F", value = plafond_init_11_F)
     updateNumericInput(session = session,inputId= "score_plafond_11_G", value = plafond_init_11_G)
     updateNumericInput(session = session,inputId= "score_plafond_11_H", value = plafond_init_11_H)
     updateNumericInput(session = session,inputId= "score_plafond_11_I", value = plafond_init_11_I)
     updateNumericInput(session = session,inputId= "score_plafond_11_J", value = plafond_init_11_J)
     updateNumericInput(session = session,inputId= "score_plafond_11_K", value = plafond_init_11_K)
   } else if (input$custom_number_classifications == 12){
     updateNumericInput(session = session,inputId= "score_plafond_12_A", value = plafond_init_12_A)
     updateNumericInput(session = session,inputId= "score_plafond_12_B", value = plafond_init_12_B)
     updateNumericInput(session = session,inputId= "score_plafond_12_C", value = plafond_init_12_C)
     updateNumericInput(session = session,inputId= "score_plafond_12_D", value = plafond_init_12_D)
     updateNumericInput(session = session,inputId= "score_plafond_12_E", value = plafond_init_12_E)
     updateNumericInput(session = session,inputId= "score_plafond_12_F", value = plafond_init_12_F)
     updateNumericInput(session = session,inputId= "score_plafond_12_G", value = plafond_init_12_G)
     updateNumericInput(session = session,inputId= "score_plafond_12_H", value = plafond_init_12_H)
     updateNumericInput(session = session,inputId= "score_plafond_12_I", value = plafond_init_12_I)
     updateNumericInput(session = session,inputId= "score_plafond_12_J", value = plafond_init_12_J)
     updateNumericInput(session = session,inputId= "score_plafond_12_K", value = plafond_init_12_K)
     updateNumericInput(session = session,inputId= "score_plafond_12_L", value = plafond_init_12_L)
   } else if (input$custom_number_classifications == 13){
     updateNumericInput(session = session,inputId= "score_plafond_13_A", value = plafond_init_13_A)
     updateNumericInput(session = session,inputId= "score_plafond_13_B", value = plafond_init_13_B)
     updateNumericInput(session = session,inputId= "score_plafond_13_C", value = plafond_init_13_C)
     updateNumericInput(session = session,inputId= "score_plafond_13_D", value = plafond_init_13_D)
     updateNumericInput(session = session,inputId= "score_plafond_13_E", value = plafond_init_13_E)
     updateNumericInput(session = session,inputId= "score_plafond_13_F", value = plafond_init_13_F)
     updateNumericInput(session = session,inputId= "score_plafond_13_G", value = plafond_init_13_G)
     updateNumericInput(session = session,inputId= "score_plafond_13_H", value = plafond_init_13_H)
     updateNumericInput(session = session,inputId= "score_plafond_13_I", value = plafond_init_13_I)
     updateNumericInput(session = session,inputId= "score_plafond_13_J", value = plafond_init_13_J)
     updateNumericInput(session = session,inputId= "score_plafond_13_K", value = plafond_init_13_K)
     updateNumericInput(session = session,inputId= "score_plafond_13_L", value = plafond_init_13_L)
     updateNumericInput(session = session,inputId= "score_plafond_13_M", value = plafond_init_13_M)
   } else if (input$custom_number_classifications == 14){
     updateNumericInput(session = session,inputId= "score_plafond_14_A", value = plafond_init_14_A)
     updateNumericInput(session = session,inputId= "score_plafond_14_B", value = plafond_init_14_B)
     updateNumericInput(session = session,inputId= "score_plafond_14_C", value = plafond_init_14_C)
     updateNumericInput(session = session,inputId= "score_plafond_14_D", value = plafond_init_14_D)
     updateNumericInput(session = session,inputId= "score_plafond_14_E", value = plafond_init_14_E)
     updateNumericInput(session = session,inputId= "score_plafond_14_F", value = plafond_init_14_F)
     updateNumericInput(session = session,inputId= "score_plafond_14_G", value = plafond_init_14_G)
     updateNumericInput(session = session,inputId= "score_plafond_14_H", value = plafond_init_14_H)
     updateNumericInput(session = session,inputId= "score_plafond_14_I", value = plafond_init_14_I)
     updateNumericInput(session = session,inputId= "score_plafond_14_J", value = plafond_init_14_J)
     updateNumericInput(session = session,inputId= "score_plafond_14_K", value = plafond_init_14_K)
     updateNumericInput(session = session,inputId= "score_plafond_14_L", value = plafond_init_14_L)
     updateNumericInput(session = session,inputId= "score_plafond_14_M", value = plafond_init_14_M)
     updateNumericInput(session = session,inputId= "score_plafond_14_N", value = plafond_init_14_N)
   } else if (input$custom_number_classifications == 15){
     updateNumericInput(session = session,inputId= "score_plafond_15_A", value = plafond_init_15_A)
     updateNumericInput(session = session,inputId= "score_plafond_15_B", value = plafond_init_15_B)
     updateNumericInput(session = session,inputId= "score_plafond_15_C", value = plafond_init_15_C)
     updateNumericInput(session = session,inputId= "score_plafond_15_D", value = plafond_init_15_D)
     updateNumericInput(session = session,inputId= "score_plafond_15_E", value = plafond_init_15_E)
     updateNumericInput(session = session,inputId= "score_plafond_15_F", value = plafond_init_15_F)
     updateNumericInput(session = session,inputId= "score_plafond_15_G", value = plafond_init_15_G)
     updateNumericInput(session = session,inputId= "score_plafond_15_H", value = plafond_init_15_H)
     updateNumericInput(session = session,inputId= "score_plafond_15_I", value = plafond_init_15_I)
     updateNumericInput(session = session,inputId= "score_plafond_15_J", value = plafond_init_15_J)
     updateNumericInput(session = session,inputId= "score_plafond_15_K", value = plafond_init_15_K)
     updateNumericInput(session = session,inputId= "score_plafond_15_L", value = plafond_init_15_L)
     updateNumericInput(session = session,inputId= "score_plafond_15_M", value = plafond_init_15_M)
     updateNumericInput(session = session,inputId= "score_plafond_15_N", value = plafond_init_15_N)
     updateNumericInput(session = session,inputId= "score_plafond_15_O", value = plafond_init_15_O)
   } else if (input$custom_number_classifications == 16){
     updateNumericInput(session = session,inputId= "score_plafond_16_A", value = plafond_init_16_A)
     updateNumericInput(session = session,inputId= "score_plafond_16_B", value = plafond_init_16_B)
     updateNumericInput(session = session,inputId= "score_plafond_16_C", value = plafond_init_16_C)
     updateNumericInput(session = session,inputId= "score_plafond_16_D", value = plafond_init_16_D)
     updateNumericInput(session = session,inputId= "score_plafond_16_E", value = plafond_init_16_E)
     updateNumericInput(session = session,inputId= "score_plafond_16_F", value = plafond_init_16_F)
     updateNumericInput(session = session,inputId= "score_plafond_16_G", value = plafond_init_16_G)
     updateNumericInput(session = session,inputId= "score_plafond_16_H", value = plafond_init_16_H)
     updateNumericInput(session = session,inputId= "score_plafond_16_I", value = plafond_init_16_I)
     updateNumericInput(session = session,inputId= "score_plafond_16_J", value = plafond_init_16_J)
     updateNumericInput(session = session,inputId= "score_plafond_16_K", value = plafond_init_16_K)
     updateNumericInput(session = session,inputId= "score_plafond_16_L", value = plafond_init_16_L)
     updateNumericInput(session = session,inputId= "score_plafond_16_M", value = plafond_init_16_M)
     updateNumericInput(session = session,inputId= "score_plafond_16_N", value = plafond_init_16_N)
     updateNumericInput(session = session,inputId= "score_plafond_16_O", value = plafond_init_16_O)
     updateNumericInput(session = session,inputId= "score_plafond_16_P", value = plafond_init_16_P)
   } else if (input$custom_number_classifications == 17){
     updateNumericInput(session = session,inputId= "score_plafond_17_A", value = plafond_init_17_A)
     updateNumericInput(session = session,inputId= "score_plafond_17_B", value = plafond_init_17_B)
     updateNumericInput(session = session,inputId= "score_plafond_17_C", value = plafond_init_17_C)
     updateNumericInput(session = session,inputId= "score_plafond_17_D", value = plafond_init_17_D)
     updateNumericInput(session = session,inputId= "score_plafond_17_E", value = plafond_init_17_E)
     updateNumericInput(session = session,inputId= "score_plafond_17_F", value = plafond_init_17_F)
     updateNumericInput(session = session,inputId= "score_plafond_17_G", value = plafond_init_17_G)
     updateNumericInput(session = session,inputId= "score_plafond_17_H", value = plafond_init_17_H)
     updateNumericInput(session = session,inputId= "score_plafond_17_I", value = plafond_init_17_I)
     updateNumericInput(session = session,inputId= "score_plafond_17_J", value = plafond_init_17_J)
     updateNumericInput(session = session,inputId= "score_plafond_17_K", value = plafond_init_17_K)
     updateNumericInput(session = session,inputId= "score_plafond_17_L", value = plafond_init_17_L)
     updateNumericInput(session = session,inputId= "score_plafond_17_M", value = plafond_init_17_M)
     updateNumericInput(session = session,inputId= "score_plafond_17_N", value = plafond_init_17_N)
     updateNumericInput(session = session,inputId= "score_plafond_17_O", value = plafond_init_17_O)
     updateNumericInput(session = session,inputId= "score_plafond_17_P", value = plafond_init_17_P)
     updateNumericInput(session = session,inputId= "score_plafond_17_Q", value = plafond_init_17_Q)
   }  else if (input$custom_number_classifications == 18){
     updateNumericInput(session = session,inputId= "score_plafond_18_A", value = plafond_init_18_A)
     updateNumericInput(session = session,inputId= "score_plafond_18_B", value = plafond_init_18_B)
     updateNumericInput(session = session,inputId= "score_plafond_18_C", value = plafond_init_18_C)
     updateNumericInput(session = session,inputId= "score_plafond_18_D", value = plafond_init_18_D)
     updateNumericInput(session = session,inputId= "score_plafond_18_E", value = plafond_init_18_E)
     updateNumericInput(session = session,inputId= "score_plafond_18_F", value = plafond_init_18_F)
     updateNumericInput(session = session,inputId= "score_plafond_18_G", value = plafond_init_18_G)
     updateNumericInput(session = session,inputId= "score_plafond_18_H", value = plafond_init_18_H)
     updateNumericInput(session = session,inputId= "score_plafond_18_I", value = plafond_init_18_I)
     updateNumericInput(session = session,inputId= "score_plafond_18_J", value = plafond_init_18_J)
     updateNumericInput(session = session,inputId= "score_plafond_18_K", value = plafond_init_18_K)
     updateNumericInput(session = session,inputId= "score_plafond_18_L", value = plafond_init_18_L)
     updateNumericInput(session = session,inputId= "score_plafond_18_M", value = plafond_init_18_M)
     updateNumericInput(session = session,inputId= "score_plafond_18_N", value = plafond_init_18_N)
     updateNumericInput(session = session,inputId= "score_plafond_18_O", value = plafond_init_18_O)
     updateNumericInput(session = session,inputId= "score_plafond_18_P", value = plafond_init_18_P)
     updateNumericInput(session = session,inputId= "score_plafond_18_Q", value = plafond_init_18_Q)
     updateNumericInput(session = session,inputId= "score_plafond_18_R", value = plafond_init_18_R)
   } else if (input$custom_number_classifications == 19){
     updateNumericInput(session = session,inputId= "score_plafond_19_A", value = plafond_init_19_A)
     updateNumericInput(session = session,inputId= "score_plafond_19_B", value = plafond_init_19_B)
     updateNumericInput(session = session,inputId= "score_plafond_19_C", value = plafond_init_19_C)
     updateNumericInput(session = session,inputId= "score_plafond_19_D", value = plafond_init_19_D)
     updateNumericInput(session = session,inputId= "score_plafond_19_E", value = plafond_init_19_E)
     updateNumericInput(session = session,inputId= "score_plafond_19_F", value = plafond_init_19_F)
     updateNumericInput(session = session,inputId= "score_plafond_19_G", value = plafond_init_19_G)
     updateNumericInput(session = session,inputId= "score_plafond_19_H", value = plafond_init_19_H)
     updateNumericInput(session = session,inputId= "score_plafond_19_I", value = plafond_init_19_I)
     updateNumericInput(session = session,inputId= "score_plafond_19_J", value = plafond_init_19_J)
     updateNumericInput(session = session,inputId= "score_plafond_19_K", value = plafond_init_19_K)
     updateNumericInput(session = session,inputId= "score_plafond_19_L", value = plafond_init_19_L)
     updateNumericInput(session = session,inputId= "score_plafond_19_M", value = plafond_init_19_M)
     updateNumericInput(session = session,inputId= "score_plafond_19_N", value = plafond_init_19_N)
     updateNumericInput(session = session,inputId= "score_plafond_19_O", value = plafond_init_19_O)
     updateNumericInput(session = session,inputId= "score_plafond_19_P", value = plafond_init_19_P)
     updateNumericInput(session = session,inputId= "score_plafond_19_Q", value = plafond_init_19_Q)
     updateNumericInput(session = session,inputId= "score_plafond_19_R", value = plafond_init_19_R)
     updateNumericInput(session = session,inputId= "score_plafond_19_S", value = plafond_init_19_S)
   } else if (input$custom_number_classifications == 20){
     updateNumericInput(session = session,inputId= "score_plafond_20_A", value = plafond_init_20_A)
     updateNumericInput(session = session,inputId= "score_plafond_20_B", value = plafond_init_20_B)
     updateNumericInput(session = session,inputId= "score_plafond_20_C", value = plafond_init_20_C)
     updateNumericInput(session = session,inputId= "score_plafond_20_D", value = plafond_init_20_D)
     updateNumericInput(session = session,inputId= "score_plafond_20_E", value = plafond_init_20_E)
     updateNumericInput(session = session,inputId= "score_plafond_20_F", value = plafond_init_20_F)
     updateNumericInput(session = session,inputId= "score_plafond_20_G", value = plafond_init_20_G)
     updateNumericInput(session = session,inputId= "score_plafond_20_H", value = plafond_init_20_H)
     updateNumericInput(session = session,inputId= "score_plafond_20_I", value = plafond_init_20_I)
     updateNumericInput(session = session,inputId= "score_plafond_20_J", value = plafond_init_20_J)
     updateNumericInput(session = session,inputId= "score_plafond_20_K", value = plafond_init_20_K)
     updateNumericInput(session = session,inputId= "score_plafond_20_L", value = plafond_init_20_L)
     updateNumericInput(session = session,inputId= "score_plafond_20_M", value = plafond_init_20_M)
     updateNumericInput(session = session,inputId= "score_plafond_20_N", value = plafond_init_20_N)
     updateNumericInput(session = session,inputId= "score_plafond_20_O", value = plafond_init_20_O)
     updateNumericInput(session = session,inputId= "score_plafond_20_P", value = plafond_init_20_P)
     updateNumericInput(session = session,inputId= "score_plafond_20_Q", value = plafond_init_20_Q)
     updateNumericInput(session = session,inputId= "score_plafond_20_R", value = plafond_init_20_R)
     updateNumericInput(session = session,inputId= "score_plafond_20_S", value = plafond_init_20_S)
     updateNumericInput(session = session,inputId= "score_plafond_20_T", value = plafond_init_20_T)
   } else if (input$custom_number_classifications == 21){
     updateNumericInput(session = session,inputId= "score_plafond_21_A", value = plafond_init_21_A)
     updateNumericInput(session = session,inputId= "score_plafond_21_B", value = plafond_init_21_B)
     updateNumericInput(session = session,inputId= "score_plafond_21_C", value = plafond_init_21_C)
     updateNumericInput(session = session,inputId= "score_plafond_21_D", value = plafond_init_21_D)
     updateNumericInput(session = session,inputId= "score_plafond_21_E", value = plafond_init_21_E)
     updateNumericInput(session = session,inputId= "score_plafond_21_F", value = plafond_init_21_F)
     updateNumericInput(session = session,inputId= "score_plafond_21_G", value = plafond_init_21_G)
     updateNumericInput(session = session,inputId= "score_plafond_21_H", value = plafond_init_21_H)
     updateNumericInput(session = session,inputId= "score_plafond_21_I", value = plafond_init_21_I)
     updateNumericInput(session = session,inputId= "score_plafond_21_J", value = plafond_init_21_J)
     updateNumericInput(session = session,inputId= "score_plafond_21_K", value = plafond_init_21_K)
     updateNumericInput(session = session,inputId= "score_plafond_21_L", value = plafond_init_21_L)
     updateNumericInput(session = session,inputId= "score_plafond_21_M", value = plafond_init_21_M)
     updateNumericInput(session = session,inputId= "score_plafond_21_N", value = plafond_init_21_N)
     updateNumericInput(session = session,inputId= "score_plafond_21_O", value = plafond_init_21_O)
     updateNumericInput(session = session,inputId= "score_plafond_21_P", value = plafond_init_21_P)
     updateNumericInput(session = session,inputId= "score_plafond_21_Q", value = plafond_init_21_Q)
     updateNumericInput(session = session,inputId= "score_plafond_21_R", value = plafond_init_21_R)
     updateNumericInput(session = session,inputId= "score_plafond_21_S", value = plafond_init_21_S)
     updateNumericInput(session = session,inputId= "score_plafond_21_T", value = plafond_init_21_T)
     updateNumericInput(session = session,inputId= "score_plafond_21_U", value = plafond_init_21_U)
   } else if (input$custom_number_classifications == 22){
     updateNumericInput(session = session,inputId= "score_plafond_22_A", value = plafond_init_22_A)
     updateNumericInput(session = session,inputId= "score_plafond_22_B", value = plafond_init_22_B)
     updateNumericInput(session = session,inputId= "score_plafond_22_C", value = plafond_init_22_C)
     updateNumericInput(session = session,inputId= "score_plafond_22_D", value = plafond_init_22_D)
     updateNumericInput(session = session,inputId= "score_plafond_22_E", value = plafond_init_22_E)
     updateNumericInput(session = session,inputId= "score_plafond_22_F", value = plafond_init_22_F)
     updateNumericInput(session = session,inputId= "score_plafond_22_G", value = plafond_init_22_G)
     updateNumericInput(session = session,inputId= "score_plafond_22_H", value = plafond_init_22_H)
     updateNumericInput(session = session,inputId= "score_plafond_22_I", value = plafond_init_22_I)
     updateNumericInput(session = session,inputId= "score_plafond_22_J", value = plafond_init_22_J)
     updateNumericInput(session = session,inputId= "score_plafond_22_K", value = plafond_init_22_K)
     updateNumericInput(session = session,inputId= "score_plafond_22_L", value = plafond_init_22_L)
     updateNumericInput(session = session,inputId= "score_plafond_22_M", value = plafond_init_22_M)
     updateNumericInput(session = session,inputId= "score_plafond_22_N", value = plafond_init_22_N)
     updateNumericInput(session = session,inputId= "score_plafond_22_O", value = plafond_init_22_O)
     updateNumericInput(session = session,inputId= "score_plafond_22_P", value = plafond_init_22_P)
     updateNumericInput(session = session,inputId= "score_plafond_22_Q", value = plafond_init_22_Q)
     updateNumericInput(session = session,inputId= "score_plafond_22_R", value = plafond_init_22_R)
     updateNumericInput(session = session,inputId= "score_plafond_22_S", value = plafond_init_22_S)
     updateNumericInput(session = session,inputId= "score_plafond_22_T", value = plafond_init_22_T)
     updateNumericInput(session = session,inputId= "score_plafond_22_U", value = plafond_init_22_U)
     updateNumericInput(session = session,inputId= "score_plafond_22_V", value = plafond_init_22_V)
   } else if (input$custom_number_classifications == 23){
     updateNumericInput(session = session,inputId= "score_plafond_23_A", value = plafond_init_23_A)
     updateNumericInput(session = session,inputId= "score_plafond_23_B", value = plafond_init_23_B)
     updateNumericInput(session = session,inputId= "score_plafond_23_C", value = plafond_init_23_C)
     updateNumericInput(session = session,inputId= "score_plafond_23_D", value = plafond_init_23_D)
     updateNumericInput(session = session,inputId= "score_plafond_23_E", value = plafond_init_23_E)
     updateNumericInput(session = session,inputId= "score_plafond_23_F", value = plafond_init_23_F)
     updateNumericInput(session = session,inputId= "score_plafond_23_G", value = plafond_init_23_G)
     updateNumericInput(session = session,inputId= "score_plafond_23_H", value = plafond_init_23_H)
     updateNumericInput(session = session,inputId= "score_plafond_23_I", value = plafond_init_23_I)
     updateNumericInput(session = session,inputId= "score_plafond_23_J", value = plafond_init_23_J)
     updateNumericInput(session = session,inputId= "score_plafond_23_K", value = plafond_init_23_K)
     updateNumericInput(session = session,inputId= "score_plafond_23_L", value = plafond_init_23_L)
     updateNumericInput(session = session,inputId= "score_plafond_23_M", value = plafond_init_23_M)
     updateNumericInput(session = session,inputId= "score_plafond_23_N", value = plafond_init_23_N)
     updateNumericInput(session = session,inputId= "score_plafond_23_O", value = plafond_init_23_O)
     updateNumericInput(session = session,inputId= "score_plafond_23_P", value = plafond_init_23_P)
     updateNumericInput(session = session,inputId= "score_plafond_23_Q", value = plafond_init_23_Q)
     updateNumericInput(session = session,inputId= "score_plafond_23_R", value = plafond_init_23_R)
     updateNumericInput(session = session,inputId= "score_plafond_23_S", value = plafond_init_23_S)
     updateNumericInput(session = session,inputId= "score_plafond_23_T", value = plafond_init_23_T)
     updateNumericInput(session = session,inputId= "score_plafond_23_U", value = plafond_init_23_U)
     updateNumericInput(session = session,inputId= "score_plafond_23_V", value = plafond_init_23_V)
     updateNumericInput(session = session,inputId= "score_plafond_23_W", value = plafond_init_23_W)
   } else if (input$custom_number_classifications == 24){
     updateNumericInput(session = session,inputId= "score_plafond_24_A", value = plafond_init_24_A)
     updateNumericInput(session = session,inputId= "score_plafond_24_B", value = plafond_init_24_B)
     updateNumericInput(session = session,inputId= "score_plafond_24_C", value = plafond_init_24_C)
     updateNumericInput(session = session,inputId= "score_plafond_24_D", value = plafond_init_24_D)
     updateNumericInput(session = session,inputId= "score_plafond_24_E", value = plafond_init_24_E)
     updateNumericInput(session = session,inputId= "score_plafond_24_F", value = plafond_init_24_F)
     updateNumericInput(session = session,inputId= "score_plafond_24_G", value = plafond_init_24_G)
     updateNumericInput(session = session,inputId= "score_plafond_24_H", value = plafond_init_24_H)
     updateNumericInput(session = session,inputId= "score_plafond_24_I", value = plafond_init_24_I)
     updateNumericInput(session = session,inputId= "score_plafond_24_J", value = plafond_init_24_J)
     updateNumericInput(session = session,inputId= "score_plafond_24_K", value = plafond_init_24_K)
     updateNumericInput(session = session,inputId= "score_plafond_24_L", value = plafond_init_24_L)
     updateNumericInput(session = session,inputId= "score_plafond_24_M", value = plafond_init_24_M)
     updateNumericInput(session = session,inputId= "score_plafond_24_N", value = plafond_init_24_N)
     updateNumericInput(session = session,inputId= "score_plafond_24_O", value = plafond_init_24_O)
     updateNumericInput(session = session,inputId= "score_plafond_24_P", value = plafond_init_24_P)
     updateNumericInput(session = session,inputId= "score_plafond_24_Q", value = plafond_init_24_Q)
     updateNumericInput(session = session,inputId= "score_plafond_24_R", value = plafond_init_24_R)
     updateNumericInput(session = session,inputId= "score_plafond_24_S", value = plafond_init_24_S)
     updateNumericInput(session = session,inputId= "score_plafond_24_T", value = plafond_init_24_T)
     updateNumericInput(session = session,inputId= "score_plafond_24_U", value = plafond_init_24_U)
     updateNumericInput(session = session,inputId= "score_plafond_24_V", value = plafond_init_24_V)
     updateNumericInput(session = session,inputId= "score_plafond_24_W", value = plafond_init_24_W)
     updateNumericInput(session = session,inputId= "score_plafond_24_X", value = plafond_init_24_X)
   } else {
     updateNumericInput(session = session,inputId= "score_plafond_25_A", value = plafond_init_25_A)
     updateNumericInput(session = session,inputId= "score_plafond_25_B", value = plafond_init_25_B)
     updateNumericInput(session = session,inputId= "score_plafond_25_C", value = plafond_init_25_C)
     updateNumericInput(session = session,inputId= "score_plafond_25_D", value = plafond_init_25_D)
     updateNumericInput(session = session,inputId= "score_plafond_25_E", value = plafond_init_25_E)
     updateNumericInput(session = session,inputId= "score_plafond_25_F", value = plafond_init_25_F)
     updateNumericInput(session = session,inputId= "score_plafond_25_G", value = plafond_init_25_G)
     updateNumericInput(session = session,inputId= "score_plafond_25_H", value = plafond_init_25_H)
     updateNumericInput(session = session,inputId= "score_plafond_25_I", value = plafond_init_25_I)
     updateNumericInput(session = session,inputId= "score_plafond_25_J", value = plafond_init_25_J)
     updateNumericInput(session = session,inputId= "score_plafond_25_K", value = plafond_init_25_K)
     updateNumericInput(session = session,inputId= "score_plafond_25_L", value = plafond_init_25_L)
     updateNumericInput(session = session,inputId= "score_plafond_25_M", value = plafond_init_25_M)
     updateNumericInput(session = session,inputId= "score_plafond_25_N", value = plafond_init_25_N)
     updateNumericInput(session = session,inputId= "score_plafond_25_O", value = plafond_init_25_O)
     updateNumericInput(session = session,inputId= "score_plafond_25_P", value = plafond_init_25_P)
     updateNumericInput(session = session,inputId= "score_plafond_25_Q", value = plafond_init_25_Q)
     updateNumericInput(session = session,inputId= "score_plafond_25_R", value = plafond_init_25_R)
     updateNumericInput(session = session,inputId= "score_plafond_25_S", value = plafond_init_25_S)
     updateNumericInput(session = session,inputId= "score_plafond_25_T", value = plafond_init_25_T)
     updateNumericInput(session = session,inputId= "score_plafond_25_U", value = plafond_init_25_U)
     updateNumericInput(session = session,inputId= "score_plafond_25_V", value = plafond_init_25_V)
     updateNumericInput(session = session,inputId= "score_plafond_25_W", value = plafond_init_25_W)
     updateNumericInput(session = session,inputId= "score_plafond_25_X", value = plafond_init_25_X)
     updateNumericInput(session = session,inputId= "score_plafond_25_Y", value = plafond_init_25_Y)
   }
   
 }
 )
 
 ################################################
 ############# Reset valeurs des majorations d'ancienneté par catégorie
 ################################################
 
 ############## Ouvriers
 observeEvent(input$reset_workers_values, {
   updateSliderInput(session = session, inputId= "Ouvriers_Anc_1_tranches", value = c(1, 2))
   updateSliderInput(session = session,inputId= "Ouvriers_Anc_2_tranches", value = c(3, 4))
   updateSliderInput(session = session,inputId= "Ouvriers_Anc_3_tranches", value = c(5, 6))
   updateSliderInput(session = session,inputId= "Ouvriers_Anc_4_tranches", value = c(7, 8))
   updateSliderInput(session = session,inputId= "Ouvriers_Anc_5_tranches", value = c(9, 10))
   updateSliderInput(session = session,inputId= "Ouvriers_Anc_6_tranches", value = c(11, 12))
   updateSliderInput(session = session,inputId= "Ouvriers_Anc_7_tranches", value = c(13, 14))
   updateSliderInput(session = session,inputId= "Ouvriers_Anc_8_tranches", value = c(15, 16))
   updateSliderInput(session = session,inputId= "Ouvriers_Anc_9_tranches", value = c(17, 45))
   
   
   updateNumericInput(session = session,inputId = "maj_ouvriers_tranche_1", value = 6)
   updateNumericInput(session = session,inputId = "maj_ouvriers_tranche_2", value = 7)
   updateNumericInput(session = session,inputId = "maj_ouvriers_tranche_3", value = 8)
   updateNumericInput(session = session,inputId = "maj_ouvriers_tranche_4", value = 9)
   updateNumericInput(session = session,inputId = "maj_ouvriers_tranche_5", value = 10)
   updateNumericInput(session = session,inputId = "maj_ouvriers_tranche_6", value = 11)
   updateNumericInput(session = session,inputId = "maj_ouvriers_tranche_7", value = 12)
   updateNumericInput(session = session,inputId = "maj_ouvriers_tranche_8", value = 13)
   updateNumericInput(session = session,inputId = "maj_ouvriers_tranche_9", value = 14)
 }
 )
 
 ############## Techniciens
 observeEvent(input$reset_technicians_values, {
   updateSliderInput(session = session, inputId= "Techniciens_Anc_1_tranches", value = c(1, 2))
   updateSliderInput(session = session,inputId= "Techniciens_Anc_2_tranches", value = c(3, 4))
   updateSliderInput(session = session,inputId= "Techniciens_Anc_3_tranches", value = c(5, 6))
   updateSliderInput(session = session,inputId= "Techniciens_Anc_4_tranches", value = c(7, 8))
   updateSliderInput(session = session,inputId= "Techniciens_Anc_5_tranches", value = c(9, 10))
   updateSliderInput(session = session,inputId= "Techniciens_Anc_6_tranches", value = c(11, 12))
   updateSliderInput(session = session,inputId= "Techniciens_Anc_7_tranches", value = c(13, 14))
   updateSliderInput(session = session,inputId= "Techniciens_Anc_8_tranches", value = c(15, 16))
   updateSliderInput(session = session,inputId= "Techniciens_Anc_9_tranches", value = c(17, 45))
   
   
   updateNumericInput(session = session,inputId = "maj_Techniciens_tranche_1", value = 6)
   updateNumericInput(session = session,inputId = "maj_Techniciens_tranche_2", value = 7)
   updateNumericInput(session = session,inputId = "maj_Techniciens_tranche_3", value = 8)
   updateNumericInput(session = session,inputId = "maj_Techniciens_tranche_4", value = 9)
   updateNumericInput(session = session,inputId = "maj_Techniciens_tranche_5", value = 10)
   updateNumericInput(session = session,inputId = "maj_Techniciens_tranche_6", value = 11)
   updateNumericInput(session = session,inputId = "maj_Techniciens_tranche_7", value = 12)
   updateNumericInput(session = session,inputId = "maj_Techniciens_tranche_8", value = 13)
   updateNumericInput(session = session,inputId = "maj_Techniciens_tranche_9", value = 14)
 }
 )
 
 ############## Cadres
 observeEvent(input$reset_executives_values, {
   updateSliderInput(session = session, inputId= "Cadres_Anc_1_tranches", value = c(1, 2))
   updateSliderInput(session = session,inputId= "Cadres_Anc_2_tranches", value = c(3, 4))
   updateSliderInput(session = session,inputId= "Cadres_Anc_3_tranches", value = c(5, 6))
   updateSliderInput(session = session,inputId= "Cadres_Anc_4_tranches", value = c(7, 8))
   updateSliderInput(session = session,inputId= "Cadres_Anc_5_tranches", value = c(9, 10))
   updateSliderInput(session = session,inputId= "Cadres_Anc_6_tranches", value = c(11, 12))
   updateSliderInput(session = session,inputId= "Cadres_Anc_7_tranches", value = c(13, 14))
   updateSliderInput(session = session,inputId= "Cadres_Anc_8_tranches", value = c(15, 16))
   updateSliderInput(session = session,inputId= "Cadres_Anc_9_tranches", value = c(17, 45))
   
   
   updateNumericInput(session = session,inputId = "maj_Cadres_tranche_1", value = 6)
   updateNumericInput(session = session,inputId = "maj_Cadres_tranche_2", value = 7)
   updateNumericInput(session = session,inputId = "maj_Cadres_tranche_3", value = 8)
   updateNumericInput(session = session,inputId = "maj_Cadres_tranche_4", value = 9)
   updateNumericInput(session = session,inputId = "maj_Cadres_tranche_5", value = 10)
   updateNumericInput(session = session,inputId = "maj_Cadres_tranche_6", value = 11)
   updateNumericInput(session = session,inputId = "maj_Cadres_tranche_7", value = 12)
   updateNumericInput(session = session,inputId = "maj_Cadres_tranche_8", value = 13)
   updateNumericInput(session = session,inputId = "maj_Cadres_tranche_9", value = 14)
 }
 )
 
 ############## Toutes catégories
 observeEvent(input$reset_all_categories_values, {
   updateSliderInput(session = session, inputId= "Toutes_cat_Anc_1_tranches", value = c(1, 2))
   updateSliderInput(session = session,inputId= "Toutes_cat_Anc_2_tranches", value = c(3, 4))
   updateSliderInput(session = session,inputId= "Toutes_cat_Anc_3_tranches", value = c(5, 6))
   updateSliderInput(session = session,inputId= "Toutes_cat_Anc_4_tranches", value = c(7, 8))
   updateSliderInput(session = session,inputId= "Toutes_cat_Anc_5_tranches", value = c(9, 10))
   updateSliderInput(session = session,inputId= "Toutes_cat_Anc_6_tranches", value = c(11, 12))
   updateSliderInput(session = session,inputId= "Toutes_cat_Anc_7_tranches", value = c(13, 14))
   updateSliderInput(session = session,inputId= "Toutes_cat_Anc_8_tranches", value = c(15, 16))
   updateSliderInput(session = session,inputId= "Toutes_cat_Anc_9_tranches", value = c(17, 45))
   
   
   updateNumericInput(session = session,inputId = "maj_Toutes_cat_tranche_1", value = 6)
   updateNumericInput(session = session,inputId = "maj_Toutes_cat_tranche_2", value = 7)
   updateNumericInput(session = session,inputId = "maj_Toutes_cat_tranche_3", value = 8)
   updateNumericInput(session = session,inputId = "maj_Toutes_cat_tranche_4", value = 9)
   updateNumericInput(session = session,inputId = "maj_Toutes_cat_tranche_5", value = 10)
   updateNumericInput(session = session,inputId = "maj_Toutes_cat_tranche_6", value = 11)
   updateNumericInput(session = session,inputId = "maj_Toutes_cat_tranche_7", value = 12)
   updateNumericInput(session = session,inputId = "maj_Toutes_cat_tranche_8", value = 13)
   updateNumericInput(session = session,inputId = "maj_Toutes_cat_tranche_9", value = 14)
 }
 )
 
 #Par groupes:
 observeEvent(input$reset_A_values, {
   updateSliderInput(session = session,inputId= "A_Anc_1_tranches", value = c(0, 1))
   updateSliderInput(session = session,inputId= "A_Anc_2_tranches", value = c(1, 2.5))
   updateSliderInput(session = session,inputId= "A_Anc_3_tranches", value = c(2.5, 4))
   updateSliderInput(session = session,inputId= "A_Anc_4_tranches", value = c(4, 5))
   updateSliderInput(session = session,inputId= "A_Anc_5_tranches", value = c(5, 10))
   updateSliderInput(session = session,inputId= "A_Anc_6_tranches", value = c(10, 15))
   updateSliderInput(session = session,inputId= "A_Anc_7_tranches", value = c(15, 20))
   updateSliderInput(session = session,inputId= "A_Anc_8_tranches", value = c(20, 25))
   updateSliderInput(session = session,inputId= "A_Anc_9_tranches", value = c(25, 30))
   updateSliderInput(session = session,inputId= "A_Anc_10_tranches", value=c(30, 45))
   
   
   updateNumericInput(session = session,inputId = "maj_A_tranche_1", value = 0)
   updateNumericInput(session = session,inputId = "maj_A_tranche_2", value = 3)
   updateNumericInput(session = session,inputId = "maj_A_tranche_3", value = 7)
   updateNumericInput(session = session,inputId = "maj_A_tranche_4", value = 10)
   updateNumericInput(session = session,inputId = "maj_A_tranche_5", value = 12)
   updateNumericInput(session = session,inputId = "maj_A_tranche_6", value = 14)
   updateNumericInput(session = session,inputId = "maj_A_tranche_7", value = 15)
   updateNumericInput(session = session,inputId = "maj_A_tranche_8", value = 20)
   updateNumericInput(session = session,inputId = "maj_A_tranche_9", value = 23)
   updateNumericInput(session = session,inputId = "maj_A_tranche_10", value = 23)
 }
 )
 
 observeEvent(input$reset_B_values, {
   updateSliderInput(session = session,inputId= "B_Anc_1_tranches", value = c(0, 1))
   updateSliderInput(session = session,inputId= "B_Anc_2_tranches", value = c(1, 2.5))
   updateSliderInput(session = session,inputId= "B_Anc_3_tranches", value = c(2.5, 4))
   updateSliderInput(session = session,inputId= "B_Anc_4_tranches", value = c(4, 5))
   updateSliderInput(session = session,inputId= "B_Anc_5_tranches", value = c(5, 10))
   updateSliderInput(session = session,inputId= "B_Anc_6_tranches", value = c(10, 15))
   updateSliderInput(session = session,inputId= "B_Anc_7_tranches", value = c(15, 20))
   updateSliderInput(session = session,inputId= "B_Anc_8_tranches", value = c(20, 25))
   updateSliderInput(session = session,inputId= "B_Anc_9_tranches", value = c(25, 30))
   updateSliderInput(session = session,inputId= "B_Anc_10_tranches", value=c(30, 45))
   
   
   updateNumericInput(session = session,inputId = "maj_B_tranche_1", value = 0)
   updateNumericInput(session = session,inputId = "maj_B_tranche_2", value = 3)
   updateNumericInput(session = session,inputId = "maj_B_tranche_3", value = 7)
   updateNumericInput(session = session,inputId = "maj_B_tranche_4", value = 10)
   updateNumericInput(session = session,inputId = "maj_B_tranche_5", value = 12)
   updateNumericInput(session = session,inputId = "maj_B_tranche_6", value = 14)
   updateNumericInput(session = session,inputId = "maj_B_tranche_7", value = 15)
   updateNumericInput(session = session,inputId = "maj_B_tranche_8", value = 20)
   updateNumericInput(session = session,inputId = "maj_B_tranche_9", value = 23)
   updateNumericInput(session = session,inputId = "maj_B_tranche_10", value = 23)
 }
 )
 
 observeEvent(input$reset_C_values, {
   updateSliderInput(session = session,inputId= "C_Anc_1_tranches", value = c(0, 1))
   updateSliderInput(session = session,inputId= "C_Anc_2_tranches", value = c(1, 2.5))
   updateSliderInput(session = session,inputId= "C_Anc_3_tranches", value = c(2.5, 4))
   updateSliderInput(session = session,inputId= "C_Anc_4_tranches", value = c(4, 5))
   updateSliderInput(session = session,inputId= "C_Anc_5_tranches", value = c(5, 10))
   updateSliderInput(session = session,inputId= "C_Anc_6_tranches", value = c(10, 15))
   updateSliderInput(session = session,inputId= "C_Anc_7_tranches", value = c(15, 20))
   updateSliderInput(session = session,inputId= "C_Anc_8_tranches", value = c(20, 25))
   updateSliderInput(session = session,inputId= "C_Anc_9_tranches", value = c(25, 30))
   updateSliderInput(session = session,inputId= "C_Anc_10_tranches", value=c(30, 45))
   
   
   updateNumericInput(session = session,inputId = "maj_C_tranche_1", value = 0)
   updateNumericInput(session = session,inputId = "maj_C_tranche_2", value = 3)
   updateNumericInput(session = session,inputId = "maj_C_tranche_3", value = 7)
   updateNumericInput(session = session,inputId = "maj_C_tranche_4", value = 10)
   updateNumericInput(session = session,inputId = "maj_C_tranche_5", value = 12)
   updateNumericInput(session = session,inputId = "maj_C_tranche_6", value = 14)
   updateNumericInput(session = session,inputId = "maj_C_tranche_7", value = 15)
   updateNumericInput(session = session,inputId = "maj_C_tranche_8", value = 20)
   updateNumericInput(session = session,inputId = "maj_C_tranche_9", value = 23)
   updateNumericInput(session = session,inputId = "maj_C_tranche_10", value = 23)
 }
 )
 observeEvent(input$reset_D_values, {
   updateSliderInput(session = session,inputId= "D_Anc_1_tranches", value = c(0, 1))
   updateSliderInput(session = session,inputId= "D_Anc_2_tranches", value = c(1, 2.5))
   updateSliderInput(session = session,inputId= "D_Anc_3_tranches", value = c(2.5, 4))
   updateSliderInput(session = session,inputId= "D_Anc_4_tranches", value = c(4, 5))
   updateSliderInput(session = session,inputId= "D_Anc_5_tranches", value = c(5, 10))
   updateSliderInput(session = session,inputId= "D_Anc_6_tranches", value = c(10, 15))
   updateSliderInput(session = session,inputId= "D_Anc_7_tranches", value = c(15, 20))
   updateSliderInput(session = session,inputId= "D_Anc_8_tranches", value = c(20, 25))
   updateSliderInput(session = session,inputId= "D_Anc_9_tranches", value = c(25, 30))
   updateSliderInput(session = session,inputId= "D_Anc_10_tranches", value=c(30, 45))
   
   
   updateNumericInput(session = session,inputId = "maj_D_tranche_1", value = 0)
   updateNumericInput(session = session,inputId = "maj_D_tranche_2", value = 3)
   updateNumericInput(session = session,inputId = "maj_D_tranche_3", value = 7)
   updateNumericInput(session = session,inputId = "maj_D_tranche_4", value = 10)
   updateNumericInput(session = session,inputId = "maj_D_tranche_5", value = 12)
   updateNumericInput(session = session,inputId = "maj_D_tranche_6", value = 14)
   updateNumericInput(session = session,inputId = "maj_D_tranche_7", value = 15)
   updateNumericInput(session = session,inputId = "maj_D_tranche_8", value = 20)
   updateNumericInput(session = session,inputId = "maj_D_tranche_9", value = 23)
   updateNumericInput(session = session,inputId = "maj_D_tranche_10", value = 23)
 }
 )
 
 observeEvent(input$reset_E_values, {
   updateSliderInput(session = session,inputId= "E_Anc_1_tranches", value = c(0, 1))
   updateSliderInput(session = session,inputId= "E_Anc_2_tranches", value = c(1, 2.5))
   updateSliderInput(session = session,inputId= "E_Anc_3_tranches", value = c(2.5, 4))
   updateSliderInput(session = session,inputId= "E_Anc_4_tranches", value = c(4, 5))
   updateSliderInput(session = session,inputId= "E_Anc_5_tranches", value = c(5, 10))
   updateSliderInput(session = session,inputId= "E_Anc_6_tranches", value = c(10, 15))
   updateSliderInput(session = session,inputId= "E_Anc_7_tranches", value = c(15, 20))
   updateSliderInput(session = session,inputId= "E_Anc_8_tranches", value = c(20, 25))
   updateSliderInput(session = session,inputId= "E_Anc_9_tranches", value = c(25, 30))
   updateSliderInput(session = session,inputId= "E_Anc_10_tranches", value=c(30, 45))
   
   
   updateNumericInput(session = session,inputId = "maj_E_tranche_1", value = 0)
   updateNumericInput(session = session,inputId = "maj_E_tranche_2", value = 3)
   updateNumericInput(session = session,inputId = "maj_E_tranche_3", value = 7)
   updateNumericInput(session = session,inputId = "maj_E_tranche_4", value = 10)
   updateNumericInput(session = session,inputId = "maj_E_tranche_5", value = 12)
   updateNumericInput(session = session,inputId = "maj_E_tranche_6", value = 14)
   updateNumericInput(session = session,inputId = "maj_E_tranche_7", value = 15)
   updateNumericInput(session = session,inputId = "maj_E_tranche_8", value = 20)
   updateNumericInput(session = session,inputId = "maj_E_tranche_9", value = 23)
   updateNumericInput(session = session,inputId = "maj_E_tranche_10", value = 23)
 }
 )
 
 observeEvent(input$reset_F_values, {
   updateSliderInput(session = session,inputId= "F_Anc_1_tranches", value = c(0, 1))
   updateSliderInput(session = session,inputId= "F_Anc_2_tranches", value = c(1, 2.5))
   updateSliderInput(session = session,inputId= "F_Anc_3_tranches", value = c(2.5, 4))
   updateSliderInput(session = session,inputId= "F_Anc_4_tranches", value = c(4, 5))
   updateSliderInput(session = session,inputId= "F_Anc_5_tranches", value = c(5, 10))
   updateSliderInput(session = session,inputId= "F_Anc_6_tranches", value = c(10, 15))
   updateSliderInput(session = session,inputId= "F_Anc_7_tranches", value = c(15, 20))
   updateSliderInput(session = session,inputId= "F_Anc_8_tranches", value = c(20, 25))
   updateSliderInput(session = session,inputId= "F_Anc_9_tranches", value = c(25, 30))
   updateSliderInput(session = session,inputId= "F_Anc_10_tranches", value=c(30, 45))
   
   
   updateNumericInput(session = session,inputId = "maj_F_tranche_1", value = 0)
   updateNumericInput(session = session,inputId = "maj_F_tranche_2", value = 3)
   updateNumericInput(session = session,inputId = "maj_F_tranche_3", value = 7)
   updateNumericInput(session = session,inputId = "maj_F_tranche_4", value = 10)
   updateNumericInput(session = session,inputId = "maj_F_tranche_5", value = 12)
   updateNumericInput(session = session,inputId = "maj_F_tranche_6", value = 14)
   updateNumericInput(session = session,inputId = "maj_F_tranche_7", value = 15)
   updateNumericInput(session = session,inputId = "maj_F_tranche_8", value = 20)
   updateNumericInput(session = session,inputId = "maj_F_tranche_9", value = 23)
   updateNumericInput(session = session,inputId = "maj_F_tranche_10", value = 23)
 }
 )
 
 observeEvent(input$reset_G_values, {
   updateSliderInput(session = session,inputId= "G_Anc_1_tranches", value = c(0, 1))
   updateSliderInput(session = session,inputId= "G_Anc_2_tranches", value = c(1, 2.5))
   updateSliderInput(session = session,inputId= "G_Anc_3_tranches", value = c(2.5, 4))
   updateSliderInput(session = session,inputId= "G_Anc_4_tranches", value = c(4, 5))
   updateSliderInput(session = session,inputId= "G_Anc_5_tranches", value = c(5, 10))
   updateSliderInput(session = session,inputId= "G_Anc_6_tranches", value = c(10, 15))
   updateSliderInput(session = session,inputId= "G_Anc_7_tranches", value = c(15, 20))
   updateSliderInput(session = session,inputId= "G_Anc_8_tranches", value = c(20, 25))
   updateSliderInput(session = session,inputId= "G_Anc_9_tranches", value = c(25, 30))
   updateSliderInput(session = session,inputId= "G_Anc_10_tranches", value=c(30, 45))
   
   
   updateNumericInput(session = session,inputId = "maj_G_tranche_1", value = 0)
   updateNumericInput(session = session,inputId = "maj_G_tranche_2", value = 3)
   updateNumericInput(session = session,inputId = "maj_G_tranche_3", value = 7)
   updateNumericInput(session = session,inputId = "maj_G_tranche_4", value = 10)
   updateNumericInput(session = session,inputId = "maj_G_tranche_5", value = 12)
   updateNumericInput(session = session,inputId = "maj_G_tranche_6", value = 14)
   updateNumericInput(session = session,inputId = "maj_G_tranche_7", value = 15)
   updateNumericInput(session = session,inputId = "maj_G_tranche_8", value = 20)
   updateNumericInput(session = session,inputId = "maj_G_tranche_9", value = 23)
   updateNumericInput(session = session,inputId = "maj_G_tranche_10", value = 23)
 }
 )
 
 observeEvent(input$reset_H_values, {
   updateSliderInput(session = session,inputId= "H_Anc_1_tranches", value = c(0, 1))
   updateSliderInput(session = session,inputId= "H_Anc_2_tranches", value = c(1, 2.5))
   updateSliderInput(session = session,inputId= "H_Anc_3_tranches", value = c(2.5, 4))
   updateSliderInput(session = session,inputId= "H_Anc_4_tranches", value = c(4, 5))
   updateSliderInput(session = session,inputId= "H_Anc_5_tranches", value = c(5, 10))
   updateSliderInput(session = session,inputId= "H_Anc_6_tranches", value = c(10, 15))
   updateSliderInput(session = session,inputId= "H_Anc_7_tranches", value = c(15, 20))
   updateSliderInput(session = session,inputId= "H_Anc_8_tranches", value = c(20, 25))
   updateSliderInput(session = session,inputId= "H_Anc_9_tranches", value = c(25, 30))
   updateSliderInput(session = session,inputId= "H_Anc_10_tranches", value=c(30, 45))
   
   
   updateNumericInput(session = session,inputId = "maj_H_tranche_1", value = 0)
   updateNumericInput(session = session,inputId = "maj_H_tranche_2", value = 3)
   updateNumericInput(session = session,inputId = "maj_H_tranche_3", value = 7)
   updateNumericInput(session = session,inputId = "maj_H_tranche_4", value = 10)
   updateNumericInput(session = session,inputId = "maj_H_tranche_5", value = 12)
   updateNumericInput(session = session,inputId = "maj_H_tranche_6", value = 14)
   updateNumericInput(session = session,inputId = "maj_H_tranche_7", value = 15)
   updateNumericInput(session = session,inputId = "maj_H_tranche_8", value = 20)
   updateNumericInput(session = session,inputId = "maj_H_tranche_9", value = 23)
   updateNumericInput(session = session,inputId = "maj_H_tranche_10", value = 23)
 }
 )
 
 observeEvent(input$reset_I_values, {
   updateSliderInput(session = session,inputId= "I_Anc_1_tranches", value = c(0, 1))
   updateSliderInput(session = session,inputId= "I_Anc_2_tranches", value = c(1, 2.5))
   updateSliderInput(session = session,inputId= "I_Anc_3_tranches", value = c(2.5, 4))
   updateSliderInput(session = session,inputId= "I_Anc_4_tranches", value = c(4, 5))
   updateSliderInput(session = session,inputId= "I_Anc_5_tranches", value = c(5, 10))
   updateSliderInput(session = session,inputId= "I_Anc_6_tranches", value = c(10, 15))
   updateSliderInput(session = session,inputId= "I_Anc_7_tranches", value = c(15, 20))
   updateSliderInput(session = session,inputId= "I_Anc_8_tranches", value = c(20, 25))
   updateSliderInput(session = session,inputId= "I_Anc_9_tranches", value = c(25, 30))
   updateSliderInput(session = session,inputId= "I_Anc_10_tranches", value=c(30, 45))
   
   
   updateNumericInput(session = session,inputId = "maj_I_tranche_1", value = 0)
   updateNumericInput(session = session,inputId = "maj_I_tranche_2", value = 3)
   updateNumericInput(session = session,inputId = "maj_I_tranche_3", value = 7)
   updateNumericInput(session = session,inputId = "maj_I_tranche_4", value = 10)
   updateNumericInput(session = session,inputId = "maj_I_tranche_5", value = 12)
   updateNumericInput(session = session,inputId = "maj_I_tranche_6", value = 14)
   updateNumericInput(session = session,inputId = "maj_I_tranche_7", value = 15)
   updateNumericInput(session = session,inputId = "maj_I_tranche_8", value = 20)
   updateNumericInput(session = session,inputId = "maj_I_tranche_9", value = 23)
   updateNumericInput(session = session,inputId = "maj_I_tranche_10", value = 23)
 }
 )
 
 observeEvent(input$reset_J_values, {
   updateSliderInput(session = session,inputId= "J_Anc_1_tranches", value = c(0, 1))
   updateSliderInput(session = session,inputId= "J_Anc_2_tranches", value = c(1, 2.5))
   updateSliderInput(session = session,inputId= "J_Anc_3_tranches", value = c(2.5, 4))
   updateSliderInput(session = session,inputId= "J_Anc_4_tranches", value = c(4, 5))
   updateSliderInput(session = session,inputId= "J_Anc_5_tranches", value = c(5, 10))
   updateSliderInput(session = session,inputId= "J_Anc_6_tranches", value = c(10, 15))
   updateSliderInput(session = session,inputId= "J_Anc_7_tranches", value = c(15, 20))
   updateSliderInput(session = session,inputId= "J_Anc_8_tranches", value = c(20, 25))
   updateSliderInput(session = session,inputId= "J_Anc_9_tranches", value = c(25, 30))
   updateSliderInput(session = session,inputId= "J_Anc_10_tranches", value=c(30, 45))
   
   
   updateNumericInput(session = session,inputId = "maj_J_tranche_1", value = 0)
   updateNumericInput(session = session,inputId = "maj_J_tranche_2", value = 3)
   updateNumericInput(session = session,inputId = "maj_J_tranche_3", value = 7)
   updateNumericInput(session = session,inputId = "maj_J_tranche_4", value = 10)
   updateNumericInput(session = session,inputId = "maj_J_tranche_5", value = 12)
   updateNumericInput(session = session,inputId = "maj_J_tranche_6", value = 14)
   updateNumericInput(session = session,inputId = "maj_J_tranche_7", value = 15)
   updateNumericInput(session = session,inputId = "maj_J_tranche_8", value = 20)
   updateNumericInput(session = session,inputId = "maj_J_tranche_9", value = 23)
   updateNumericInput(session = session,inputId = "maj_J_tranche_10", value = 23)
 }
 )
 
 observeEvent(input$reset_K_values, {
   updateSliderInput(session = session,inputId= "K_Anc_1_tranches", value = c(0, 1))
   updateSliderInput(session = session,inputId= "K_Anc_2_tranches", value = c(1, 2.5))
   updateSliderInput(session = session,inputId= "K_Anc_3_tranches", value = c(2.5, 4))
   updateSliderInput(session = session,inputId= "K_Anc_4_tranches", value = c(4, 5))
   updateSliderInput(session = session,inputId= "K_Anc_5_tranches", value = c(5, 10))
   updateSliderInput(session = session,inputId= "K_Anc_6_tranches", value = c(10, 15))
   updateSliderInput(session = session,inputId= "K_Anc_7_tranches", value = c(15, 20))
   updateSliderInput(session = session,inputId= "K_Anc_8_tranches", value = c(20, 25))
   updateSliderInput(session = session,inputId= "K_Anc_9_tranches", value = c(25, 30))
   updateSliderInput(session = session,inputId= "K_Anc_10_tranches", value=c(30, 45))
   
   
   updateNumericInput(session = session,inputId = "maj_K_tranche_1", value = 0)
   updateNumericInput(session = session,inputId = "maj_K_tranche_2", value = 3)
   updateNumericInput(session = session,inputId = "maj_K_tranche_3", value = 7)
   updateNumericInput(session = session,inputId = "maj_K_tranche_4", value = 10)
   updateNumericInput(session = session,inputId = "maj_K_tranche_5", value = 12)
   updateNumericInput(session = session,inputId = "maj_K_tranche_6", value = 14)
   updateNumericInput(session = session,inputId = "maj_K_tranche_7", value = 15)
   updateNumericInput(session = session,inputId = "maj_K_tranche_8", value = 20)
   updateNumericInput(session = session,inputId = "maj_K_tranche_9", value = 23)
   updateNumericInput(session = session,inputId = "maj_K_tranche_10", value = 23)
 }
 )
 
 observeEvent(input$reset_L_values, {
   updateSliderInput(session = session,inputId= "L_Anc_1_tranches", value = c(0, 1))
   updateSliderInput(session = session,inputId= "L_Anc_2_tranches", value = c(1, 2.5))
   updateSliderInput(session = session,inputId= "L_Anc_3_tranches", value = c(2.5, 4))
   updateSliderInput(session = session,inputId= "L_Anc_4_tranches", value = c(4, 5))
   updateSliderInput(session = session,inputId= "L_Anc_5_tranches", value = c(5, 10))
   updateSliderInput(session = session,inputId= "L_Anc_6_tranches", value = c(10, 15))
   updateSliderInput(session = session,inputId= "L_Anc_7_tranches", value = c(15, 20))
   updateSliderInput(session = session,inputId= "L_Anc_8_tranches", value = c(20, 25))
   updateSliderInput(session = session,inputId= "L_Anc_9_tranches", value = c(25, 30))
   updateSliderInput(session = session,inputId= "L_Anc_10_tranches", value=c(30, 45))
   
   
   updateNumericInput(session = session,inputId = "maj_L_tranche_1", value = 0)
   updateNumericInput(session = session,inputId = "maj_L_tranche_2", value = 3)
   updateNumericInput(session = session,inputId = "maj_L_tranche_3", value = 7)
   updateNumericInput(session = session,inputId = "maj_L_tranche_4", value = 10)
   updateNumericInput(session = session,inputId = "maj_L_tranche_5", value = 12)
   updateNumericInput(session = session,inputId = "maj_L_tranche_6", value = 14)
   updateNumericInput(session = session,inputId = "maj_L_tranche_7", value = 15)
   updateNumericInput(session = session,inputId = "maj_L_tranche_8", value = 20)
   updateNumericInput(session = session,inputId = "maj_L_tranche_9", value = 23)
   updateNumericInput(session = session,inputId = "maj_L_tranche_10", value = 23)
 }
 )
 
 observeEvent(input$reset_M_values, {
   updateSliderInput(session = session,inputId= "M_Anc_1_tranches", value = c(0, 1))
   updateSliderInput(session = session,inputId= "M_Anc_2_tranches", value = c(1, 2.5))
   updateSliderInput(session = session,inputId= "M_Anc_3_tranches", value = c(2.5, 4))
   updateSliderInput(session = session,inputId= "M_Anc_4_tranches", value = c(4, 5))
   updateSliderInput(session = session,inputId= "M_Anc_5_tranches", value = c(5, 10))
   updateSliderInput(session = session,inputId= "M_Anc_6_tranches", value = c(10, 15))
   updateSliderInput(session = session,inputId= "M_Anc_7_tranches", value = c(15, 20))
   updateSliderInput(session = session,inputId= "M_Anc_8_tranches", value = c(20, 25))
   updateSliderInput(session = session,inputId= "M_Anc_9_tranches", value = c(25, 30))
   updateSliderInput(session = session,inputId= "M_Anc_10_tranches", value=c(30, 45))
   
   
   updateNumericInput(session = session,inputId = "maj_M_tranche_1", value = 0)
   updateNumericInput(session = session,inputId = "maj_M_tranche_2", value = 3)
   updateNumericInput(session = session,inputId = "maj_M_tranche_3", value = 7)
   updateNumericInput(session = session,inputId = "maj_M_tranche_4", value = 10)
   updateNumericInput(session = session,inputId = "maj_M_tranche_5", value = 12)
   updateNumericInput(session = session,inputId = "maj_M_tranche_6", value = 14)
   updateNumericInput(session = session,inputId = "maj_M_tranche_7", value = 15)
   updateNumericInput(session = session,inputId = "maj_M_tranche_8", value = 20)
   updateNumericInput(session = session,inputId = "maj_M_tranche_9", value = 23)
   updateNumericInput(session = session,inputId = "maj_M_tranche_10", value = 23)
 }
 )
 
 observeEvent(input$reset_N_values, {
   updateSliderInput(session = session,inputId= "N_Anc_1_tranches", value = c(0, 1))
   updateSliderInput(session = session,inputId= "N_Anc_2_tranches", value = c(1, 2.5))
   updateSliderInput(session = session,inputId= "N_Anc_3_tranches", value = c(2.5, 4))
   updateSliderInput(session = session,inputId= "N_Anc_4_tranches", value = c(4, 5))
   updateSliderInput(session = session,inputId= "N_Anc_5_tranches", value = c(5, 10))
   updateSliderInput(session = session,inputId= "N_Anc_6_tranches", value = c(10, 15))
   updateSliderInput(session = session,inputId= "N_Anc_7_tranches", value = c(15, 20))
   updateSliderInput(session = session,inputId= "N_Anc_8_tranches", value = c(20, 25))
   updateSliderInput(session = session,inputId= "N_Anc_9_tranches", value = c(25, 30))
   updateSliderInput(session = session,inputId= "N_Anc_10_tranches", value=c(30, 45))
   
   
   updateNumericInput(session = session,inputId = "maj_N_tranche_1", value = 0)
   updateNumericInput(session = session,inputId = "maj_N_tranche_2", value = 3)
   updateNumericInput(session = session,inputId = "maj_N_tranche_3", value = 7)
   updateNumericInput(session = session,inputId = "maj_N_tranche_4", value = 10)
   updateNumericInput(session = session,inputId = "maj_N_tranche_5", value = 12)
   updateNumericInput(session = session,inputId = "maj_N_tranche_6", value = 14)
   updateNumericInput(session = session,inputId = "maj_N_tranche_7", value = 15)
   updateNumericInput(session = session,inputId = "maj_N_tranche_8", value = 20)
   updateNumericInput(session = session,inputId = "maj_N_tranche_9", value = 23)
   updateNumericInput(session = session,inputId = "maj_N_tranche_10", value = 23)
 }
 )
 
 observeEvent(input$reset_O_values, {
   updateSliderInput(session = session,inputId= "O_Anc_1_tranches", value = c(0, 1))
   updateSliderInput(session = session,inputId= "O_Anc_2_tranches", value = c(1, 2.5))
   updateSliderInput(session = session,inputId= "O_Anc_3_tranches", value = c(2.5, 4))
   updateSliderInput(session = session,inputId= "O_Anc_4_tranches", value = c(4, 5))
   updateSliderInput(session = session,inputId= "O_Anc_5_tranches", value = c(5, 10))
   updateSliderInput(session = session,inputId= "O_Anc_6_tranches", value = c(10, 15))
   updateSliderInput(session = session,inputId= "O_Anc_7_tranches", value = c(15, 20))
   updateSliderInput(session = session,inputId= "O_Anc_8_tranches", value = c(20, 25))
   updateSliderInput(session = session,inputId= "O_Anc_9_tranches", value = c(25, 30))
   updateSliderInput(session = session,inputId= "O_Anc_10_tranches", value=c(30, 45))
   
   
   updateNumericInput(session = session,inputId = "maj_O_tranche_1", value = 0)
   updateNumericInput(session = session,inputId = "maj_O_tranche_2", value = 3)
   updateNumericInput(session = session,inputId = "maj_O_tranche_3", value = 7)
   updateNumericInput(session = session,inputId = "maj_O_tranche_4", value = 10)
   updateNumericInput(session = session,inputId = "maj_O_tranche_5", value = 12)
   updateNumericInput(session = session,inputId = "maj_O_tranche_6", value = 14)
   updateNumericInput(session = session,inputId = "maj_O_tranche_7", value = 15)
   updateNumericInput(session = session,inputId = "maj_O_tranche_8", value = 20)
   updateNumericInput(session = session,inputId = "maj_O_tranche_9", value = 23)
   updateNumericInput(session = session,inputId = "maj_O_tranche_10", value = 23)
 }
 )
 
 observeEvent(input$reset_P_values, {
   updateSliderInput(session = session,inputId= "P_Anc_1_tranches", value = c(0, 1))
   updateSliderInput(session = session,inputId= "P_Anc_2_tranches", value = c(1, 2.5))
   updateSliderInput(session = session,inputId= "P_Anc_3_tranches", value = c(2.5, 4))
   updateSliderInput(session = session,inputId= "P_Anc_4_tranches", value = c(4, 5))
   updateSliderInput(session = session,inputId= "P_Anc_5_tranches", value = c(5, 10))
   updateSliderInput(session = session,inputId= "P_Anc_6_tranches", value = c(10, 15))
   updateSliderInput(session = session,inputId= "P_Anc_7_tranches", value = c(15, 20))
   updateSliderInput(session = session,inputId= "P_Anc_8_tranches", value = c(20, 25))
   updateSliderInput(session = session,inputId= "P_Anc_9_tranches", value = c(25, 30))
   updateSliderInput(session = session,inputId= "P_Anc_10_tranches", value=c(30, 45))
   
   
   updateNumericInput(session = session,inputId = "maj_P_tranche_1", value = 0)
   updateNumericInput(session = session,inputId = "maj_P_tranche_2", value = 3)
   updateNumericInput(session = session,inputId = "maj_P_tranche_3", value = 7)
   updateNumericInput(session = session,inputId = "maj_P_tranche_4", value = 10)
   updateNumericInput(session = session,inputId = "maj_P_tranche_5", value = 12)
   updateNumericInput(session = session,inputId = "maj_P_tranche_6", value = 14)
   updateNumericInput(session = session,inputId = "maj_P_tranche_7", value = 15)
   updateNumericInput(session = session,inputId = "maj_P_tranche_8", value = 20)
   updateNumericInput(session = session,inputId = "maj_P_tranche_9", value = 23)
   updateNumericInput(session = session,inputId = "maj_P_tranche_10", value = 23)
 }
 )
 
 observeEvent(input$reset_Q_values, {
   updateSliderInput(session = session,inputId= "Q_Anc_1_tranches", value = c(0, 1))
   updateSliderInput(session = session,inputId= "Q_Anc_2_tranches", value = c(1, 2.5))
   updateSliderInput(session = session,inputId= "Q_Anc_3_tranches", value = c(2.5, 4))
   updateSliderInput(session = session,inputId= "Q_Anc_4_tranches", value = c(4, 5))
   updateSliderInput(session = session,inputId= "Q_Anc_5_tranches", value = c(5, 10))
   updateSliderInput(session = session,inputId= "Q_Anc_6_tranches", value = c(10, 15))
   updateSliderInput(session = session,inputId= "Q_Anc_7_tranches", value = c(15, 20))
   updateSliderInput(session = session,inputId= "Q_Anc_8_tranches", value = c(20, 25))
   updateSliderInput(session = session,inputId= "Q_Anc_9_tranches", value = c(25, 30))
   updateSliderInput(session = session,inputId= "Q_Anc_10_tranches", value=c(30, 45))
   
   
   updateNumericInput(session = session,inputId = "maj_Q_tranche_1", value = 0)
   updateNumericInput(session = session,inputId = "maj_Q_tranche_2", value = 3)
   updateNumericInput(session = session,inputId = "maj_Q_tranche_3", value = 7)
   updateNumericInput(session = session,inputId = "maj_Q_tranche_4", value = 10)
   updateNumericInput(session = session,inputId = "maj_Q_tranche_5", value = 12)
   updateNumericInput(session = session,inputId = "maj_Q_tranche_6", value = 14)
   updateNumericInput(session = session,inputId = "maj_Q_tranche_7", value = 15)
   updateNumericInput(session = session,inputId = "maj_Q_tranche_8", value = 20)
   updateNumericInput(session = session,inputId = "maj_Q_tranche_9", value = 23)
   updateNumericInput(session = session,inputId = "maj_Q_tranche_10", value = 23)
 }
 )
 
 observeEvent(input$reset_R_values, {
   updateSliderInput(session = session,inputId= "R_Anc_1_tranches", value = c(0, 1))
   updateSliderInput(session = session,inputId= "R_Anc_2_tranches", value = c(1, 2.5))
   updateSliderInput(session = session,inputId= "R_Anc_3_tranches", value = c(2.5, 4))
   updateSliderInput(session = session,inputId= "R_Anc_4_tranches", value = c(4, 5))
   updateSliderInput(session = session,inputId= "R_Anc_5_tranches", value = c(5, 10))
   updateSliderInput(session = session,inputId= "R_Anc_6_tranches", value = c(10, 15))
   updateSliderInput(session = session,inputId= "R_Anc_7_tranches", value = c(15, 20))
   updateSliderInput(session = session,inputId= "R_Anc_8_tranches", value = c(20, 25))
   updateSliderInput(session = session,inputId= "R_Anc_9_tranches", value = c(25, 30))
   updateSliderInput(session = session,inputId= "R_Anc_10_tranches", value=c(30, 45))
   
   
   updateNumericInput(session = session,inputId = "maj_R_tranche_1", value = 0)
   updateNumericInput(session = session,inputId = "maj_R_tranche_2", value = 3)
   updateNumericInput(session = session,inputId = "maj_R_tranche_3", value = 7)
   updateNumericInput(session = session,inputId = "maj_R_tranche_4", value = 10)
   updateNumericInput(session = session,inputId = "maj_R_tranche_5", value = 12)
   updateNumericInput(session = session,inputId = "maj_R_tranche_6", value = 14)
   updateNumericInput(session = session,inputId = "maj_R_tranche_7", value = 15)
   updateNumericInput(session = session,inputId = "maj_R_tranche_8", value = 20)
   updateNumericInput(session = session,inputId = "maj_R_tranche_9", value = 23)
   updateNumericInput(session = session,inputId = "maj_R_tranche_10", value = 23)
 }
 )
 observeEvent(input$reset_S_values, {
   updateSliderInput(session = session,inputId= "S_Anc_1_tranches", value = c(0, 1))
   updateSliderInput(session = session,inputId= "S_Anc_2_tranches", value = c(1, 2.5))
   updateSliderInput(session = session,inputId= "S_Anc_3_tranches", value = c(2.5, 4))
   updateSliderInput(session = session,inputId= "S_Anc_4_tranches", value = c(4, 5))
   updateSliderInput(session = session,inputId= "S_Anc_5_tranches", value = c(5, 10))
   updateSliderInput(session = session,inputId= "S_Anc_6_tranches", value = c(10, 15))
   updateSliderInput(session = session,inputId= "S_Anc_7_tranches", value = c(15, 20))
   updateSliderInput(session = session,inputId= "S_Anc_8_tranches", value = c(20, 25))
   updateSliderInput(session = session,inputId= "S_Anc_9_tranches", value = c(25, 30))
   updateSliderInput(session = session,inputId= "S_Anc_10_tranches", value=c(30, 45))
   
   
   updateNumericInput(session = session,inputId = "maj_S_tranche_1", value = 0)
   updateNumericInput(session = session,inputId = "maj_S_tranche_2", value = 3)
   updateNumericInput(session = session,inputId = "maj_S_tranche_3", value = 7)
   updateNumericInput(session = session,inputId = "maj_S_tranche_4", value = 10)
   updateNumericInput(session = session,inputId = "maj_S_tranche_5", value = 12)
   updateNumericInput(session = session,inputId = "maj_S_tranche_6", value = 14)
   updateNumericInput(session = session,inputId = "maj_S_tranche_7", value = 15)
   updateNumericInput(session = session,inputId = "maj_S_tranche_8", value = 20)
   updateNumericInput(session = session,inputId = "maj_S_tranche_9", value = 23)
   updateNumericInput(session = session,inputId = "maj_S_tranche_10", value = 23)
 }
 )
 observeEvent(input$reset_T_values, {
   updateSliderInput(session = session,inputId= "T_Anc_1_tranches", value = c(0, 1))
   updateSliderInput(session = session,inputId= "T_Anc_2_tranches", value = c(1, 2.5))
   updateSliderInput(session = session,inputId= "T_Anc_3_tranches", value = c(2.5, 4))
   updateSliderInput(session = session,inputId= "T_Anc_4_tranches", value = c(4, 5))
   updateSliderInput(session = session,inputId= "T_Anc_5_tranches", value = c(5, 10))
   updateSliderInput(session = session,inputId= "T_Anc_6_tranches", value = c(10, 15))
   updateSliderInput(session = session,inputId= "T_Anc_7_tranches", value = c(15, 20))
   updateSliderInput(session = session,inputId= "T_Anc_8_tranches", value = c(20, 25))
   updateSliderInput(session = session,inputId= "T_Anc_9_tranches", value = c(25, 30))
   updateSliderInput(session = session,inputId= "T_Anc_10_tranches", value=c(30, 45))
   
   
   updateNumericInput(session = session,inputId = "maj_T_tranche_1", value = 0)
   updateNumericInput(session = session,inputId = "maj_T_tranche_2", value = 3)
   updateNumericInput(session = session,inputId = "maj_T_tranche_3", value = 7)
   updateNumericInput(session = session,inputId = "maj_T_tranche_4", value = 10)
   updateNumericInput(session = session,inputId = "maj_T_tranche_5", value = 12)
   updateNumericInput(session = session,inputId = "maj_T_tranche_6", value = 14)
   updateNumericInput(session = session,inputId = "maj_T_tranche_7", value = 15)
   updateNumericInput(session = session,inputId = "maj_T_tranche_8", value = 20)
   updateNumericInput(session = session,inputId = "maj_T_tranche_9", value = 23)
   updateNumericInput(session = session,inputId = "maj_T_tranche_10", value = 23)
 }
 )
 
 observeEvent(input$reset_U_values, {
   updateSliderInput(session = session,inputId= "U_Anc_1_tranches", value = c(0, 1))
   updateSliderInput(session = session,inputId= "U_Anc_2_tranches", value = c(1, 2.5))
   updateSliderInput(session = session,inputId= "U_Anc_3_tranches", value = c(2.5, 4))
   updateSliderInput(session = session,inputId= "U_Anc_4_tranches", value = c(4, 5))
   updateSliderInput(session = session,inputId= "U_Anc_5_tranches", value = c(5, 10))
   updateSliderInput(session = session,inputId= "U_Anc_6_tranches", value = c(10, 15))
   updateSliderInput(session = session,inputId= "U_Anc_7_tranches", value = c(15, 20))
   updateSliderInput(session = session,inputId= "U_Anc_8_tranches", value = c(20, 25))
   updateSliderInput(session = session,inputId= "U_Anc_9_tranches", value = c(25, 30))
   updateSliderInput(session = session,inputId= "U_Anc_10_tranches", value=c(30, 45))
   
   
   updateNumericInput(session = session,inputId = "maj_U_tranche_1", value = 0)
   updateNumericInput(session = session,inputId = "maj_U_tranche_2", value = 3)
   updateNumericInput(session = session,inputId = "maj_U_tranche_3", value = 7)
   updateNumericInput(session = session,inputId = "maj_U_tranche_4", value = 10)
   updateNumericInput(session = session,inputId = "maj_U_tranche_5", value = 12)
   updateNumericInput(session = session,inputId = "maj_U_tranche_6", value = 14)
   updateNumericInput(session = session,inputId = "maj_U_tranche_7", value = 15)
   updateNumericInput(session = session,inputId = "maj_U_tranche_8", value = 20)
   updateNumericInput(session = session,inputId = "maj_U_tranche_9", value = 23)
   updateNumericInput(session = session,inputId = "maj_U_tranche_10", value = 23)
 }
 )
 
 observeEvent(input$reset_V_values, {
   updateSliderInput(session = session,inputId= "V_Anc_1_tranches", value = c(0, 1))
   updateSliderInput(session = session,inputId= "V_Anc_2_tranches", value = c(1, 2.5))
   updateSliderInput(session = session,inputId= "V_Anc_3_tranches", value = c(2.5, 4))
   updateSliderInput(session = session,inputId= "V_Anc_4_tranches", value = c(4, 5))
   updateSliderInput(session = session,inputId= "V_Anc_5_tranches", value = c(5, 10))
   updateSliderInput(session = session,inputId= "V_Anc_6_tranches", value = c(10, 15))
   updateSliderInput(session = session,inputId= "V_Anc_7_tranches", value = c(15, 20))
   updateSliderInput(session = session,inputId= "V_Anc_8_tranches", value = c(20, 25))
   updateSliderInput(session = session,inputId= "V_Anc_9_tranches", value = c(25, 30))
   updateSliderInput(session = session,inputId= "V_Anc_10_tranches", value=c(30, 45))
   
   
   updateNumericInput(session = session,inputId = "maj_V_tranche_1", value = 0)
   updateNumericInput(session = session,inputId = "maj_V_tranche_2", value = 3)
   updateNumericInput(session = session,inputId = "maj_V_tranche_3", value = 7)
   updateNumericInput(session = session,inputId = "maj_V_tranche_4", value = 10)
   updateNumericInput(session = session,inputId = "maj_V_tranche_5", value = 12)
   updateNumericInput(session = session,inputId = "maj_V_tranche_6", value = 14)
   updateNumericInput(session = session,inputId = "maj_V_tranche_7", value = 15)
   updateNumericInput(session = session,inputId = "maj_V_tranche_8", value = 20)
   updateNumericInput(session = session,inputId = "maj_V_tranche_9", value = 23)
   updateNumericInput(session = session,inputId = "maj_V_tranche_10", value = 23)
 }
 )
 
 observeEvent(input$reset_W_values, {
   updateSliderInput(session = session,inputId= "W_Anc_1_tranches", value = c(0, 1))
   updateSliderInput(session = session,inputId= "W_Anc_2_tranches", value = c(1, 2.5))
   updateSliderInput(session = session,inputId= "W_Anc_3_tranches", value = c(2.5, 4))
   updateSliderInput(session = session,inputId= "W_Anc_4_tranches", value = c(4, 5))
   updateSliderInput(session = session,inputId= "W_Anc_5_tranches", value = c(5, 10))
   updateSliderInput(session = session,inputId= "W_Anc_6_tranches", value = c(10, 15))
   updateSliderInput(session = session,inputId= "W_Anc_7_tranches", value = c(15, 20))
   updateSliderInput(session = session,inputId= "W_Anc_8_tranches", value = c(20, 25))
   updateSliderInput(session = session,inputId= "W_Anc_9_tranches", value = c(25, 30))
   updateSliderInput(session = session,inputId= "W_Anc_10_tranches", value=c(30, 45))
   
   
   updateNumericInput(session = session,inputId = "maj_W_tranche_1", value = 0)
   updateNumericInput(session = session,inputId = "maj_W_tranche_2", value = 3)
   updateNumericInput(session = session,inputId = "maj_W_tranche_3", value = 7)
   updateNumericInput(session = session,inputId = "maj_W_tranche_4", value = 10)
   updateNumericInput(session = session,inputId = "maj_W_tranche_5", value = 12)
   updateNumericInput(session = session,inputId = "maj_W_tranche_6", value = 14)
   updateNumericInput(session = session,inputId = "maj_W_tranche_7", value = 15)
   updateNumericInput(session = session,inputId = "maj_W_tranche_8", value = 20)
   updateNumericInput(session = session,inputId = "maj_W_tranche_9", value = 23)
   updateNumericInput(session = session,inputId = "maj_W_tranche_10", value = 23)
 }
 )
 
 observeEvent(input$reset_X_values, {
   updateSliderInput(session = session,inputId= "X_Anc_1_tranches", value = c(0, 1))
   updateSliderInput(session = session,inputId= "X_Anc_2_tranches", value = c(1, 2.5))
   updateSliderInput(session = session,inputId= "X_Anc_3_tranches", value = c(2.5, 4))
   updateSliderInput(session = session,inputId= "X_Anc_4_tranches", value = c(4, 5))
   updateSliderInput(session = session,inputId= "X_Anc_5_tranches", value = c(5, 10))
   updateSliderInput(session = session,inputId= "X_Anc_6_tranches", value = c(10, 15))
   updateSliderInput(session = session,inputId= "X_Anc_7_tranches", value = c(15, 20))
   updateSliderInput(session = session,inputId= "X_Anc_8_tranches", value = c(20, 25))
   updateSliderInput(session = session,inputId= "X_Anc_9_tranches", value = c(25, 30))
   updateSliderInput(session = session,inputId= "X_Anc_10_tranches", value=c(30, 45))
   
   
   updateNumericInput(session = session,inputId = "maj_X_tranche_1", value = 0)
   updateNumericInput(session = session,inputId = "maj_X_tranche_2", value = 3)
   updateNumericInput(session = session,inputId = "maj_X_tranche_3", value = 7)
   updateNumericInput(session = session,inputId = "maj_X_tranche_4", value = 10)
   updateNumericInput(session = session,inputId = "maj_X_tranche_5", value = 12)
   updateNumericInput(session = session,inputId = "maj_X_tranche_6", value = 14)
   updateNumericInput(session = session,inputId = "maj_X_tranche_7", value = 15)
   updateNumericInput(session = session,inputId = "maj_X_tranche_8", value = 20)
   updateNumericInput(session = session,inputId = "maj_X_tranche_9", value = 23)
   updateNumericInput(session = session,inputId = "maj_X_tranche_10", value = 23)
 }
 )
 
 observeEvent(input$reset_Y_values, {
   updateSliderInput(session = session,inputId= "Y_Anc_1_tranches", value = c(0, 1))
   updateSliderInput(session = session,inputId= "Y_Anc_2_tranches", value = c(1, 2.5))
   updateSliderInput(session = session,inputId= "Y_Anc_3_tranches", value = c(2.5, 4))
   updateSliderInput(session = session,inputId= "Y_Anc_4_tranches", value = c(4, 5))
   updateSliderInput(session = session,inputId= "Y_Anc_5_tranches", value = c(5, 10))
   updateSliderInput(session = session,inputId= "Y_Anc_6_tranches", value = c(10, 15))
   updateSliderInput(session = session,inputId= "Y_Anc_7_tranches", value = c(15, 20))
   updateSliderInput(session = session,inputId= "Y_Anc_8_tranches", value = c(20, 25))
   updateSliderInput(session = session,inputId= "Y_Anc_9_tranches", value = c(25, 30))
   updateSliderInput(session = session,inputId= "Y_Anc_10_tranches", value=c(30, 45))
   
   
   updateNumericInput(session = session,inputId = "maj_Y_tranche_1", value = 0)
   updateNumericInput(session = session,inputId = "maj_Y_tranche_2", value = 3)
   updateNumericInput(session = session,inputId = "maj_Y_tranche_3", value = 7)
   updateNumericInput(session = session,inputId = "maj_Y_tranche_4", value = 10)
   updateNumericInput(session = session,inputId = "maj_Y_tranche_5", value = 12)
   updateNumericInput(session = session,inputId = "maj_Y_tranche_6", value = 14)
   updateNumericInput(session = session,inputId = "maj_Y_tranche_7", value = 15)
   updateNumericInput(session = session,inputId = "maj_Y_tranche_8", value = 20)
   updateNumericInput(session = session,inputId = "maj_Y_tranche_9", value = 23)
   updateNumericInput(session = session,inputId = "maj_Y_tranche_10", value = 23)
 }
 )
 
 ################################################
 ############# Réinitialisation des minimas
 ################################################
 
 observeEvent(input$reset_minimas_groupes, {
   updateSliderInput(session = session,inputId= "classif_1", value = 1766)
   updateSliderInput(session = session,inputId= "classif_2", value = 1776)
   updateSliderInput(session = session,inputId= "classif_3", value = 1783)
   updateSliderInput(session = session,inputId= "classif_4", value = 1789)
   updateSliderInput(session = session,inputId= "classif_5", value = 1793)
   updateSliderInput(session = session,inputId= "classif_6", value = 1798)
   updateSliderInput(session = session,inputId= "classif_7", value = 1884)
   updateSliderInput(session = session,inputId= "classif_8", value = 1931)
   
   if (input$custom_number_classifications >= 9){
     updateSliderInput(session = session,inputId= "classif_9", value = 1978)
   }
   
   if (input$custom_number_classifications >= 10){
     updateSliderInput(session = session,inputId= "classif_10", value = 2072)
   }
   
   if (input$custom_number_classifications >= 11){
     updateSliderInput(session = session,inputId= "classif_11", value = 2166)
   }
   
   if (input$custom_number_classifications >= 12){
     updateSliderInput(session = session,inputId= "classif_12", value = 2260)
   }
   
   if (input$custom_number_classifications >= 13){
     updateSliderInput(session = session,inputId= "classif_13", value = 2355)
   }
   
   if (input$custom_number_classifications >= 14){
     updateSliderInput(session = session,inputId= "classif_14", value = 2543)
   }
   
   if (input$custom_number_classifications >= 15){
     updateSliderInput(session = session,inputId= "classif_15", value = 2637)
   }
   
   if (input$custom_number_classifications >= 16){
     updateSliderInput(session = session,inputId= "classif_16", value = 2836)
   }
   
   if (input$custom_number_classifications >= 17){
     updateSliderInput(session = session,inputId= "classif_17", value = 2920)
   }
   
   if (input$custom_number_classifications >= 18){
     updateSliderInput(session = session,inputId= "classif_18", value = 3014)
   }
   
   if (input$custom_number_classifications >= 19){
     updateSliderInput(session = session,inputId= "classif_19", value = 3202)
   }
   
   if (input$custom_number_classifications >= 20){
     updateSliderInput(session = session,inputId= "classif_20", value = 3391)
   }
   
   if (input$custom_number_classifications >= 21){
     updateSliderInput(session = session,inputId= "classif_21", value = 3673)
   }
   if (input$custom_number_classifications >= 22){
     updateSliderInput(session = session,inputId= "classif_22", value = 3753)
   }
   if (input$custom_number_classifications >= 23){
     updateSliderInput(session = session,inputId= "classif_23", value = 3763)
   }
   if (input$custom_number_classifications >= 24){
     updateSliderInput(session = session,inputId= "classif_24", value = 3773)
   }
   if (input$custom_number_classifications >= 25){
     updateSliderInput(session = session,inputId= "classif_25", value = 3783)
   }
 })

 #server du bouton pour réduire/agrandire la séléction de colonne du tableau
 
 
 #### Graphique qui représente effectif par catégorielle.
 
 #mapper les noms des choix pour le titre interactifs:
 variable_names <- c(
   grp = "le groupe",
   scores = "le score",
   CAT = "la catégorie socio-professionnelle",
   coef_tr = "le coefficient",
   code_repere = "l'emploi-repère"
 )
 
 #Condition: gère le cas ou l'utilisteur désélectionne toutes les colonnes
 output$effectif_chart <- renderHighchart({

   df_hist <-choosedataset2() 
   validate(
     need(nrow(df_hist)>0, "Aucun salarié ne correspond aux filtres sélectionnés")
   )
   
   df_hist2 = df_hist %>%
       group_by(!!sym(input$choixvariable3)) %>%
       summarise(n = n()) %>%
       rename(categorie = !!sym(input$choixvariable3))
   
   #différencier les titres selon les variables:
   
   titre_chart_eff  = paste("Répartition des salariés selon ",variable_names[input$choixvariable3])
   
   
   highchart() %>%
     hc_chart(type = "column", backgroundColor = "#fff") %>%
     hc_title(
       text = titre_chart_eff,
       align = "left",
       style = list(
         fontSize = "16px",
         color = "#8192AE"
       )
     ) %>%
     hc_xAxis(
       categories = df_hist2$categorie, 
       labels = list(
         step = 1, 
         style = list(color = "#8192AE", rotation = ifelse(length(df_hist2$categorie) > 10, -50, 0))
       )
     ) %>%
     hc_yAxis(
       labels = list(
         formatter = JS("function() { return this.value; }")
       )
     ) %>%
     hc_series(list(
       name = "Effectifs",
       data = df_hist2$n,
       color = "#8346AD",
       dataLabels = list(enabled = TRUE)
     )) %>%
     hc_plotOptions(column = list(dataLabels = list(enabled = TRUE))) %>%
     hc_legend(enabled = FALSE) %>%
     hc_exporting(enabled = TRUE)
 

 
   
 })


  
  
 hide(id = "collapsible_content")
 observeEvent(input$collapse_button, {
   toggle(id = "collapsible_content")})
 
 
}
 
 

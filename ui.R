#Initialisation
ui <- navbarPage(
  title = div("Outil UTP - Version test",tags$script(HTML("var header = $('.navbar > .container-fluid');header.append('<div style=\"float:right\"><a href=\"URL\"><img src=\"utp_logo.png\" alt=\"alt\" style=\"float:right;width:48px;height:50px;padding-top:5px;padding-bottom:5px;\"> </a></div>');console.log(header)")
  )),
  windowTitle = "Outil UTP  - Version test",
  id = "navs", 
  header = tags$head(
    QuseShinydashboard(),
    useShinyjs(),
    tags$link(href = "styles.css", rel = "stylesheet", type = "text/css"),
    tags$link(rel="shortcut icon", href="favicon.ico", type="image/ico"),
    tags$link(rel = "stylesheet", href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"),
    tags$style(type = 'text/css', 
               HTML('    .navbar-default {
    background-color: #fff !important;
               } .navbar-default .navbar-nav>li>a {color: #8192AE;}
                    .navbar-default .navbar-brand{color: #EE6A28;}
                    .navbar-default .navbar-brand{font-weight: bold;}
                    .navbar-default .navbar-brand:hover {color:white;}
                  .navbar-default .navbar-nav > .active > a,
        .navbar-default .navbar-nav > .active > a:focus,
                    navbar-default .navbar-nav > .active > a:hover {color:#EE6A28;background-color:#fff;}
                    .navbar-default .navbar-nav > li > a:hover {color:#8192AE;background-color:white;text-decoration}
                    .navbar-default .navbar-nav> .active > a::after {
          content: "•";
          color: #EE6A28;
          font-size: 50px;
          position: absolute;
          bottom: -6.5px;
          left: 50%;
          transform: translateX(-50%);}
                    .navbar-default .navbar-nav> .active > a::before {
          content: "•";
          color: #fff;
          font-size: 100px;
          position: absolute;
          bottom: -2px;
          left: 50%;
          transform: translateX(-50%);
        }

       .box.box-solid.box-info>.box-header {
  color:#8346AD;
  background:#8346AD
       }
      
body {
  background-color: #F0F3F5; /* Replace with your desired color */
}

.custom-sidebar {
  background-color: #fff; /* Background color of the sidebar panel */
  color: #8192AE; /* Text color in the sidebar */
  padding: 15px;
  border-radius: 5px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.custom-sidebar p {
  color: #8192AE; /* Text color for paragraphs in the sidebar */
}

.custom-sidebar select {
  background-color: #fff; /* Background color of the select input */
  color: #EE6A28; /* Text color of the select input */
}

.box {
                 
                     border-bottom-color: #fff !important;
                     border-left-color: #fff !important;
                     border-right-color: #fff !important;
                     border-top-color: #fff !important;
                     background-color: #fff !important;
                     border-radius: 10px !important;
                 }
                 .box-header {
                  color: #EE6A28 !important;
                  background-color: #ffff !important; /* Background color */
                  font-weight: bold !important;
                  border-radius: 10px !important;
                 }
                 .box-title {
                  color: #EE6A28 !important;
                  font-weight: bold !important;
                  font-family: "Galano Grotesque Medium", sans-serif !important;
                  }
                 
                .box-header .box-tools.pull-right .fa-minus,
                .box-header .box-tools.pull-right .fa-plus {
                  color: #EE6A28 !important; /* Orange color for icons */
                }

.custom-title {
color: #EE6A28; /* Replace with your desired color */
    }

.box.box-info>.box-header {
  color:#8346AD;
  background:#8346AD
                    }
.box.box-info{
border-bottom-color:#8346AD;
border-left-color:#8346AD;
border-right-color:#8346AD;
border-top-color:#8346AD;
}
.btn-warning {
         background-color: #8346AD; 
         border-color: #8346AD;
         font-weight: bold;
         color:#8346AD} 
.btn-danger {
         background-color: #B24A6F; 
         border-color: #B24A6F;} 
.btn-success {
         background-color: #B5C0CF; 
         border-color: #B5C0CF;}
.small-box.bg-yellow{background-color:#EE6A28 !important;color:#8346AD !important;}
.small-box.bg-aqua{background-color:#8346AD !important;color:#8346AD !important;}
.js-irs-0 .irs-line-mid {
  background: #FFCC00;
}
#Changement de couleur des sliders
                 .irs-line-mid {
      background: #D37EF9 !important;
    }
    .irs-line-left {
      background: #D37EF9 !important;
    }
    .irs-line-right {
      background: #D37EF9 !important;
    }

    /* Handle color */
    .irs-bar {
      background: #D37EF9 !important;
      border-top: 1px solid #D37EF9 !important;
      border-bottom: 1px solid #D37EF9 !important;
    }
    .irs-bar-edge {
      background: #D37EF9 !important;
      border: 1px solid #D37EF9 !important;
    }
    .irs-single {
      background: #8346AD !important;
      border: 1px solid #8346AD !important;
    }
#Changement de couleur des checkboxes
      .checkbox-inline, .checkbox label {
        color: #000000; /* Change la couleur du texte des checkboxes */
      }
      input[type="checkbox"] {
        accent-color: #8346AD; /* Change la couleur de la case à cocher */
      }
      .box-slider {
      background: #fffff !important;
      }
      
      .custom-title {
        color: #8192AE;
        font-family: "Galano Grotesque Medium", sans-serif !important;
        font-weight: lighter !important;
      }
      .custom-height {
        height: 450px !important;
      }
      .centered-column {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100%;
      }
      
    #update_button {
      background-color: #fff; /* Couleur de fond */
      color: #EE6A28 ; /* Couleur du texte */
      border: 1px solid #8346AD /*paramètres de bordures*/
      padding: 15px 32px; /* Espacement interne */
      text-align: center; /* Alignement du texte */
      font-size: 18px; /* Taille de la police */
      font-family: "Galano Grotesque Medium", sans-serif;
      margin: 4px 2px; /* Marge externe */
      border-radius: 5px; /* Coins arrondis */
    }
    #update_button:hover {
      background-color: #F0F3F5; /* Couleur de fond au survol */
      color : #8192AE; /* Couleur du texte au survol */
    }
        .custom-collapse-button {
    background-color: #fff !important;
    color: #EE6A28 !important;
    border: 1px solid #8192AE !important;
    padding: 10px 20px !important;
    text-align: center; /* Alignement du texte */
    font-size: 10px; /* Taille de la police */
    font-family: "Galano Grotesque Medium", sans-serif;
    border-radius: 5px !important;
    cursor: pointer !important;
    }
.collapse-container {
    margin-bottom: 15px; 
    margin-top: 20px;
}
      
'

               ))
  ),
  tabPanel(
    title = "Construction et évaluation d'un scénario de classification",
    
    
    
    
    fluidRow(
      box(
        width = 12,
        status = "info",
        solidHeader = FALSE,
        p(HTML(
          '<b> Cette plateforme a été conçue afin de d\'évaluer les impacts de l\'introduction d\'un nouveau système de classification dans 
          la branche du transport public urbain. <br> Un guide d\'utilisation de l\'outil est disponible en cliquant sur le bouton « + » de la rubrique
          ci-dessous. Un livret de présentation  plus approfondi est accessible <a href = "Quadrat_UTP_GuideAppli.pdf" target = "blank">ici</a>.
           <p style="color:#EF333F"> L\'outil est en cours de construction et la version présentée ici est une version de test. L\'ensemble des résultats obtenus sont donc à prendre avec la plus grande précaution. </p>
           </b>
           <i> Outil réalisé en juillet 2024 par l\'UTP en collaboration avec le cabinet Quadrat-Etudes.
          Dernière mise à jour : 16/07/2024 (<a href= "historique_versions.pdf">V1.0 </a>)</i>'))
      )
    ),
    
    fluidRow(
      column(    
        width = 9,
        box(width = 12,
            status = "info",
            solidHeader = FALSE,
            title = "Guide d'utilisation",
            collapsible = TRUE,
            collapsed = TRUE,
            p(HTML(
              "<ol type='1'>
  <li><b>Sélection des paramètres du nouveau système de classification</b></li>
  L'utilisateur peut ajuster le nouveau système de classification selon plusieurs paramètres : le scoring de 
  chaque emploi-repère, le nombre de groupes de classification, la constitution des groupes de classification, 
  l'affectation d'un salaire minimum à chaque groupe, la définition de majorations des minima selon l'ancienneté,
  l'intégration ou non de certaines primes aux salaires.
  Les différents paramètres peuvent être entrés manuellement ou importés à l'aide de fichiers Excel.
  
  <li><b>Validation des paramètres</b></li>
  Une fois les paramètres du nouveau système de classification choisis, cliquer sur le bouton « Actualiser la simulation ». Un temps de chargement peut alors être nécessaire.
  <li><b>Consultation des résultats</b></li>
  Les résultats s'affichent sur la partie droite de l'écran. À l'aide des six menus 
  déroulants en haut de page, l'utilisateur peut personnaliser le périmètre sur lequel sont calculés les
  résultats et ainsi procéder à des analyses de type « Zoom » sur certains groupes de salariés. Les menus 
  déroulants conditionnent le périmètre de calcul des quatre rubriques de résultats suivantes : 
  « Chiffres des impacts », « Détail des revalorisations et des coûts associés », 
  « Transposition des effectifs dans la nouvelle classification », « Données individuelles ». 
</ol>         "
            )))
      ),
      column(
        
        width = 3,
        actionButton("launch_simulation_button", "Lancer la simulation", icon = icon("play-circle" ),
                     width = "100%", style = "font-size : 20px; color: #FFFFFF; font-weight: bold; left: 3%; background-color: #EE6A28;
                     margin-bottom: 15px;")
        # align="left",
        # style="margin-bottom: 40px;"
      )
      
    ),
    fluidRow(
      column(    
        width = 4,
        strong(p("Choix des paramètres", style="color:grey; text-align:center; font-style: bold; font-size:25px;")),
        box(width=12,
            title="Scoring des emplois-repères",
            status="warning",
            solidHeader = TRUE,
            collapsible=TRUE,
            collapsed = FALSE,
            fluidRow(
              column(width = 12, 
                     pickerInput(inputId = "Exclure_emplois", 
                                 label  = "Sélectionnez les emplois-repères à prendre en compte :", 
                                 choices = c(sort(unique(salaires$lib_repere))),
                                 multiple = T,
                                 options = list(`none-selected-text` = "Veuillez sélectionner au moins un emploi"),
                                 selected = c(sort(unique(salaires$lib_repere))),
                                 )
                     )
                   ),
            column(width= 8,
                   selectInput(inputId="choix_emploi_repere", label="Sélection d'un emploi-repère :", choices = c(sort(unique(salaires$lib_repere))))
            ),
            column(
              width=4,
              conditionalPanel(condition = "input.choix_emploi_repere == 'Acheteur (se) / commande publique' && input.Exclure_emplois.includes('Acheteur (se) / commande publique')",
                               numericInput(inputId="score_acheteur_commande_publique", label = "Score :", min =6, max =30, value = score_init_acheteur_commande_publique)
              ),
              
              conditionalPanel(condition = "input.choix_emploi_repere == 'Administrateur(trice) systèmes réseaux' && input.Exclure_emplois.includes('Administrateur(trice) systèmes réseaux')",
                               numericInput(inputId="score_administrateur_systemes_reseaux", label = "Score :", min =6, max =30, value = score_init_administrateur_systeme_reseau)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Agent / Chargé(e) des méthodes d exploitation' && input.Exclure_emplois.includes('Agent / Chargé(e) des méthodes d exploitation')",
                               numericInput(inputId="score_agent_charge_methodes_exploitation", label = "Score :", min =6, max =30, value = score_init_agent_charge_methodes_exploitation)
              ),
              
              
              conditionalPanel(condition = "input.choix_emploi_repere == 'Agent de manoeuvre' && input.Exclure_emplois.includes('Agent de manoeuvre')",
                               numericInput(inputId="score_agent_manoeuvre", label = "Score :", min =6, max =30, value = score_init_agent_manoeuvre)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Agent de planning'&& input.Exclure_emplois.includes('Agent de planning')",
                               numericInput(inputId="score_agent_planning", label = "Score :", min =6, max =30, value = score_init_agent_planning)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Agent de sûreté'&& input.Exclure_emplois.includes('Agent de sûreté')",
                               numericInput(inputId="score_agent_surete", label = "Score :", min =6, max =30, value = score_init_agent_surete)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Agents de back-office'&& input.Exclure_emplois.includes('Agents de back-office')",
                               numericInput(inputId="score_agent_back_office", label = "Score :", min =6, max =30, value = score_init_agent_back_office)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Aiguilleur(e)' && input.Exclure_emplois.includes('Aiguilleur(e)')",
                               numericInput(inputId="score_aiguilleur", label = "Score :", min =6, max =30, value = score_init_aiguilleur)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Animateur(trice) de la qualité' && input.Exclure_emplois.includes('Animateur(trice) de la qualité')",
                               numericInput(inputId="score_animateur_qualite", label = "Score :", min =6, max =30, value = score_init_animateur_qualite)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Animateur(trice) HSE / sécurité prévention' && input.Exclure_emplois.includes('Animateur(trice) HSE / sécurité prévention')",
                               numericInput(inputId="score_animateur_securite_prevention", label = "Score :", min =6, max =30, value = score_init_animateur_securite_prevention)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Assistant(e) commercial(e) et marketing' && input.Exclure_emplois.includes('Assistant(e) commercial(e) et marketing')",
                               numericInput(inputId="score_assistant_commercial_marketing", label = "Score :", min =6, max =30, value = score_init_assistant_commercial_marketing)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Assistant(e) contrôle de gestion' && input.Exclure_emplois.includes('Assistant(e) contrôle de gestion')",
                               numericInput(inputId="score_assistant_controle_gestion", label = "Score :", min =6, max =30, value = score_init_assistant_controle_gestion)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Assistant(e) de direction'&& input.Exclure_emplois.includes('Assistant(e) de direction')",
                               numericInput(inputId="score_assistant_direction", label = "Score :", min =6, max =30, value = score_init_assistant_direction)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Assistant(e) RH' && input.Exclure_emplois.includes('Assistant(e) RH')",
                               numericInput(inputId="score_assistant_rh", label = "Score :", min =6, max =30, value = score_init_assistant_rh)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Chargé(e) d études' && input.Exclure_emplois.includes('Chargé(e) d études')",
                               numericInput(inputId="score_charge_etudes", label = "Score :", min =6, max =30, value = score_init_charge_etudes)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Chargé(e) de communication'  && input.Exclure_emplois.includes('Chargé(e) de communication')",
                               numericInput(inputId="score_charge_communication", label = "Score :", min =6, max =30, value = score_init_charge_communication)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Chargé(e) de marketing' && input.Exclure_emplois.includes('Chargé(e) de marketing')",
                               numericInput(inputId="score_charge_marketing", label = "Score :", min =6, max =30, value = score_init_charge_marketing)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Chargé(e) de recrutement' && input.Exclure_emplois.includes('Chargé(e) de recrutement')",
                               numericInput(inputId="score_charge_recrutement", label = "Score :", min =6, max =30, value = score_init_charge_recrutement)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Chargé(e) de web éditorial' && input.Exclure_emplois.includes('Chargé(e) de web éditorial')",
                               numericInput(inputId="score_charge_web_editorial", label = "Score :", min =6, max =30, value = score_init_charge_web_editorial)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Chargé(e) développeur(se)' && input.Exclure_emplois.includes('Chargé(e) développeur(se)')",
                               numericInput(inputId="score_charge_developpeur", label = "Score :", min =6, max =30, value = score_init_charge_developpeur)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Chef(fe) de projet appels d offres' && input.Exclure_emplois.includes('Chef(fe) de projet appels d offres')",
                               numericInput(inputId="score_chef_projet_appel_offres", label = "Score :", min =6, max =30, value = score_init_chef_projet_appel_offre)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Chef(fe) de projet SI' && input.Exclure_emplois.includes('Chef(fe) de projet SI')",
                               numericInput(inputId="score_chef_projet_SI", label = "Score :", min =6, max =30, value = score_init_chef_projet_ingenieur_si)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Collecteur(trice) de recettes' && input.Exclure_emplois.includes('Collecteur(trice) de recettes')",
                               numericInput(inputId="score_collecteur_recettes", label = "Score :", min =6, max =30, value = score_init_collecteur_recettes)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Community manager' && input.Exclure_emplois.includes('Community manager')",
                               numericInput(inputId="score_community_manager", label = "Score :", min =6, max =30, value = score_init_community_manager)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Comptable' && input.Exclure_emplois.includes('Comptable')",
                               numericInput(inputId="score_comptable", label = "Score :", min =6, max =30, value = score_init_comptable)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Conducteurs (trices ) bus' && input.Exclure_emplois.includes('Conducteurs (trices ) bus')",
                               numericInput(inputId="score_conducteur_bus", label = "Score :", min =6, max =30, value = score_init_conducteur_bus)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Conducteurs (trices ) métro' && input.Exclure_emplois.includes('Conducteurs (trices ) métro')",
                               numericInput(inputId="score_conducteur_metro", label = "Score :", min =6, max =30, value = score_init_conducteur_metro)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Conducteurs (trices ) polyvalent multimodal' && input.Exclure_emplois.includes('Conducteurs (trices ) polyvalent multimodal')",
                               numericInput(inputId="score_conducteur_polyvalent_multimodal", label = "Score :", min =6, max =30, value = score_init_conducteur_multimodal)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Conducteurs (trices ) polyvalent vérificateur / agent commercial' && input.Exclure_emplois.includes('Conducteurs (trices ) polyvalent vérificateur / agent commercial')",
                               numericInput(inputId="score_conducteur_polyvalent_verificateur_agent_commercial", label = "Score :", min =6, max =30, value = score_init_conducteur_receveur)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Conducteurs (trices ) pour PMR / TAD' && input.Exclure_emplois.includes('Conducteurs (trices ) pour PMR / TAD')",
                               numericInput(inputId="score_conducteur_pmr_tad", label = "Score :", min =6, max =30, value = score_init_conducteur_mobilite_reduite)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Conducteurs (trices ) tram' && input.Exclure_emplois.includes('Conducteurs (trices ) tram')",
                               numericInput(inputId="score_conducteur_tram", label = "Score :", min =6, max =30, value = score_init_conducteur_receveur)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Conseiller(ère) commercial(e)' && input.Exclure_emplois.includes('Conseiller(ère) commercial(e)')",
                               numericInput(inputId="score_conseiller_commercial", label = "Score :", min =6, max =30, value = score_init_conseiller_commercial)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Contrôleur(euse) de gestion' && input.Exclure_emplois.includes('Contrôleur(euse) de gestion')",
                               numericInput(inputId="score_controleur_gestion", label = "Score :", min =6, max =30, value = score_init_controleur_gestion)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Formateur(trice)' && input.Exclure_emplois.includes('Formateur(trice)')",
                               numericInput(inputId="score_formateur", label = "Score :", min =6, max =30, value = score_init_formateur)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Gestionnaire d assurance' && input.Exclure_emplois.includes('Gestionnaire d assurance')",
                               numericInput(inputId="score_gestionnaire_assurance", label = "Score :", min =6, max =30, value = score_init_gestionnaire_assurance)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Gestionnaire d approvisionnement et/ou de stock' && input.Exclure_emplois.includes('Gestionnaire d approvisionnement et/ou de stock')",
                               numericInput(inputId="score_gestionnaire_approvisionnement_stock", label = "Score :", min =6, max =30, value = score_init_gestionnaire_approvisionnement_stock)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Gestionnaire de paie' && input.Exclure_emplois.includes('Gestionnaire de paie')",
                               numericInput(inputId="score_gestionnaire_paie", label = "Score :", min =6, max =30, value = score_init_gestionnaire_paie)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Gestionnaire de parc vélo' && input.Exclure_emplois.includes('Gestionnaire de parc vélo')",
                               numericInput(inputId="score_gestionnaire_parc_velo", label = "Score :", min =6, max =30, value = score_init_gestionnaire_parc_velo)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Gestionnaire des contrats' && input.Exclure_emplois.includes('Gestionnaire des contrats')",
                               numericInput(inputId="score_gestionnaire_contrats", label = "Score :", min =6, max =30, value = score_init_gestionnaire_contrats)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Infographiste' && input.Exclure_emplois.includes('Infographiste')",
                               numericInput(inputId="score_infographiste", label = "Score :", min =6, max =30, value = score_init_infographiste)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Ingénieur(e) cybersécurité' && input.Exclure_emplois.includes('Ingénieur(e) cybersécurité')",
                               numericInput(inputId="score_ingenieur_cybersecurite", label = "Score :", min =6, max =30, value = score_init_ingenieur_cybersecurite)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Ingénieur(e) de maintenance' && input.Exclure_emplois.includes('Ingénieur(e) de maintenance')",
                               numericInput(inputId="score_ingenieur_maintenance", label = "Score :", min =6, max =30, value = score_init_ingenieur_maintenance)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Ingénieur(e) des méthodes de maintenance' && input.Exclure_emplois.includes('Ingénieur(e) des méthodes de maintenance')",
                               numericInput(inputId="score_ingenieur_methodes_maintenance", label = "Score :", min =6, max =30, value = score_init_ingenieur_methodes)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Ingénieur(e) financier(ère)' && input.Exclure_emplois.includes('Ingénieur(e) financier(ère)')",
                               numericInput(inputId="score_ingenieur_financier", label = "Score :", min =6, max =30, value = score_init_ingenieur_financier)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Juriste' && input.Exclure_emplois.includes('Juriste')",
                               numericInput(inputId="score_juriste", label = "Score :", min =6, max =30, value = score_init_juriste)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Manager de conducteurs (trices)' && input.Exclure_emplois.includes('Manager de conducteurs (trices)')",
                               numericInput(inputId="score_manager_conducteurs", label = "Score :", min =6, max =30, value = score_init_manager_conducteur)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Manager de conseillers(ères) commerciaux(ales)' && input.Exclure_emplois.includes('Manager de conseillers(ères) commerciaux(ales)')",
                               numericInput(inputId="score_manager_conseiller_commercial", label = "Score :", min =6, max =30, value = score_init_manager_conseiller_commerciaux)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Manager de techniciens de maintenance' && input.Exclure_emplois.includes('Manager de techniciens de maintenance')",
                               numericInput(inputId="score_manager_techniciens_maintenance", label = "Score :", min =6, max =30, value = score_init_manager_technicien_maintenance)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Manager de techniciens de maintenance parc' && input.Exclure_emplois.includes('Manager de techniciens de maintenance parc')",
                               numericInput(inputId="score_manager_techniciens_maintenance_parc", label = "Score :", min =6, max =30, value = score_init_manager_technicien_maintenance_parc)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Manager de vérificateurs (trices)' && input.Exclure_emplois.includes('Manager de vérificateurs (trices)')",
                               numericInput(inputId="score_manager_verificateurs", label = "Score :", min =6, max =30, value = score_init_manager_verificateur)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Manager équipe agent de sûreté' && input.Exclure_emplois.includes('Manager équipe agent de sûreté')",
                               numericInput(inputId="score_manager_equipe_agents_surete", label = "Score :", min =6, max =30, value = score_init_manager_equipe_agent_surete)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Médiateur(trice)' && input.Exclure_emplois.includes('Médiateur(trice)')",
                               numericInput(inputId="score_mediateur", label = "Score :", min =6, max =30, value = score_init_mediateur)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Opérateur (trice) PC sûreté' && input.Exclure_emplois.includes('Opérateur (trice) PC sûreté')",
                               numericInput(inputId="score_operateur_pc_surete", label = "Score :", min =6, max =30, value = score_init_operateur_pc_surete)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Opérateur(trice) technique informations voyageurs' && input.Exclure_emplois.includes('Opérateur(trice) technique informations voyageurs')",
                               numericInput(inputId="score_operateur_technique_informations_voyageurs", label = "Score :", min =6, max =30, value = score_init_operateur_technique_information_voyageur)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Régulateur(trice)' && input.Exclure_emplois.includes('Régulateur(trice)')",
                               numericInput(inputId="score_regulateur", label = "Score :", min =6, max =30, value = score_init_regulateur)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Responsable administratif(ve) et financier(ère)' && input.Exclure_emplois.includes('Responsable administratif(ve) et financier(ère)')",
                               numericInput(inputId="score_responsable_administrateur_financier", label = "Score :", min =6, max =30, value = score_init_responsable_administratif_financier)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Responsable approvisionnement et/ou de stock' && input.Exclure_emplois.includes('Responsable approvisionnement et/ou de stock')",
                               numericInput(inputId="score_responsable_approvisionnement_stock", label = "Score :", min =6, max =30, value = score_init_responsable_approvisionnement_gestion_stocks)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Responsable commercial(e)' && input.Exclure_emplois.includes('Responsable commercial(e)')",
                               numericInput(inputId="score_responsable_commercial", label = "Score :", min =6, max =30, value = score_init_responsable_agent_commercial)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Responsable communication' && input.Exclure_emplois.includes('Responsable communication')",
                               numericInput(inputId="score_responsable_communication", label = "Score :", min =6, max =30, value = score_init_responsable_communication)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Responsable Comptabilités' && input.Exclure_emplois.includes('Responsable Comptabilités')",
                               numericInput(inputId="score_responsable_comptabilite", label = "Score :", min =6, max =30, value = score_init_responsable_comptabilite)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Responsable d équipe d achat /commande publique' && input.Exclure_emplois.includes('Responsable d équipe d achat /commande publique')",
                               numericInput(inputId="score_responsable_equipe_achat_commande_publique", label = "Score :", min =6, max =30, value = score_init_responsable_equipe_achat_commande_publique)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Responsable d exploitation' && input.Exclure_emplois.includes('Responsable d exploitation')",
                               numericInput(inputId="score_responsable_exploitation", label = "Score :", min =6, max =30, value = score_init_responsable_exploitation)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Responsable de formation' && input.Exclure_emplois.includes('Responsable de formation')",
                               numericInput(inputId="score_responsable_formation", label = "Score :", min =6, max =30, value = score_init_responsable_formation)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Responsable de la maintenance' && input.Exclure_emplois.includes('Responsable de la maintenance')",
                               numericInput(inputId="score_responsable_maintenance", label = "Score :", min =6, max =30, value = score_init_responsable_maintenance)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Responsable de production / opération' && input.Exclure_emplois.includes('Responsable de production / opération')",
                               numericInput(inputId="score_responsable_production_operation", label = "Score :", min =6, max =30, value = score_init_responsable_production_operation)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Responsable de société' && input.Exclure_emplois.includes('Responsable de société')",
                               numericInput(inputId="score_responsable_societe", label = "Score :", min =6, max =30, value = score_init_responsable_societe)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Responsable des SI' && input.Exclure_emplois.includes('Responsable des SI')",
                               numericInput(inputId="score_responsable_SI", label = "Score :", min =6, max =30, value = score_init_responsable_Si)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Responsable du bureu d études et/ou méthoides d exploitation' && input.Exclure_emplois.includes('Responsable du bureu d études et/ou méthoides d exploitation')",
                               numericInput(inputId="score_responsable_bureau_etudes_methodes_exploitation", label = "Score :", min =6, max =30, value = score_init_responsable_bureau_etudes_methodes)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Responsable du service client' && input.Exclure_emplois.includes('Responsable du service client')",
                               numericInput(inputId="score_responsable_service_client", label = "Score :", min =6, max =30, value = score_init_responsable_service_client)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Responsable fraude' && input.Exclure_emplois.includes('Responsable fraude')",
                               numericInput(inputId="score_responsable_fraude", label = "Score :", min =6, max =30, value = score_init_responsable_fraude)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Responsable RSE' && input.Exclure_emplois.includes('Responsable RSE')",
                               numericInput(inputId="score_responsable_RSE", label = "Score :", min =6, max =30, value = score_init_responsable_RSE)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Responsable juridique' && input.Exclure_emplois.includes('Responsable juridique')",
                               numericInput(inputId="score_responsable_juridique", label = "Score :", min =6, max =30, value = score_init_responsable_juridique)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Responsable marketing' && input.Exclure_emplois.includes('Responsable marketing')",
                               numericInput(inputId="score_responsable_marketing", label = "Score :", min =6, max =30, value = score_init_responsable_marketing)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Responsable performance opérationnelle' && input.Exclure_emplois.includes('Responsable performance opérationnelle')",
                               numericInput(inputId="score_responsable_performance_operationnelle", label = "Score :", min =6, max =30, value = score_init_responsable_performance_operationnelle)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Responsable qualité' && input.Exclure_emplois.includes('Responsable qualité')",
                               numericInput(inputId="score_responsable_qualite", label = "Score :", min =6, max =30, value = score_init_responsable_qualite)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Responsable relations institutionnelles' && input.Exclure_emplois.includes('Responsable relations institutionnelles')",
                               numericInput(inputId="score_relations_institutionnelles", label = "Score :", min =6, max =30, value = score_init_responsable_relations_institutionnelles)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Responsable RH' && input.Exclure_emplois.includes('Responsable RH')",
                               numericInput(inputId="score_responsable_rh", label = "Score :", min =6, max =30, value = score_init_responsable_rh)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Responsable HSE' && input.Exclure_emplois.includes('Responsable HSE')",
                               numericInput(inputId="score_responsable_HSE", label = "Score :", min =6, max =30, value = score_init_responsable_HSE)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Responsable secteur' && input.Exclure_emplois.includes('Responsable secteur')",
                               numericInput(inputId="score_responsable_secteur", label = "Score :", min =6, max =30, value = score_init_responsable_secteur)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Responsable sécurité prévention' && input.Exclure_emplois.includes('Responsable sécurité prévention')",
                               numericInput(inputId="score_responsable_securite_prevention", label = "Score :", min =6, max =30, value = score_init_responsable_securite_prevention)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Responsable appels d offres' && input.Exclure_emplois.includes('Responsable appels d offres')",
                               numericInput(inputId="score_responsable_appels_offre", label = "Score :", min =6, max =30, value = score_init_responsable_appel_offre)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Technicien (ne) de maintenance parc' && input.Exclure_emplois.includes('Technicien (ne) de maintenance parc')",
                               numericInput(inputId="score_technicien_maintenance_parc", label = "Score :", min =6, max =30, value = score_init_technicien_maintenance_parc)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Technicien(ne) d exploitation' && input.Exclure_emplois.includes('Technicien(ne) d exploitation')",
                               numericInput(inputId="score_technicien_exploitation", label = "Score :", min =6, max =30, value = score_init_technicien_exploitation)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Technicien(ne) de maintenance' && input.Exclure_emplois.includes('Technicien(ne) de maintenance')",
                               numericInput(inputId="score_technicien_maintenance", label = "Score :", min =6, max =30, value = score_init_technicien_maintenance)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Technicien(ne) des méthodes de maintenance' && input.Exclure_emplois.includes('Technicien(ne) des méthodes de maintenance')",
                               numericInput(inputId="score_technicien_methodes_maintenance", label = "Score :", min =6, max =30, value = score_init_technicien_methode)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Technicien(ne) intervention systèmes automatiques/autonomes' && input.Exclure_emplois.includes('Technicien(ne) intervention systèmes automatiques/autonomes')",
                               numericInput(inputId="score_technicien_intervention_systemes_automatiques_autonomes", label = "Score :", min =6, max =30, value = score_init_technicien_intervention_systeme_automatique_autonome)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Technicien(ne) supérieur(e) d exploitation' && input.Exclure_emplois.includes('Technicien(ne) supérieur(e) d exploitation')",
                               numericInput(inputId="score_technicien_superieur_exploitation", label = "Score :", min =6, max =30, value = score_init_technicien_exploitation)
              ),
              conditionalPanel(condition = "input.choix_emploi_repere == 'Vérificateur (trice)' && input.Exclure_emplois.includes('Vérificateur (trice)')",
                               numericInput(inputId="score_verificateur", label = "Score :", min =6, max =30, value = score_init_verificateur)
              )),
            
            fluidRow(column(width = 6, downloadButton(outputId = "dl_scores_emploi_reperes_sliders", label = "Exporter les scores", class = "btn-default", style = "width:100%;")),
                     column(width = 6, actionButton(inputId = "reset_scores_lib_emploi", label = "Réinitialiser",icon = icon('arrows-rotate'), style = "width:100%;", class = "btn-success"))),

            fluidRow(column(width = 12, fileInput(inputId = "up_scores_emplois_reperes_sliders", label = NULL, buttonLabel = tags$span(icon("upload"), "Importer un scénario de scores (fichier .xlsx)"), width = "100%",
                                                  placeholder = "Aucun fichier séléctionné", accept=".xlsx")))

        )
        ,
        

        
        box(
          width=12,
          title="Groupes d'emploi",
          status="warning",
          solidHeader = TRUE,
          collapsible=TRUE,
          collapsed = FALSE,          
          
          sliderInput(inputId="custom_number_classifications", label="Choix du nombre de groupes :", min=8, max=25, value=25, step=1),
          
          conditionalPanel(
            condition = "input.custom_number_classifications == 8",
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_8_A", label= "Score plafond A :", min = 6, max=30, value = plafond_init_8_A)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_8_B", label= "Score plafond B :", min = 6, max=30, value = plafond_init_8_B)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_8_C", label= "Score plafond C :", min = 6, max=30, value = plafond_init_8_C)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_8_D", label= "Score plafond D :", min = 6, max=30, value = plafond_init_8_D)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_8_E", label= "Score plafond E :", min = 6, max=30, value = plafond_init_8_E)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_8_F", label= "Score plafond F :", min = 6, max=30, value = plafond_init_8_F)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_8_G", label= "Score plafond G :", min = 6, max=30, value = plafond_init_8_G)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_8_H", label= "Score plafond H :", min = 6, max=30, value = plafond_init_8_H)
              )
            )
            
          ),
          conditionalPanel(
            condition = "input.custom_number_classifications == 9",
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_9_A", label= "Score plafond A :", min = 6, max=30, value = plafond_init_9_A)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_9_B", label= "Score plafond B :", min = 6, max=30, value = plafond_init_9_B)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_9_C", label= "Score plafond C :", min = 6, max=30, value = plafond_init_9_C)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_9_D", label= "Score plafond D :", min = 6, max=30, value = plafond_init_9_D)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_9_E", label= "Score plafond E :", min = 6, max=30, value = plafond_init_9_E)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_9_F", label= "Score plafond F :", min = 6, max=30, value = plafond_init_9_F)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_9_G", label= "Score plafond G :", min = 6, max=30, value = plafond_init_9_G)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_9_H", label= "Score plafond H :", min = 6, max=30, value = plafond_init_9_H)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_9_I", label= "Score plafond I :", min = 6, max=30, value = plafond_init_9_I)
              )
            )
            
          ),conditionalPanel(
            condition = "input.custom_number_classifications == 10",
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_10_A", label= "Score plafond A :", min = 6, max=30, value = plafond_init_10_A)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_10_B", label= "Score plafond B :", min = 6, max=30, value = plafond_init_10_B)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_10_C", label= "Score plafond C :", min = 6, max=30, value = plafond_init_10_C)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_10_D", label= "Score plafond D :", min = 6, max=30, value = plafond_init_10_D)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_10_E", label= "Score plafond E :", min = 6, max=30, value = plafond_init_10_E)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_10_F", label= "Score plafond F :", min = 6, max=30, value = plafond_init_10_F)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_10_G", label= "Score plafond G :", min = 6, max=30, value = plafond_init_10_G)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_10_H", label= "Score plafond H :", min = 6, max=30, value = plafond_init_10_H)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_10_I", label= "Score plafond I :", min = 6, max=30, value = plafond_init_10_I)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_10_J", label= "Score plafond J :", min = 6, max=30, value = plafond_init_10_J)
              )
            )
            
          ),
          conditionalPanel(
            condition = "input.custom_number_classifications == 11",
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_11_A", label= "Score plafond A :", min = 6, max=30, value = plafond_init_11_A)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_11_B", label= "Score plafond B :", min = 6, max=30, value = plafond_init_11_B)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_11_C", label= "Score plafond C :", min = 6, max=30, value = plafond_init_11_C)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_11_D", label= "Score plafond D :", min = 6, max=30, value = plafond_init_11_D)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_11_E", label= "Score plafond E :", min = 6, max=30, value = plafond_init_11_E)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_11_F", label= "Score plafond F :", min = 6, max=30, value = plafond_init_11_F)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_11_G", label= "Score plafond G :", min = 6, max=30, value = plafond_init_11_G)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_11_H", label= "Score plafond H :", min = 6, max=30, value = plafond_init_11_H)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_11_I", label= "Score plafond I :", min = 6, max=30, value = plafond_init_11_I)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_11_J", label= "Score plafond J :", min = 6, max=30, value = plafond_init_11_J)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_11_K", label= "Score plafond K :", min = 6, max=30, value = plafond_init_11_K)
              )
            )
            
          ),
          conditionalPanel(
            condition = "input.custom_number_classifications == 12",
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_12_A", label= "Score plafond A :", min = 6, max=30, value = plafond_init_12_A)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_12_B", label= "Score plafond B :", min = 6, max=30, value = plafond_init_12_B)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_12_C", label= "Score plafond C :", min = 6, max=30, value = plafond_init_12_C)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_12_D", label= "Score plafond D :", min = 6, max=30, value = plafond_init_12_D)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_12_E", label= "Score plafond E :", min = 6, max=30, value = plafond_init_12_E)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_12_F", label= "Score plafond F :", min = 6, max=30, value = plafond_init_12_F)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_12_G", label= "Score plafond G :", min = 6, max=30, value = plafond_init_12_G)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_12_H", label= "Score plafond H :", min = 6, max=30, value = plafond_init_12_H)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_12_I", label= "Score plafond I :", min = 6, max=30, value = plafond_init_12_I)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_12_J", label= "Score plafond J :", min = 6, max=30, value = plafond_init_12_J)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_12_K", label= "Score plafond K :", min = 6, max=30, value = plafond_init_12_K)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_12_L", label= "Score plafond L :", min = 6, max=30, value = plafond_init_12_L)
              )
            )
            
          ),
          conditionalPanel(
            condition = "input.custom_number_classifications == 13",
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_13_A", label= "Score plafond A :", min = 6, max=30, value = plafond_init_13_A)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_13_B", label= "Score plafond B :", min = 6, max=30, value = plafond_init_13_B)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_13_C", label= "Score plafond C :", min = 6, max=30, value = plafond_init_13_C)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_13_D", label= "Score plafond D :", min = 6, max=30, value = plafond_init_13_D)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_13_E", label= "Score plafond E :", min = 6, max=30, value = plafond_init_13_E)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_13_F", label= "Score plafond F :", min = 6, max=30, value = plafond_init_13_F)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_13_G", label= "Score plafond G :", min = 6, max=30, value = plafond_init_13_G)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_13_H", label= "Score plafond H :", min = 6, max=30, value = plafond_init_13_H)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_13_I", label= "Score plafond I :", min = 6, max=30, value = plafond_init_13_I)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_13_J", label= "Score plafond J :", min = 6, max=30, value = plafond_init_13_J)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_13_K", label= "Score plafond K :", min = 6, max=30, value = plafond_init_13_K)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_13_L", label= "Score plafond L :", min = 6, max=30, value = plafond_init_13_L)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_13_M", label= "Score plafond M :", min = 6, max=30, value = plafond_init_13_M)
              )
            )
            
          ),
          conditionalPanel(
            condition = "input.custom_number_classifications == 14",
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_14_A", label= "Score plafond A :", min = 6, max=30, value = plafond_init_14_A)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_14_B", label= "Score plafond B :", min = 6, max=30, value = plafond_init_14_B)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_14_C", label= "Score plafond C :", min = 6, max=30, value = plafond_init_14_C)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_14_D", label= "Score plafond D :", min = 6, max=30, value = plafond_init_14_D)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_14_E", label= "Score plafond E :", min = 6, max=30, value = plafond_init_14_E)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_14_F", label= "Score plafond F :", min = 6, max=30, value = plafond_init_14_F)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_14_G", label= "Score plafond G :", min = 6, max=30, value = plafond_init_14_G)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_14_H", label= "Score plafond H :", min = 6, max=30, value = plafond_init_14_H)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_14_I", label= "Score plafond I :", min = 6, max=30, value = plafond_init_14_I)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_14_J", label= "Score plafond J :", min = 6, max=30, value = plafond_init_14_J)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_14_K", label= "Score plafond K :", min = 6, max=30, value = plafond_init_14_K)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_14_L", label= "Score plafond L :", min = 6, max=30, value = plafond_init_14_L)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_14_M", label= "Score plafond M :", min = 6, max=30, value = plafond_init_14_M)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_14_N", label= "Score plafond N :", min = 6, max=30, value = plafond_init_14_N)
              )
            )
            
          ),
          conditionalPanel(
            condition = "input.custom_number_classifications == 15",
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_15_A", label= "Score plafond A :", min = 6, max=30, value = plafond_init_15_A)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_15_B", label= "Score plafond B :", min = 6, max=30, value = plafond_init_15_B)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_15_C", label= "Score plafond C :", min = 6, max=30, value = plafond_init_15_C)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_15_D", label= "Score plafond D :", min = 6, max=30, value = plafond_init_15_D)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_15_E", label= "Score plafond E :", min = 6, max=30, value = plafond_init_15_E)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_15_F", label= "Score plafond F :", min = 6, max=30, value = plafond_init_15_F)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_15_G", label= "Score plafond G :", min = 6, max=30, value = plafond_init_15_G)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_15_H", label= "Score plafond H :", min = 6, max=30, value = plafond_init_15_H)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_15_I", label= "Score plafond I :", min = 6, max=30, value = plafond_init_15_I)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_15_J", label= "Score plafond J :", min = 6, max=30, value = plafond_init_15_J)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_15_K", label= "Score plafond K :", min = 6, max=30, value = plafond_init_15_K)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_15_L", label= "Score plafond L :", min = 6, max=30, value = plafond_init_15_L)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_15_M", label= "Score plafond M :", min = 6, max=30, value = plafond_init_15_M)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_15_N", label= "Score plafond N :", min = 6, max=30, value = plafond_init_15_N)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_15_O", label= "Score plafond O :", min = 6, max=30, value = plafond_init_15_O)
              )
            )
            
          ),
          conditionalPanel(
            condition = "input.custom_number_classifications == 16",
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_16_A", label= "Score plafond A :", min = 6, max=30, value = plafond_init_16_A)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_16_B", label= "Score plafond B :", min = 6, max=30, value = plafond_init_16_B)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_16_C", label= "Score plafond C :", min = 6, max=30, value = plafond_init_16_C)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_16_D", label= "Score plafond D :", min = 6, max=30, value = plafond_init_16_D)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_16_E", label= "Score plafond E :", min = 6, max=30, value = plafond_init_16_E)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_16_F", label= "Score plafond F :", min = 6, max=30, value = plafond_init_16_F)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_16_G", label= "Score plafond G :", min = 6, max=30, value = plafond_init_16_G)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_16_H", label= "Score plafond H :", min = 6, max=30, value = plafond_init_16_H)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_16_I", label= "Score plafond I :", min = 6, max=30, value = plafond_init_16_I)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_16_J", label= "Score plafond J :", min = 6, max=30, value = plafond_init_16_J)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_16_K", label= "Score plafond K :", min = 6, max=30, value = plafond_init_16_K)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_16_L", label= "Score plafond L :", min = 6, max=30, value = plafond_init_16_L)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_16_M", label= "Score plafond M :", min = 6, max=30, value = plafond_init_16_M)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_16_N", label= "Score plafond N :", min = 6, max=30, value = plafond_init_16_N)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_16_O", label= "Score plafond O :", min = 6, max=30, value = plafond_init_16_O)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_16_P", label= "Score plafond P :", min = 6, max=30, value = plafond_init_16_P)
              )
            )
            
          ),
          conditionalPanel(
            condition = "input.custom_number_classifications == 17",
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_17_A", label= "Score plafond A :", min = 6, max=30, value = plafond_init_17_A)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_17_B", label= "Score plafond B :", min = 6, max=30, value = plafond_init_17_B)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_17_C", label= "Score plafond C :", min = 6, max=30, value = plafond_init_17_C)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_17_D", label= "Score plafond D :", min = 6, max=30, value = plafond_init_17_D)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_17_E", label= "Score plafond E :", min = 6, max=30, value = plafond_init_17_E)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_17_F", label= "Score plafond F :", min = 6, max=30, value = plafond_init_17_F)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_17_G", label= "Score plafond G :", min = 6, max=30, value = plafond_init_17_G)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_17_H", label= "Score plafond H :", min = 6, max=30, value = plafond_init_17_H)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_17_I", label= "Score plafond I :", min = 6, max=30, value = plafond_init_17_I)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_17_J", label= "Score plafond J :", min = 6, max=30, value = plafond_init_17_J)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_17_K", label= "Score plafond K :", min = 6, max=30, value = plafond_init_17_K)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_17_L", label= "Score plafond L :", min = 6, max=30, value = plafond_init_17_L)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_17_M", label= "Score plafond M :", min = 6, max=30, value = plafond_init_17_M)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_17_N", label= "Score plafond N :", min = 6, max=30, value = plafond_init_17_N)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_17_O", label= "Score plafond O :", min = 6, max=30, value = plafond_init_17_O)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_17_P", label= "Score plafond P :", min = 6, max=30, value = plafond_init_17_P)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_17_Q", label= "Score plafond Q :", min = 6, max=30, value = plafond_init_17_Q)
              )
            )
            
          ),
          conditionalPanel(
            condition = "input.custom_number_classifications == 18",
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_18_A", label= "Score plafond A :", min = 6, max=30, value = plafond_init_18_A)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_18_B", label= "Score plafond B :", min = 6, max=30, value = plafond_init_18_B)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_18_C", label= "Score plafond C :", min = 6, max=30, value = plafond_init_18_C)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_18_D", label= "Score plafond D :", min = 6, max=30, value = plafond_init_18_D)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_18_E", label= "Score plafond E :", min = 6, max=30, value = plafond_init_18_E)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_18_F", label= "Score plafond F :", min = 6, max=30, value = plafond_init_18_F)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_18_G", label= "Score plafond G :", min = 6, max=30, value = plafond_init_18_G)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_18_H", label= "Score plafond H :", min = 6, max=30, value = plafond_init_18_H)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_18_I", label= "Score plafond I :", min = 6, max=30, value = plafond_init_18_I)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_18_J", label= "Score plafond J :", min = 6, max=30, value = plafond_init_18_J)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_18_K", label= "Score plafond K :", min = 6, max=30, value = plafond_init_18_K)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_18_L", label= "Score plafond L :", min = 6, max=30, value = plafond_init_18_L)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_18_M", label= "Score plafond M :", min = 6, max=30, value = plafond_init_18_M)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_18_N", label= "Score plafond N :", min = 6, max=30, value = plafond_init_18_N)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_18_O", label= "Score plafond O :", min = 6, max=30, value = plafond_init_18_O)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_18_P", label= "Score plafond P :", min = 6, max=30, value = plafond_init_18_P)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_18_Q", label= "Score plafond Q :", min = 6, max=30, value = plafond_init_18_Q)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_18_R", label= "Score plafond R :", min = 6, max=30, value = plafond_init_18_R)
              )
            )
            
          ),
          conditionalPanel(
            condition = "input.custom_number_classifications == 19",
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_19_A", label= "Score plafond A :", min = 6, max=30, value = plafond_init_19_A)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_19_B", label= "Score plafond B :", min = 6, max=30, value = plafond_init_19_B)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_19_C", label= "Score plafond C :", min = 6, max=30, value = plafond_init_19_C)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_19_D", label= "Score plafond D :", min = 6, max=30, value = plafond_init_19_D)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_19_E", label= "Score plafond E :", min = 6, max=30, value = plafond_init_19_E)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_19_F", label= "Score plafond F :", min = 6, max=30, value = plafond_init_19_F)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_19_G", label= "Score plafond G :", min = 6, max=30, value = plafond_init_19_G)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_19_H", label= "Score plafond H :", min = 6, max=30, value = plafond_init_19_H)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_19_I", label= "Score plafond I :", min = 6, max=30, value = plafond_init_19_I)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_19_J", label= "Score plafond J :", min = 6, max=30, value = plafond_init_19_J)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_19_K", label= "Score plafond K :", min = 6, max=30, value = plafond_init_19_K)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_19_L", label= "Score plafond L :", min = 6, max=30, value = plafond_init_19_L)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_19_M", label= "Score plafond M :", min = 6, max=30, value = plafond_init_19_M)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_19_N", label= "Score plafond N :", min = 6, max=30, value = plafond_init_19_N)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_19_O", label= "Score plafond O :", min = 6, max=30, value = plafond_init_19_O)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_19_P", label= "Score plafond P :", min = 6, max=30, value = plafond_init_19_P)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_19_Q", label= "Score plafond Q :", min = 6, max=30, value = plafond_init_19_Q)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_19_R", label= "Score plafond R :", min = 6, max=30, value = plafond_init_19_R)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_19_S", label= "Score plafond S :", min = 6, max=30, value = plafond_init_19_S)
              )
            )
            
          ),
          
          conditionalPanel(
            condition = "input.custom_number_classifications == 20",
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_20_A", label= "Score plafond A :", min = 6, max=30, value = plafond_init_20_A)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_20_B", label= "Score plafond B :", min = 6, max=30, value = plafond_init_20_B)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_20_C", label= "Score plafond C :", min = 6, max=30, value = plafond_init_20_C)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_20_D", label= "Score plafond D :", min = 6, max=30, value = plafond_init_20_D)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_20_E", label= "Score plafond E :", min = 6, max=30, value = plafond_init_20_E)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_20_F", label= "Score plafond F :", min = 6, max=30, value = plafond_init_20_F)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_20_G", label= "Score plafond G :", min = 6, max=30, value = plafond_init_20_G)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_20_H", label= "Score plafond H :", min = 6, max=30, value = plafond_init_20_H)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_20_I", label= "Score plafond I :", min = 6, max=30, value = plafond_init_20_I)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_20_J", label= "Score plafond J :", min = 6, max=30, value = plafond_init_20_J)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_20_K", label= "Score plafond K :", min = 6, max=30, value = plafond_init_20_K)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_20_L", label= "Score plafond L :", min = 6, max=30, value = plafond_init_20_L)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_20_M", label= "Score plafond M :", min = 6, max=30, value = plafond_init_20_M)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_20_N", label= "Score plafond N :", min = 6, max=30, value = plafond_init_20_N)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_20_O", label= "Score plafond O :", min = 6, max=30, value = plafond_init_20_O)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_20_P", label= "Score plafond P :", min = 6, max=30, value = plafond_init_20_P)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_20_Q", label= "Score plafond Q :", min = 6, max=30, value = plafond_init_20_Q)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_20_R", label= "Score plafond R :", min = 6, max=30, value = plafond_init_20_R)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_20_S", label= "Score plafond S :", min = 6, max=30, value = plafond_init_20_S)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_20_T", label= "Score plafond T :", min = 6, max=30, value = plafond_init_20_T)
              )
            )
            
          ),
          
          conditionalPanel(
            condition = "input.custom_number_classifications == 21",
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_21_A", label= "Score plafond A :", min = 5, max=30, value = plafond_init_21_A)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_21_B", label= "Score plafond B :", min = 6, max=30, value = plafond_init_21_B)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_21_C", label= "Score plafond C :", min = 6, max=30, value = plafond_init_21_C)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_21_D", label= "Score plafond D :", min = 6, max=30, value = plafond_init_21_D)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_21_E", label= "Score plafond E :", min = 6, max=30, value = plafond_init_21_E)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_21_F", label= "Score plafond F :", min = 6, max=30, value = plafond_init_21_F)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_21_G", label= "Score plafond G :", min = 6, max=30, value = plafond_init_21_G)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_21_H", label= "Score plafond H :", min = 6, max=30, value = plafond_init_21_H)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_21_I", label= "Score plafond I :", min = 6, max=30, value = plafond_init_21_I)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_21_J", label= "Score plafond J :", min = 6, max=30, value = plafond_init_21_J)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_21_K", label= "Score plafond K :", min = 6, max=30, value = plafond_init_21_K)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_21_L", label= "Score plafond L :", min = 6, max=30, value = plafond_init_21_L)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_21_M", label= "Score plafond M :", min = 6, max=30, value = plafond_init_21_M)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_21_N", label= "Score plafond N :", min = 6, max=30, value = plafond_init_21_N)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_21_O", label= "Score plafond O :", min = 6, max=30, value = plafond_init_21_O)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_21_P", label= "Score plafond P :", min = 6, max=30, value = plafond_init_21_P)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_21_Q", label= "Score plafond Q :", min = 6, max=30, value = plafond_init_21_Q)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_21_R", label= "Score plafond R :", min = 6, max=30, value = plafond_init_21_R)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_21_S", label= "Score plafond S :", min = 6, max=30, value = plafond_init_21_S)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_21_T", label= "Score plafond T :", min = 6, max=30, value = plafond_init_21_T)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_21_U", label= "Score plafond U :", min = 6, max=30, value = plafond_init_21_U)
              )
            )
            
          ),
          conditionalPanel(
            condition = "input.custom_number_classifications == 22",
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_22_A", label= "Score plafond A :", min = 5, max=30, value = plafond_init_22_A)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_22_B", label= "Score plafond B :", min = 6, max=30, value = plafond_init_22_B)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_22_C", label= "Score plafond C :", min = 6, max=30, value = plafond_init_22_C)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_22_D", label= "Score plafond D :", min = 6, max=30, value = plafond_init_22_D)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_22_E", label= "Score plafond E :", min = 6, max=30, value = plafond_init_22_E)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_22_F", label= "Score plafond F :", min = 6, max=30, value = plafond_init_22_F)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_22_G", label= "Score plafond G :", min = 6, max=30, value = plafond_init_22_G)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_22_H", label= "Score plafond H :", min = 6, max=30, value = plafond_init_22_H)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_22_I", label= "Score plafond I :", min = 6, max=30, value = plafond_init_22_I)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_22_J", label= "Score plafond J :", min = 6, max=30, value = plafond_init_22_J)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_22_K", label= "Score plafond K :", min = 6, max=30, value = plafond_init_22_K)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_22_L", label= "Score plafond L :", min = 6, max=30, value = plafond_init_22_L)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_22_M", label= "Score plafond M :", min = 6, max=30, value = plafond_init_22_M)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_22_N", label= "Score plafond N :", min = 6, max=30, value = plafond_init_22_N)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_22_O", label= "Score plafond O :", min = 6, max=30, value = plafond_init_22_O)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_22_P", label= "Score plafond P :", min = 6, max=30, value = plafond_init_22_P)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_22_Q", label= "Score plafond Q :", min = 6, max=30, value = plafond_init_22_Q)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_22_R", label= "Score plafond R :", min = 6, max=30, value = plafond_init_22_R)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_22_S", label= "Score plafond S :", min = 6, max=30, value = plafond_init_22_S)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_22_T", label= "Score plafond T :", min = 6, max=30, value = plafond_init_22_T)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_22_U", label= "Score plafond U :", min = 6, max=30, value = plafond_init_22_U)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_22_V", label= "Score plafond V :", min = 6, max=30, value = plafond_init_22_V)
              )
            )

          ),
          conditionalPanel(
            condition = "input.custom_number_classifications == 23",
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_23_A", label= "Score plafond A :", min = 5, max=30, value = plafond_init_23_A)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_23_B", label= "Score plafond B :", min = 6, max=30, value = plafond_init_23_B)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_23_C", label= "Score plafond C :", min = 6, max=30, value = plafond_init_23_C)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_23_D", label= "Score plafond D :", min = 6, max=30, value = plafond_init_23_D)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_23_E", label= "Score plafond E :", min = 6, max=30, value = plafond_init_23_E)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_23_F", label= "Score plafond F :", min = 6, max=30, value = plafond_init_23_F)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_23_G", label= "Score plafond G :", min = 6, max=30, value = plafond_init_23_G)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_23_H", label= "Score plafond H :", min = 6, max=30, value = plafond_init_23_H)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_23_I", label= "Score plafond I :", min = 6, max=30, value = plafond_init_23_I)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_23_J", label= "Score plafond J :", min = 6, max=30, value = plafond_init_23_J)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_23_K", label= "Score plafond K :", min = 6, max=30, value = plafond_init_23_K)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_23_L", label= "Score plafond L :", min = 6, max=30, value = plafond_init_23_L)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_23_M", label= "Score plafond M :", min = 6, max=30, value = plafond_init_23_M)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_23_N", label= "Score plafond N :", min = 6, max=30, value = plafond_init_23_N)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_23_O", label= "Score plafond O :", min = 6, max=30, value = plafond_init_23_O)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_23_P", label= "Score plafond P :", min = 6, max=30, value = plafond_init_23_P)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_23_Q", label= "Score plafond Q :", min = 6, max=30, value = plafond_init_23_Q)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_23_R", label= "Score plafond R :", min = 6, max=30, value = plafond_init_23_R)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_23_S", label= "Score plafond S :", min = 6, max=30, value = plafond_init_23_S)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_23_T", label= "Score plafond T :", min = 6, max=30, value = plafond_init_23_T)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_23_U", label= "Score plafond U :", min = 6, max=30, value = plafond_init_23_U)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_23_V", label= "Score plafond V :", min = 6, max=30, value = plafond_init_23_V)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_23_W", label= "Score plafond W :", min = 6, max=30, value = plafond_init_23_W)
              )
            )
            
          ),
          conditionalPanel(
            condition = "input.custom_number_classifications == 24",
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_24_A", label= "Score plafond A :", min = 5, max=30, value = plafond_init_24_A)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_24_B", label= "Score plafond B :", min = 6, max=30, value = plafond_init_24_B)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_24_C", label= "Score plafond C :", min = 6, max=30, value = plafond_init_24_C)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_24_D", label= "Score plafond D :", min = 6, max=30, value = plafond_init_24_D)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_24_E", label= "Score plafond E :", min = 6, max=30, value = plafond_init_24_E)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_24_F", label= "Score plafond F :", min = 6, max=30, value = plafond_init_24_F)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_24_G", label= "Score plafond G :", min = 6, max=30, value = plafond_init_24_G)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_24_H", label= "Score plafond H :", min = 6, max=30, value = plafond_init_24_H)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_24_I", label= "Score plafond I :", min = 6, max=30, value = plafond_init_24_I)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_24_J", label= "Score plafond J :", min = 6, max=30, value = plafond_init_24_J)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_24_K", label= "Score plafond K :", min = 6, max=30, value = plafond_init_24_K)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_24_L", label= "Score plafond L :", min = 6, max=30, value = plafond_init_24_L)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_24_M", label= "Score plafond M :", min = 6, max=30, value = plafond_init_24_M)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_24_N", label= "Score plafond N :", min = 6, max=30, value = plafond_init_24_N)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_24_O", label= "Score plafond O :", min = 6, max=30, value = plafond_init_24_O)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_24_P", label= "Score plafond P :", min = 6, max=30, value = plafond_init_24_P)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_24_Q", label= "Score plafond Q :", min = 6, max=30, value = plafond_init_24_Q)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_24_R", label= "Score plafond R :", min = 6, max=30, value = plafond_init_24_R)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_24_S", label= "Score plafond S :", min = 6, max=30, value = plafond_init_24_S)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_24_T", label= "Score plafond T :", min = 6, max=30, value = plafond_init_24_T)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_24_U", label= "Score plafond U :", min = 6, max=30, value = plafond_init_24_U)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_24_V", label= "Score plafond V :", min = 6, max=30, value = plafond_init_24_V)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_24_W", label= "Score plafond W :", min = 6, max=30, value = plafond_init_24_W)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_24_X", label= "Score plafond X :", min = 6, max=30, value = plafond_init_24_X)
              )
            )
          ),
          conditionalPanel(
            condition = "input.custom_number_classifications == 25",
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_25_A", label= "Score plafond A :", min = 5, max=30, value = plafond_init_25_A)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_25_B", label= "Score plafond B :", min = 6, max=30, value = plafond_init_25_B)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_25_C", label= "Score plafond C :", min = 6, max=30, value = plafond_init_25_C)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_25_D", label= "Score plafond D :", min = 6, max=30, value = plafond_init_25_D)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_25_E", label= "Score plafond E :", min = 6, max=30, value = plafond_init_25_E)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_25_F", label= "Score plafond F :", min = 6, max=30, value = plafond_init_25_F)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_25_G", label= "Score plafond G :", min = 6, max=30, value = plafond_init_25_G)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_25_H", label= "Score plafond H :", min = 6, max=30, value = plafond_init_25_H)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_25_I", label= "Score plafond I :", min = 6, max=30, value = plafond_init_25_I)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_25_J", label= "Score plafond J :", min = 6, max=30, value = plafond_init_25_J)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_25_K", label= "Score plafond K :", min = 6, max=30, value = plafond_init_25_K)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_25_L", label= "Score plafond L :", min = 6, max=30, value = plafond_init_25_L)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_25_M", label= "Score plafond M :", min = 6, max=30, value = plafond_init_25_M)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_25_N", label= "Score plafond N :", min = 6, max=30, value = plafond_init_25_N)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_25_O", label= "Score plafond O :", min = 6, max=30, value = plafond_init_25_O)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_25_P", label= "Score plafond P :", min = 6, max=30, value = plafond_init_25_P)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_25_Q", label= "Score plafond Q :", min = 6, max=30, value = plafond_init_25_Q)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_25_R", label= "Score plafond R :", min = 6, max=30, value = plafond_init_25_R)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_25_S", label= "Score plafond S :", min = 6, max=30, value = plafond_init_25_S)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_25_T", label= "Score plafond T :", min = 6, max=30, value = plafond_init_25_T)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_25_U", label= "Score plafond U :", min = 6, max=30, value = plafond_init_25_U)
              )
            ),
            fluidRow(
              column(
                width =4,
                numericInput(inputId = "score_plafond_25_V", label= "Score plafond V :", min = 6, max=30, value = plafond_init_25_V)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_25_W", label= "Score plafond W :", min = 6, max=30, value = plafond_init_25_W)
              ),
              column(
                width =4,
                numericInput(inputId = "score_plafond_25_X", label= "Score plafond X :", min = 6, max=30, value = plafond_init_25_X)
              )
            )
            
          ),
          fluidRow(
            column(
              width =4,
              numericInput(inputId = "score_plafond_25_Y", label= "Score plafond Y :", min = 6, max=30, value = plafond_init_25_Y)
            )
          ),
          
          fluidRow(column(width = 6, downloadButton(outputId = "dl_scores_plafond_groupes_sliders", label = "Exporter les plafonds", class = "btn-default", style = "width:100%;")),
                   column(width = 6, actionButton(inputId = "reset_plafonds_groupes", label = "Réinitialiser",icon = icon('arrows-rotate'), class = "btn-success", style = "width:100%;"))),

          fluidRow(column(width = 12, fileInput(inputId = "up_scores_plafond_groupes_sliders", label = NULL, buttonLabel = tags$span(icon("upload"), "Importer un scénario de plafonds (fichier .xlsx)"), width = "100%",
                                                placeholder = "Aucun fichier séléctionné", accept=".xlsx")))

          
          
          
        ),
        box(
          width=12,
          title="Minima conventionnels",
          status="warning",
          solidHeader = TRUE,
          collapsible=TRUE,
          collapsed = FALSE,
          fluidRow(column(
            width=6,
            sliderInput(inputId="classif_1", label="Groupe A :", min=1750, max=2300, value=1766, step=1, sep = " ", post = " €", width="95%") ,
                      sliderInput(inputId="classif_3", label="Groupe C :", min=1750, max=2350, value=1783, step=1, sep = " ", post = " €", width="95%"),
                      sliderInput(inputId="classif_5", label="Groupe E :", min=1750, max=2450, value=1793, step=1, sep = " ", post = " €", width="95%"),
                      sliderInput(inputId="classif_7", label="Groupe G :", min=1850, max=2500, value=1884, step=1, sep = " ", post = " €", width="95%")),
            column(
              width=6,
              sliderInput(inputId="classif_2", label="Groupe B :", min=1750, max=2300, value=1776, step=1, sep = " ", post = " €", width="95%"),
                       sliderInput(inputId="classif_4", label="Groupe D :", min=1750, max=2350, value=1789, step=1, sep = " ", post = " €", width="95%"),
                       sliderInput(inputId="classif_6", label="groupe F :", min=1750, max=2450, value=1798, step=1, sep = " ", post = " €", width="95%"),
                       sliderInput(inputId="classif_8", label="Groupe H :", min=1900, max=2600, value=1931, step=1, sep = " ", post = " €", width="95%"))),
          
          fluidRow(
            conditionalPanel(
              condition = "input.custom_number_classifications >=9",
              column(
                width=6,
                sliderInput(inputId="classif_9", label="Groupe I :", min=1950, max=2650, value=1978, step=1, sep = " ", post = " €", width="95%"),
              )
            ),
            conditionalPanel(
              condition = "input.custom_number_classifications >=10",
              column(
                width=6,
                sliderInput(inputId="classif_10", label="groupe J :", min=2050, max=2700, value=2072, step=1, sep = " ", post = " €", width="95%"),
              )
            )
          ),
          fluidRow(
            conditionalPanel(
              condition = "input.custom_number_classifications >=11",
              column(
                width=6,
                sliderInput(inputId="classif_11", label="Groupe K :", min=2150, max=2800, value=2166, step=1, sep = " ", post = " €", width="95%"),
              )
            ),
            conditionalPanel(
              condition = "input.custom_number_classifications >=12",
              column(
                width=6,
                sliderInput(inputId="classif_12", label="Groupe L :", min=2250, max=2850, value=2260, step=1, sep = " ", post = " €", width="95%"),
              )
            )
          ),
          fluidRow(
            conditionalPanel(
              condition = "input.custom_number_classifications >=13",
              column(
                width=6,
                sliderInput(inputId="classif_13", label="Groupe M :", min=2350, max=3000, value=2355, step=1, sep = " ", post = " €", width="95%"),
              )
            ),
            conditionalPanel(
              condition = "input.custom_number_classifications >=14",
              column(
                width=6,
                sliderInput(inputId="classif_14", label="Groupe N :", min=2500, max=3200, value=2543, step=1, sep = " ", post = " €", width="95%"),
              )
            )
          ),
          fluidRow(
            conditionalPanel(
              condition = "input.custom_number_classifications >=15",
              column(
                width=6,
                sliderInput(inputId="classif_15", label="Groupe O :", min=2600, max=3300, value=2637, step=1, sep = " ", post = " €", width="95%"),
              )
            ),
            conditionalPanel(
              condition = "input.custom_number_classifications >=16",
              column(
                width=6,
                sliderInput(inputId="classif_16", label="Groupe P :", min=2800, max=3500, value=2836, step=1, sep = " ", post = " €", width="95%"),
              )
            )
          ),
          fluidRow(
            conditionalPanel(
              condition = "input.custom_number_classifications >=17",
              column(
                width=6,
                sliderInput(inputId="classif_17", label="Groupe Q :", min=2900, max=3600, value=2920, step=1, sep = " ", post = " €", width="95%"),
              )
            ),
            conditionalPanel(
              condition = "input.custom_number_classifications >=18",
              column(
                width=6,
                sliderInput(inputId="classif_18", label="Groupe R :", min=3000, max=3750, value=3014, step=1, sep = " ", post = " €", width="95%"),
              )
            )
          ),
          fluidRow(
            conditionalPanel(
              condition = "input.custom_number_classifications >=19",
              column(
                width=6,
                sliderInput(inputId="classif_19", label="Groupe S :", min=3200, max=3900, value=3202, step=1, sep = " ", post = " €", width="95%"),
              )
            ),
            conditionalPanel(
              condition = "input.custom_number_classifications >=20",
              column(
                width=6,
                sliderInput(inputId="classif_20", label="Groupe T :", min=3350, max=4250, value=3391, step=1, sep = " ", post = " €", width="95%"),
              )
            )
          ),
          fluidRow(
            conditionalPanel(
              condition = "input.custom_number_classifications >=21",
              column(
                width=6,
                sliderInput(inputId="classif_21", label="Groupe U :", min=3650, max=4750, value=3673, step=1, sep = " ", post = " €", width="95%"),
              )
            ),
            conditionalPanel(
              condition = "input.custom_number_classifications >=22",
              column(
                width=6,
                sliderInput(inputId="classif_22", label="Groupe V :", min=3660, max=4801, value=3753, step=1, sep = " ", post = " €", width="95%"),
              )
            )
          ),
          fluidRow(
            conditionalPanel(
              condition = "input.custom_number_classifications >=23",
              column(
                width=6,
                sliderInput(inputId="classif_23", label="Groupe W :", min=3680, max=4811, value=3763, step=1, sep = " ", post = " €", width="95%"),
              )
            ),
            conditionalPanel(
              condition = "input.custom_number_classifications >=24",
              column(
                width=6,
                sliderInput(inputId="classif_24", label="Groupe X :", min= 3690, max=4821, value=3773, step=1, sep = " ", post = " €", width="95%"),
              )
            )
          ),
          fluidRow(
            conditionalPanel(
              condition = "input.custom_number_classifications >=25",
              column(
                width=6,
                sliderInput(inputId="classif_25", label="Groupe Y :", min=3700, max=4831, value=3783, step=1, sep = " ", post = " €", width="95%"),
              )
            )
          ),
          fluidRow(column(width = 6, downloadButton(outputId = "dl_minima_sliders", label = "Exporter les minima", class = "btn-default", style = "width:100%;")),
                   column(width = 6, actionButton(inputId = "reset_minimas_groupes", label = "Réinitialiser",icon = icon('arrows-rotate'), class = "btn-success", style = "width:100%;"))),

          fluidRow(column(width = 12, fileInput(inputId = "up_minima_sliders", label = NULL, buttonLabel = tags$span(icon("upload"), "Importer un scénario de minima (fichier .xlsx)"), width = "100%",
                                                placeholder = "Aucun fichier séléctionné", accept=".xlsx")))

        ),
        box(
          width=12,
          title="Majoration des minima selon l'ancienneté",
          status="warning",
          solidHeader = TRUE,
          collapsible=TRUE,
          collapsed=TRUE,
          fluidRow(align="center",
                   column(width = 12,
                     selectInput("Choix_csp_grp",
                                      "fixer les tranches d'ancienneté selon :", 
                                      choices = c("les catégories socio-professionnelles","les groupes"),
                                      selected = "les catégories socio-professionnelles")
                   ),
                   conditionalPanel(condition = "input.Choix_csp_grp == 'les catégories socio-professionnelles'",
                               
                    selectInput(
                     "choixcategorie",
                     "Choix de la catégrorie d'employés :",
                     choices = c("Ouvriers", "Maîtrises et techniciens", "Ingénieurs et cadres", "Toutes catégories"),
                     selected = "Ouvriers", 
                     width="80%"
                   ),
                   conditionalPanel(
                     condition = "input.choixcategorie == 'Ouvriers' ",
                     fluidRow(
                       column(width = 12,
                              actionButton(inputId = "reset_workers_values", label = "Réinitialiser les valeurs pour les ouvriers",icon = icon('arrows-rotate'), class = "btn-success"))),
                     br(),
                     
                     p("Choix des tranches d'ancienneté"),
                     
                     column(
                       width=6,
                       fluidRow(
                         align="center",
                         sliderInput(inputId="Ouvriers_Anc_1_tranches", label="Tranche 1", min=0, max=45, value=c(0, 1), step=0.5, post = " ans", width="90%"),
                         numericInput(inputId = "maj_ouvriers_tranche_1", label= "Majoration 1, en %", min=0, max= 50, value=0, width="90%"),
                         sliderInput(inputId="Ouvriers_Anc_3_tranches", label="Tranche 3", min=0, max=45, value=c(3, 4), step=0.5, post = " ans", width="90%"),
                         numericInput(inputId = "maj_ouvriers_tranche_3", label= "Majoration 3, en %", min=0, max= 50, value=7, width="90%"),
                         sliderInput(inputId="Ouvriers_Anc_5_tranches", label="Tranche 5", min=0, max=45, value=c(5, 9.5), step=0.5, post = " ans", width="90%"),
                         numericInput(inputId = "maj_ouvriers_tranche_5", label= "Majoration 5, en %", min=0, max= 50, value=12, width="90%"),
                         sliderInput(inputId="Ouvriers_Anc_7_tranches", label="Tranche 7", min=0, max=45, value=c(15, 19.5), step=0.5, post = " ans", width="90%"),
                         numericInput(inputId = "maj_ouvriers_tranche_7", label= "Majoration 7, en %", min=0, max= 50, value=17, width="90%"),
                         sliderInput(inputId="Ouvriers_Anc_9_tranches", label="Tranche 9", min=0, max=45, value=c(25, 30), step=0.5, post = " ans", width="90%"),
                         numericInput(inputId = "maj_ouvriers_tranche_9", label= "Majoration 9, en %", min=0, max= 50, value=23, width="90%")
                         
                       )
                       
                       
                     ),
                     column(
                       width=6,
                       fluidRow(
                         align="center",
                         sliderInput(inputId="Ouvriers_Anc_2_tranches", label="Tranche 2", min=0, max=45, value=c(1, 2), step=0.5, post = " ans", width="90%"),
                         numericInput(inputId = "maj_ouvriers_tranche_2", label= "Majoration 2, en %", min=0, max= 50, value=3, width="90%"),
                         sliderInput(inputId="Ouvriers_Anc_4_tranches", label="Tranche 4", min=0, max=45, value=c(4, 5), step=0.5, post = " ans", width="90%"),
                         numericInput(inputId = "maj_ouvriers_tranche_4", label= "Majoration 4, en %", min=0, max= 50, value=10, width="90%"),
                         sliderInput(inputId="Ouvriers_Anc_6_tranches", label="Tranche 6", min=0, max=45, value=c(10, 14.5), step=0.5, post = " ans", width="90%"),
                         numericInput(inputId = "maj_ouvriers_tranche_6", label= "Majoration 6, en %", min=0, max= 50, value=14, width="90%"),
                         sliderInput(inputId="Ouvriers_Anc_8_tranches", label="Tranche 8", min=0, max=45, value=c(20, 24.5), step=0.5, post = " ans", width="90%"),
                         numericInput(inputId = "maj_ouvriers_tranche_8", label= "Majoration 8, en %", min=0, max= 50, value=20, width="90%"),
                         sliderInput(inputId="Ouvriers_Anc_10_tranches", label="Tranche 10", min=0, max=45, value=c(30.5, 45), step=0.5, post = " ans", width="90%"),
                         numericInput(inputId = "maj_ouvriers_tranche_10", label= "Majoration 10, en %", min=0, max= 50, value=23, width="90%")
                         
                       )
                     )
                   ),
                   conditionalPanel(
                     condition = "input.choixcategorie == 'Maîtrises et techniciens' ",
                     fluidRow(
                       column(width = 12,
                              actionButton(inputId = "reset_technicians_values", label = "Réinitialiser les valeurs pour les techniciens",icon = icon('arrows-rotate'), class = "btn-success"))),
                     br(),
                     p("Choix des tranches d'ancienneté"),
                     column(
                       width=6,
                       fluidRow(
                         align="center",
                         sliderInput(inputId="Techniciens_Anc_1_tranches", label="Tranche  1", min=0, max=45, value=c(0, 0.5), step=0.5, post = " ans", width="90%"),
                         numericInput(inputId = "maj_Techniciens_tranche_1", label= "Majoration 1, en %", min=0, max= 30, value=6, width="90%"),
                         sliderInput(inputId="Techniciens_Anc_3_tranches", label="Tranche  3", min=0, max=45, value=c(5, 6), step=0.5, post = " ans", width="90%"),
                         numericInput(inputId = "maj_Techniciens_tranche_3", label= "Majoration 3, en %", min=0, max= 30, value=8, width="90%"),
                         sliderInput(inputId="Techniciens_Anc_5_tranches", label="Tranche  5", min=0, max=45, value=c(9, 10), step=0.5, post = " ans", width="90%"),
                         numericInput(inputId = "maj_Techniciens_tranche_5", label= "Majoration 5, en %", min=0, max= 30, value=10, width="90%"),
                         sliderInput(inputId="Techniciens_Anc_7_tranches", label="Tranche  7", min=0, max=45, value=c(13, 14), step=0.5, post = " ans", width="90%"),
                         numericInput(inputId = "maj_Techniciens_tranche_7", label= "Majoration 7, en %", min=0, max= 30, value=12, width="90%"),
                         sliderInput(inputId="Techniciens_Anc_9_tranches", label="Tranche  9", min=0, max=45, value=c(17, 18), step=0.5, post = " ans", width="90%"),
                         numericInput(inputId = "maj_Techniciens_tranche_9", label= "Majoration 9, en %", min=0, max= 30, value=14, width="90%")
                       )
                       
                       
                     ),
                     column(
                       width=6,
                       fluidRow(
                         align="center",
                         sliderInput(inputId="Techniciens_Anc_2_tranches", label="Tranche  2", min=0, max=45, value=c(0.5, 2), step=0.5, post = " ans", width="90%"),
                         numericInput(inputId = "maj_Techniciens_tranche_2", label= "Majoration 2, en %", min=0, max= 30, value=7, width="90%"),
                         sliderInput(inputId="Techniciens_Anc_4_tranches", label="Tranche  4", min=0, max=45, value=c(7, 8), step=0.5, post = " ans", width="90%"),
                         numericInput(inputId = "maj_Techniciens_tranche_4", label= "Majoration 4, en %", min=0, max= 30, value=9, width="90%"),
                         sliderInput(inputId="Techniciens_Anc_6_tranches", label="Tranche  6", min=0, max=45, value=c(11, 12), step=0.5, post = " ans", width="90%"),
                         numericInput(inputId = "maj_Techniciens_tranche_6", label= "Majoration 6, en %", min=0, max= 30, value=11, width="90%"),
                         sliderInput(inputId="Techniciens_Anc_8_tranches", label="Tranche  8", min=0, max=45, value=c(15, 16), step=0.5, post = " ans", width="90%"),
                         numericInput(inputId = "maj_Techniciens_tranche_8", label= "Majoration 8, en %", min=0, max= 30, value=13, width="90%"),
                         sliderInput(inputId="Techniciens_Anc_10_tranches", label="Tranche  10", min=0, max=45, value=c(19, 45), step=0.5, post = " ans", width="90%"),
                         numericInput(inputId = "maj_Techniciens_tranche_10", label= "Majoration 10, en %", min=0, max= 30, value=15, width="90%")
                         
                       )
                     )
          ),
          conditionalPanel(
            condition = "input.choixcategorie == 'Ingénieurs et cadres'",
            fluidRow(
              column(width = 12,
                     actionButton(inputId = "reset_executives_values", label = "Réinitialiser les valeurs pour les cadres",icon = icon('arrows-rotate'), class = "btn-success"))),
            br(),
            p("Choix des tranches d'ancienneté"),
            
            column(
              width=6,
              fluidRow(
                align="center",
                sliderInput(inputId="Cadres_Anc_1_tranches", label="Tranche 1", min=0, max=45, value=c(0, 1.5), step=0.5, post = " ans", width="90%"),
                numericInput(inputId = "maj_Cadres_tranche_1", label= "Majoration 1, en %", min=0, max= 80, value=0, width="90%"),
                sliderInput(inputId="Cadres_Anc_3_tranches", label="Tranche 3", min=0, max=45, value=c(4, 5.5), step=0.5, post = " ans", width="90%"),
                numericInput(inputId = "maj_Cadres_tranche_3", label= "Majoration 3, en %", min=0, max= 80, value=10, width="90%"),
                sliderInput(inputId="Cadres_Anc_5_tranches", label="Tranche 5", min=0, max=45, value=c(8, 12.5), step=0.5, post = " ans", width="90%"),
                numericInput(inputId = "maj_Cadres_tranche_5", label= "Majoration 5, en %", min=0, max= 80, value=20, width="90%"),
                sliderInput(inputId="Cadres_Anc_7_tranches", label="Tranche 7", min=0, max=45, value=c(18, 22.5), step=0.5, post = " ans", width="90%"),
                numericInput(inputId = "maj_Cadres_tranche_7", label= "Majoration 7, en %", min=0, max= 80, value=40, width="90%"),
                sliderInput(inputId="Cadres_Anc_9_tranches", label="Tranche 9", min=0, max=45, value=c(28, 32.5), step=0.5, post = " ans", width="90%"),
                numericInput(inputId = "maj_Cadres_tranche_9", label= "Majoration 9, en %", min=0, max= 80, value=60, width="90%")
                
              )
              
              
            ),
            column(
              width=6,
              fluidRow( 
                align="center",
                sliderInput(inputId="Cadres_Anc_2_tranches", label="Tranche 2", min=0, max=45, value=c(2, 3.5), step=0.5, post = " ans", width="90%"),
                numericInput(inputId = "maj_Cadres_tranche_2", label= "Majoration 2, en %", min=0, max= 80, value=5, width="90%"),
                sliderInput(inputId="Cadres_Anc_4_tranches", label="Tranche 4", min=0, max=45, value=c(6, 7.5), step=0.5, post = " ans", width="90%"),
                numericInput(inputId = "maj_Cadres_tranche_4", label= "Majoration 4, en %", min=0, max= 80, value=15, width="90%"),
                sliderInput(inputId="Cadres_Anc_6_tranches", label="Tranche 6", min=0, max=45, value=c(13, 17.5), step=0.5, post = " ans", width="90%"),
                numericInput(inputId = "maj_Cadres_tranche_6", label= "Majoration 6, en %", min=0, max= 80, value=30, width="90%"),
                sliderInput(inputId="Cadres_Anc_8_tranches", label="Tranche 8", min=0, max=45, value=c(23, 27.5), step=0.5, post = " ans", width="90%"),
                numericInput(inputId = "maj_Cadres_tranche_8", label= "Majoration 8, en %", min=0, max= 80, value=50, width="90%"),
                sliderInput(inputId="Cadres_Anc_10_tranches", label="Tranche 10", min=0, max=45, value=c(33, 45), step=0.5, post = " ans", width="90%"),
                numericInput(inputId = "maj_Cadres_tranche_10", label= "Majoration 10, en %", min=0, max= 80, value=60, width="90%")
                
              )
            )),
            
          conditionalPanel(
            condition = "input.choixcategorie == 'Toutes catégories' ",
            p("Choix des tranches d'ancienneté"),
            
            column(
              width=6,
              fluidRow(
                align="center",
                actionButton(inputId = "reset_all_categories_values", label = "Réinitialiser les valeurs",icon = icon('arrows-rotate'), class = "btn-success"),
                br(),
                sliderInput(inputId="Toutes_cat_Anc_1_tranches", label="Tranche 1", min=0, max=45, value=c(1, 2), step=0.5, post = " ans", width="90%"),
                numericInput(inputId = "maj_Toutes_cat_tranche_1", label= "Majoration 1, en %", min=0, max= 30, value=6, width="90%"),
                sliderInput(inputId="Toutes_cat_Anc_3_tranches", label="Tranche 3", min=0, max=45, value=c(5, 6), step=0.5, post = " ans", width="90%"),
                numericInput(inputId = "maj_Toutes_cat_tranche_3", label= "Majoration 3, en %", min=0, max= 30, value=8, width="90%"),
                sliderInput(inputId="Toutes_cat_Anc_5_tranches", label="Tranche 5", min=0, max=45, value=c(9, 10), step=0.5, post = " ans", width="90%"),
                numericInput(inputId = "maj_Toutes_cat_tranche_5", label= "Majoration 5, en %", min=0, max= 30, value=10, width="90%"),
                sliderInput(inputId="Toutes_cat_Anc_7_tranches", label="Tranche 7", min=0, max=45, value=c(13, 14), step=0.5, post = " ans", width="90%"),
                numericInput(inputId = "maj_Toutes_cat_tranche_7", label= "Majoration 7, en %", min=0, max= 30, value=12, width="90%"),
                sliderInput(inputId="Toutes_cat_Anc_9_tranches", label="Tranche 9", min=0, max=45, value=c(17, 18), step=0.5, post = " ans", width="90%"),
                numericInput(inputId = "maj_Toutes_cat_tranche_9", label= "Majoration 9, en %", min=0, max= 30, value=14, width="90%")
              )
              
              
            ),
            column(
              width=6,
              fluidRow( 
                align="center",
                actionButton(inputId = "appliquer_scores_toutes_categories", label = "Appliquer aux autres catégories",icon = icon('arrows-rotate'), class = "btn-success"),
                br(),
                sliderInput(inputId="Toutes_cat_Anc_2_tranches", label="Tranche 2", min=0, max=45, value=c(3, 4), step=0.5, post = " ans", width="90%"),
                numericInput(inputId = "maj_Toutes_cat_tranche_2", label= "Majoration 2, en %", min=0, max= 30, value=7, width="90%"),
                sliderInput(inputId="Toutes_cat_Anc_4_tranches", label="Tranche 4", min=0, max=45, value=c(7, 8), step=0.5, post = " ans", width="90%"),
                numericInput(inputId = "maj_Toutes_cat_tranche_4", label= "Majoration 4, en %", min=0, max= 30, value=9, width="90%"),
                sliderInput(inputId="Toutes_cat_Anc_6_tranches", label="Tranche 6", min=0, max=45, value=c(11, 12), step=0.5, post = " ans", width="90%"),
                numericInput(inputId = "maj_Toutes_cat_tranche_6", label= "Majoration 6, en %", min=0, max= 30, value=11, width="90%"),
                sliderInput(inputId="Toutes_cat_Anc_8_tranches", label="Tranche 8", min=0, max=45, value=c(15, 16), step=0.5, post = " ans", width="90%"),
                numericInput(inputId = "maj_Toutes_cat_tranche_8", label= "Majoration 8, en %", min=0, max= 30, value=13, width="90%"),
                sliderInput(inputId="Toutes_cat_Anc_10_tranches", label="Tranche 10", min=0, max=45, value=c(19, 45), step=0.5, post = " ans", width="90%"),
                numericInput(inputId = "maj_Toutes_cat_tranche_10", label= "Majoration 10, en %", min=0, max= 30, value=13, width="90%")
              )
            )
          ),
          
        highchartOutput(outputId = "plot_majoration_anciennete", width = "100%")),
        conditionalPanel(condition = "input.Choix_csp_grp == 'les groupes'",
                         
                         selectInput(
                           "choixgroupe",
                           "Choix du groupe:",
                           choices = c(LETTERS[1:25]),
                           selected = "A", 
                           width="80%"
                         ),
                         conditionalPanel(
                           condition = "input.choixgroupe == 'A' ",
                           fluidRow(
                             column(width = 12,
                                    actionButton(inputId = "reset_A_values", label = "Réinitialiser les valeurs pour le groupe A",icon = icon('arrows-rotate'), class = "btn-success"))),
                           br(),
                           
                           p("Choix des tranches d'ancienneté"),
                           
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="A_Anc_1_tranches", label="Tranche 1", min=0, max=45, value=c(0, 1), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_A_tranche_1", label= "Majoration 1, en %", min=0, max= 50, value=0, width="90%"),
                               sliderInput(inputId="A_Anc_3_tranches", label="Tranche 3", min=0, max=45, value=c(2.5, 4), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_A_tranche_3", label= "Majoration 3, en %", min=0, max= 50, value=7, width="90%"),
                               sliderInput(inputId="A_Anc_5_tranches", label="Tranche 5", min=0, max=45, value=c(5, 10), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_A_tranche_5", label= "Majoration 5, en %", min=0, max= 50, value=12, width="90%"),
                               sliderInput(inputId="A_Anc_7_tranches", label="Tranche 7", min=0, max=45, value=c(15, 20), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_A_tranche_7", label= "Majoration 7, en %", min=0, max= 50, value=17, width="90%"),
                               sliderInput(inputId="A_Anc_9_tranches", label="Tranche 9", min=0, max=45, value=c(25, 30), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_A_tranche_9", label= "Majoration 9, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                             
                             
                           ),
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="A_Anc_2_tranches", label="Tranche 2", min=0, max=45, value=c(1, 2.5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_A_tranche_2", label= "Majoration 2, en %", min=0, max= 50, value=3, width="90%"),
                               sliderInput(inputId="A_Anc_4_tranches", label="Tranche 4", min=0, max=45, value=c(4, 5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_A_tranche_4", label= "Majoration 4, en %", min=0, max= 50, value=10, width="90%"),
                               sliderInput(inputId="A_Anc_6_tranches", label="Tranche 6", min=0, max=45, value=c(10, 15), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_A_tranche_6", label= "Majoration 6, en %", min=0, max= 50, value=14, width="90%"),
                               sliderInput(inputId="A_Anc_8_tranches", label="Tranche 8", min=0, max=45, value=c(20, 25), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_A_tranche_8", label= "Majoration 8, en %", min=0, max= 50, value=20, width="90%"),
                               sliderInput(inputId="A_Anc_10_tranches", label="Tranche 10", min=0, max=45, value=c(30, 45), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_A_tranche_10", label= "Majoration 10, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                           )
                         ),
                         conditionalPanel(
                           condition = "input.choixgroupe == 'B' ",
                           fluidRow(
                             column(width = 12,
                                    actionButton(inputId = "reset_B_values", label = "Réinitialiser les valeurs pour le groupe B",icon = icon('arrows-rotate'), class = "btn-success"))),
                           br(),
                           
                           p("Choix des tranches d'ancienneté"),
                           
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="B_Anc_1_tranches", label="Tranche 1", min=0, max=45, value=c(0, 1), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_B_tranche_1", label= "Majoration 1, en %", min=0, max= 50, value=0, width="90%"),
                               sliderInput(inputId="B_Anc_3_tranches", label="Tranche 3", min=0, max=45, value=c(2.5, 4), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_B_tranche_3", label= "Majoration 3, en %", min=0, max= 50, value=7, width="90%"),
                               sliderInput(inputId="B_Anc_5_tranches", label="Tranche 5", min=0, max=45, value=c(5, 10), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_B_tranche_5", label= "Majoration 5, en %", min=0, max= 50, value=12, width="90%"),
                               sliderInput(inputId="B_Anc_7_tranches", label="Tranche 7", min=0, max=45, value=c(15, 20), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_B_tranche_7", label= "Majoration 7, en %", min=0, max= 50, value=17, width="90%"),
                               sliderInput(inputId="B_Anc_B_tranches", label="Tranche 9", min=0, max=45, value=c(25, 30), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_B_tranche_9", label= "Majoration 9, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                             
                             
                           ),
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="B_Anc_2_tranches", label="Tranche 2", min=0, max=45, value=c(1, 2.5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_B_tranche_2", label= "Majoration 2, en %", min=0, max= 50, value=3, width="90%"),
                               sliderInput(inputId="B_Anc_4_tranches", label="Tranche 4", min=0, max=45, value=c(4, 5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_B_tranche_4", label= "Majoration 4, en %", min=0, max= 50, value=10, width="90%"),
                               sliderInput(inputId="B_Anc_6_tranches", label="Tranche 6", min=0, max=45, value=c(10, 15), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_B_tranche_6", label= "Majoration 6, en %", min=0, max= 50, value=14, width="90%"),
                               sliderInput(inputId="B_Anc_8_tranches", label="Tranche 8", min=0, max=45, value=c(20, 25), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_B_tranche_8", label= "Majoration 8, en %", min=0, max= 50, value=20, width="90%"),
                               sliderInput(inputId="B_Anc_10_tranches", label="Tranche 10", min=0, max=45, value=c(30, 45), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_B_tranche_10", label= "Majoration 10, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                           )
                         ),
                         conditionalPanel(
                           condition = "input.choixgroupe == 'C' ",
                           fluidRow(
                             column(width = 12,
                                    actionButton(inputId = "reset_C_values", label = "Réinitialiser les valeurs pour le groupe C",icon = icon('arrows-rotate'), class = "btn-success"))),
                           br(),
                           
                           p("Choix des tranches d'ancienneté"),
                           
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="C_Anc_1_tranches", label="Tranche 1", min=0, max=45, value=c(0, 1), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_C_tranche_1", label= "Majoration 1, en %", min=0, max= 50, value=0, width="90%"),
                               sliderInput(inputId="C_Anc_3_tranches", label="Tranche 3", min=0, max=45, value=c(2.5, 4), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_C_tranche_3", label= "Majoration 3, en %", min=0, max= 50, value=7, width="90%"),
                               sliderInput(inputId="C_Anc_5_tranches", label="Tranche 5", min=0, max=45, value=c(5, 10), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_C_tranche_5", label= "Majoration 5, en %", min=0, max= 50, value=12, width="90%"),
                               sliderInput(inputId="C_Anc_7_tranches", label="Tranche 7", min=0, max=45, value=c(15, 20), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_C_tranche_7", label= "Majoration 7, en %", min=0, max= 50, value=17, width="90%"),
                               sliderInput(inputId="C_Anc_9_tranches", label="Tranche 9", min=0, max=45, value=c(25, 30), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_C_tranche_9", label= "Majoration 9, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                             
                             
                           ),
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="C_Anc_2_tranches", label="Tranche 2", min=0, max=45, value=c(1, 2.5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_C_tranche_2", label= "Majoration 2, en %", min=0, max= 50, value=3, width="90%"),
                               sliderInput(inputId="C_Anc_4_tranches", label="Tranche 4", min=0, max=45, value=c(4, 5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_C_tranche_4", label= "Majoration 4, en %", min=0, max= 50, value=10, width="90%"),
                               sliderInput(inputId="C_Anc_6_tranches", label="Tranche 6", min=0, max=45, value=c(10, 15), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_C_tranche_6", label= "Majoration 6, en %", min=0, max= 50, value=14, width="90%"),
                               sliderInput(inputId="C_Anc_8_tranches", label="Tranche 8", min=0, max=45, value=c(20, 25), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_A_tranche_8", label= "Majoration 8, en %", min=0, max= 50, value=20, width="90%"),
                               sliderInput(inputId="A_Anc_10_tranches", label="Tranche 10", min=0, max=45, value=c(30, 45), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_C_tranche_10", label= "Majoration 10, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                           )
                         ),
                         conditionalPanel(
                           condition = "input.choixgroupe == 'D' ",
                           fluidRow(
                             column(width = 12,
                                    actionButton(inputId = "reset_D_values", label = "Réinitialiser les valeurs pour le groupe D",icon = icon('arrows-rotate'), class = "btn-success"))),
                           br(),
                           
                           p("Choix des tranches d'ancienneté"),
                           
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="D_Anc_1_tranches", label="Tranche 1", min=0, max=45, value=c(0, 1), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_D_tranche_1", label= "Majoration 1, en %", min=0, max= 50, value=0, width="90%"),
                               sliderInput(inputId="D_Anc_3_tranches", label="Tranche 3", min=0, max=45, value=c(2.5, 4), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_D_tranche_3", label= "Majoration 3, en %", min=0, max= 50, value=7, width="90%"),
                               sliderInput(inputId="D_Anc_5_tranches", label="Tranche 5", min=0, max=45, value=c(5, 10), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_D_tranche_5", label= "Majoration 5, en %", min=0, max= 50, value=12, width="90%"),
                               sliderInput(inputId="D_Anc_7_tranches", label="Tranche 7", min=0, max=45, value=c(15, 20), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_D_tranche_7", label= "Majoration 7, en %", min=0, max= 50, value=17, width="90%"),
                               sliderInput(inputId="D_Anc_9_tranches", label="Tranche 9", min=0, max=45, value=c(25, 30), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_D_tranche_9", label= "Majoration 9, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                             
                             
                           ),
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="D_Anc_2_tranches", label="Tranche 2", min=0, max=45, value=c(1, 2.5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_D_tranche_2", label= "Majoration 2, en %", min=0, max= 50, value=3, width="90%"),
                               sliderInput(inputId="D_Anc_4_tranches", label="Tranche 4", min=0, max=45, value=c(4, 5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_D_tranche_4", label= "Majoration 4, en %", min=0, max= 50, value=10, width="90%"),
                               sliderInput(inputId="D_Anc_6_tranches", label="Tranche 6", min=0, max=45, value=c(10, 15), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_D_tranche_6", label= "Majoration 6, en %", min=0, max= 50, value=14, width="90%"),
                               sliderInput(inputId="D_Anc_8_tranches", label="Tranche 8", min=0, max=45, value=c(20, 25), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_D_tranche_8", label= "Majoration 8, en %", min=0, max= 50, value=20, width="90%"),
                               sliderInput(inputId="D_Anc_10_tranches", label="Tranche 10", min=0, max=45, value=c(30, 45), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_D_tranche_10", label= "Majoration 10, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                           )
                         ),
                         conditionalPanel(
                           condition = "input.choixgroupe == 'E' ",
                           fluidRow(
                             column(width = 12,
                                    actionButton(inputId = "reset_E_values", label = "Réinitialiser les valeurs pour le groupe E",icon = icon('arrows-rotate'), class = "btn-success"))),
                           br(),
                           
                           p("Choix des tranches d'ancienneté"),
                           
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="E_Anc_1_tranches", label="Tranche 1", min=0, max=45, value=c(0, 1), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_E_tranche_1", label= "Majoration 1, en %", min=0, max= 50, value=0, width="90%"),
                               sliderInput(inputId="E_Anc_3_tranches", label="Tranche 3", min=0, max=45, value=c(2.5, 4), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_E_tranche_3", label= "Majoration 3, en %", min=0, max= 50, value=7, width="90%"),
                               sliderInput(inputId="E_Anc_5_tranches", label="Tranche 5", min=0, max=45, value=c(5, 10), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_E_tranche_5", label= "Majoration 5, en %", min=0, max= 50, value=12, width="90%"),
                               sliderInput(inputId="E_Anc_7_tranches", label="Tranche 7", min=0, max=45, value=c(15, 20), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_E_tranche_7", label= "Majoration 7, en %", min=0, max= 50, value=17, width="90%"),
                               sliderInput(inputId="E_Anc_9_tranches", label="Tranche 9", min=0, max=45, value=c(25, 30), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_E_tranche_9", label= "Majoration 9, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                             
                             
                           ),
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="E_Anc_2_tranches", label="Tranche 2", min=0, max=45, value=c(1, 2.5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_E_tranche_2", label= "Majoration 2, en %", min=0, max= 50, value=3, width="90%"),
                               sliderInput(inputId="E_Anc_4_tranches", label="Tranche 4", min=0, max=45, value=c(4, 5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_E_tranche_4", label= "Majoration 4, en %", min=0, max= 50, value=10, width="90%"),
                               sliderInput(inputId="E_Anc_6_tranches", label="Tranche 6", min=0, max=45, value=c(10, 15), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_E_tranche_6", label= "Majoration 6, en %", min=0, max= 50, value=14, width="90%"),
                               sliderInput(inputId="E_Anc_8_tranches", label="Tranche 8", min=0, max=45, value=c(20, 25), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_E_tranche_8", label= "Majoration 8, en %", min=0, max= 50, value=20, width="90%"),
                               sliderInput(inputId="E_Anc_10_tranches", label="Tranche 10", min=0, max=45, value=c(30, 45), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_E_tranche_10", label= "Majoration 10, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                           )
                         ),
                         conditionalPanel(
                           condition = "input.choixgroupe == 'F' ",
                           fluidRow(
                             column(width = 12,
                                    actionButton(inputId = "reset_F_values", label = "Réinitialiser les valeurs pour le groupe F",icon = icon('arrows-rotate'), class = "btn-success"))),
                           br(),
                           
                           p("Choix des tranches d'ancienneté"),
                           
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="F_Anc_1_tranches", label="Tranche 1", min=0, max=45, value=c(0, 1), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_F_tranche_1", label= "Majoration 1, en %", min=0, max= 50, value=0, width="90%"),
                               sliderInput(inputId="F_Anc_3_tranches", label="Tranche 3", min=0, max=45, value=c(2.5, 4), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_F_tranche_3", label= "Majoration 3, en %", min=0, max= 50, value=7, width="90%"),
                               sliderInput(inputId="F_Anc_5_tranches", label="Tranche 5", min=0, max=45, value=c(5, 10), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_F_tranche_5", label= "Majoration 5, en %", min=0, max= 50, value=12, width="90%"),
                               sliderInput(inputId="F_Anc_7_tranches", label="Tranche 7", min=0, max=45, value=c(15, 20), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_F_tranche_7", label= "Majoration 7, en %", min=0, max= 50, value=17, width="90%"),
                               sliderInput(inputId="F_Anc_9_tranches", label="Tranche 9", min=0, max=45, value=c(25, 30), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_F_tranche_9", label= "Majoration 9, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                             
                             
                           ),
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="F_Anc_2_tranches", label="Tranche 2", min=0, max=45, value=c(1, 2.5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_F_tranche_2", label= "Majoration 2, en %", min=0, max= 50, value=3, width="90%"),
                               sliderInput(inputId="F_Anc_4_tranches", label="Tranche 4", min=0, max=45, value=c(4, 5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_F_tranche_4", label= "Majoration 4, en %", min=0, max= 50, value=10, width="90%"),
                               sliderInput(inputId="F_Anc_6_tranches", label="Tranche 6", min=0, max=45, value=c(10, 15), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_F_tranche_6", label= "Majoration 6, en %", min=0, max= 50, value=14, width="90%"),
                               sliderInput(inputId="F_Anc_8_tranches", label="Tranche 8", min=0, max=45, value=c(20, 25), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_F_tranche_8", label= "Majoration 8, en %", min=0, max= 50, value=20, width="90%"),
                               sliderInput(inputId="F_Anc_10_tranches", label="Tranche 10", min=0, max=45, value=c(30, 45), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_F_tranche_10", label= "Majoration 10, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                           )
                         ),
                         conditionalPanel(
                           condition = "input.choixgroupe == 'G' ",
                           fluidRow(
                             column(width = 12,
                                    actionButton(inputId = "reset_G_values", label = "Réinitialiser les valeurs pour le groupe G",icon = icon('arrows-rotate'), class = "btn-success"))),
                           br(),
                           
                           p("Choix des tranches d'ancienneté"),
                           
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="G_Anc_1_tranches", label="Tranche 1", min=0, max=45, value=c(0, 1), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_G_tranche_1", label= "Majoration 1, en %", min=0, max= 50, value=0, width="90%"),
                               sliderInput(inputId="G_Anc_3_tranches", label="Tranche 3", min=0, max=45, value=c(2.5, 4), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_G_tranche_3", label= "Majoration 3, en %", min=0, max= 50, value=7, width="90%"),
                               sliderInput(inputId="G_Anc_5_tranches", label="Tranche 5", min=0, max=45, value=c(5, 10), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_G_tranche_5", label= "Majoration 5, en %", min=0, max= 50, value=12, width="90%"),
                               sliderInput(inputId="G_Anc_7_tranches", label="Tranche 7", min=0, max=45, value=c(15, 20), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_G_tranche_7", label= "Majoration 7, en %", min=0, max= 50, value=17, width="90%"),
                               sliderInput(inputId="G_Anc_9_tranches", label="Tranche 9", min=0, max=45, value=c(25, 30), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_G_tranche_9", label= "Majoration 9, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                             
                             
                           ),
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="G_Anc_2_tranches", label="Tranche 2", min=0, max=45, value=c(1, 2.5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_G_tranche_2", label= "Majoration 2, en %", min=0, max= 50, value=3, width="90%"),
                               sliderInput(inputId="G_Anc_4_tranches", label="Tranche 4", min=0, max=45, value=c(4, 5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_G_tranche_4", label= "Majoration 4, en %", min=0, max= 50, value=10, width="90%"),
                               sliderInput(inputId="G_Anc_6_tranches", label="Tranche 6", min=0, max=45, value=c(10, 15), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_G_tranche_6", label= "Majoration 6, en %", min=0, max= 50, value=14, width="90%"),
                               sliderInput(inputId="G_Anc_8_tranches", label="Tranche 8", min=0, max=45, value=c(20, 25), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_G_tranche_8", label= "Majoration 8, en %", min=0, max= 50, value=20, width="90%"),
                               sliderInput(inputId="G_Anc_10_tranches", label="Tranche 10", min=0, max=45, value=c(30, 45), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_G_tranche_10", label= "Majoration 10, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                           )
                         ),
                         conditionalPanel(
                           condition = "input.choixgroupe == 'H' ",
                           fluidRow(
                             column(width = 12,
                                    actionButton(inputId = "reset_H_values", label = "Réinitialiser les valeurs pour le groupe H",icon = icon('arrows-rotate'), class = "btn-success"))),
                           br(),
                           
                           p("Choix des tranches d'ancienneté"),
                           
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="H_Anc_1_tranches", label="Tranche 1", min=0, max=45, value=c(0, 1), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_H_tranche_1", label= "Majoration 1, en %", min=0, max= 50, value=0, width="90%"),
                               sliderInput(inputId="H_Anc_3_tranches", label="Tranche 3", min=0, max=45, value=c(2.5, 4), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_H_tranche_3", label= "Majoration 3, en %", min=0, max= 50, value=7, width="90%"),
                               sliderInput(inputId="H_Anc_5_tranches", label="Tranche 5", min=0, max=45, value=c(5, 10), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_H_tranche_5", label= "Majoration 5, en %", min=0, max= 50, value=12, width="90%"),
                               sliderInput(inputId="H_Anc_7_tranches", label="Tranche 7", min=0, max=45, value=c(15, 20), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_H_tranche_7", label= "Majoration 7, en %", min=0, max= 50, value=17, width="90%"),
                               sliderInput(inputId="H_Anc_9_tranches", label="Tranche 9", min=0, max=45, value=c(25, 30), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_H_tranche_9", label= "Majoration 9, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                             
                             
                           ),
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="H_Anc_2_tranches", label="Tranche 2", min=0, max=45, value=c(1, 2.5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_H_tranche_2", label= "Majoration 2, en %", min=0, max= 50, value=3, width="90%"),
                               sliderInput(inputId="H_Anc_4_tranches", label="Tranche 4", min=0, max=45, value=c(4, 5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_H_tranche_4", label= "Majoration 4, en %", min=0, max= 50, value=10, width="90%"),
                               sliderInput(inputId="H_Anc_6_tranches", label="Tranche 6", min=0, max=45, value=c(10, 15), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_H_tranche_6", label= "Majoration 6, en %", min=0, max= 50, value=14, width="90%"),
                               sliderInput(inputId="H_Anc_8_tranches", label="Tranche 8", min=0, max=45, value=c(20, 25), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_H_tranche_8", label= "Majoration 8, en %", min=0, max= 50, value=20, width="90%"),
                               sliderInput(inputId="H_Anc_10_tranches", label="Tranche 10", min=0, max=45, value=c(30, 45), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_H_tranche_10", label= "Majoration 10, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                           )
                         ),
                         conditionalPanel(
                           condition = "input.choixgroupe == 'I' ",
                           fluidRow(
                             column(width = 12,
                                    actionButton(inputId = "reset_I_values", label = "Réinitialiser les valeurs pour le groupe I",icon = icon('arrows-rotate'), class = "btn-success"))),
                           br(),
                           
                           p("Choix des tranches d'ancienneté"),
                           
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="I_Anc_1_tranches", label="Tranche 1", min=0, max=45, value=c(0, 1), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_I_tranche_1", label= "Majoration 1, en %", min=0, max= 50, value=0, width="90%"),
                               sliderInput(inputId="I_Anc_3_tranches", label="Tranche 3", min=0, max=45, value=c(2.5, 4), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_I_tranche_3", label= "Majoration 3, en %", min=0, max= 50, value=7, width="90%"),
                               sliderInput(inputId="I_Anc_5_tranches", label="Tranche 5", min=0, max=45, value=c(5, 10), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_I_tranche_5", label= "Majoration 5, en %", min=0, max= 50, value=12, width="90%"),
                               sliderInput(inputId="I_Anc_7_tranches", label="Tranche 7", min=0, max=45, value=c(15, 20), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_I_tranche_7", label= "Majoration 7, en %", min=0, max= 50, value=17, width="90%"),
                               sliderInput(inputId="I_Anc_9_tranches", label="Tranche 9", min=0, max=45, value=c(25, 30), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_I_tranche_9", label= "Majoration 9, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                             
                             
                           ),
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="I_Anc_2_tranches", label="Tranche 2", min=0, max=45, value=c(1, 2.5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_I_tranche_2", label= "Majoration 2, en %", min=0, max= 50, value=3, width="90%"),
                               sliderInput(inputId="I_Anc_4_tranches", label="Tranche 4", min=0, max=45, value=c(4, 5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_I_tranche_4", label= "Majoration 4, en %", min=0, max= 50, value=10, width="90%"),
                               sliderInput(inputId="I_Anc_6_tranches", label="Tranche 6", min=0, max=45, value=c(10, 15), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_I_tranche_6", label= "Majoration 6, en %", min=0, max= 50, value=14, width="90%"),
                               sliderInput(inputId="I_Anc_8_tranches", label="Tranche 8", min=0, max=45, value=c(20, 25), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_I_tranche_8", label= "Majoration 8, en %", min=0, max= 50, value=20, width="90%"),
                               sliderInput(inputId="I_Anc_10_tranches", label="Tranche 10", min=0, max=45, value=c(30, 45), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_I_tranche_10", label= "Majoration 10, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                           )
                         ),
                         conditionalPanel(
                           condition = "input.choixgroupe == 'J' ",
                           fluidRow(
                             column(width = 12,
                                    actionButton(inputId = "reset_J_values", label = "Réinitialiser les valeurs pour le groupe J",icon = icon('arrows-rotate'), class = "btn-success"))),
                           br(),
                           
                           p("Choix des tranches d'ancienneté"),
                           
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="J_Anc_1_tranches", label="Tranche 1", min=0, max=45, value=c(0, 1), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_J_tranche_1", label= "Majoration 1, en %", min=0, max= 50, value=0, width="90%"),
                               sliderInput(inputId="J_Anc_3_tranches", label="Tranche 3", min=0, max=45, value=c(2.5, 4), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_J_tranche_3", label= "Majoration 3, en %", min=0, max= 50, value=7, width="90%"),
                               sliderInput(inputId="J_Anc_5_tranches", label="Tranche 5", min=0, max=45, value=c(5, 10), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_J_tranche_5", label= "Majoration 5, en %", min=0, max= 50, value=12, width="90%"),
                               sliderInput(inputId="J_Anc_7_tranches", label="Tranche 7", min=0, max=45, value=c(15, 20), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_J_tranche_7", label= "Majoration 7, en %", min=0, max= 50, value=17, width="90%"),
                               sliderInput(inputId="J_Anc_9_tranches", label="Tranche 9", min=0, max=45, value=c(25, 30), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_J_tranche_9", label= "Majoration 9, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                             
                             
                           ),
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="J_Anc_2_tranches", label="Tranche 2", min=0, max=45, value=c(1, 2.5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_J_tranche_2", label= "Majoration 2, en %", min=0, max= 50, value=3, width="90%"),
                               sliderInput(inputId="J_Anc_4_tranches", label="Tranche 4", min=0, max=45, value=c(4, 5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_J_tranche_4", label= "Majoration 4, en %", min=0, max= 50, value=10, width="90%"),
                               sliderInput(inputId="J_Anc_6_tranches", label="Tranche 6", min=0, max=45, value=c(10, 15), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_J_tranche_6", label= "Majoration 6, en %", min=0, max= 50, value=14, width="90%"),
                               sliderInput(inputId="J_Anc_8_tranches", label="Tranche 8", min=0, max=45, value=c(20, 25), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_J_tranche_8", label= "Majoration 8, en %", min=0, max= 50, value=20, width="90%"),
                               sliderInput(inputId="J_Anc_10_tranches", label="Tranche 10", min=0, max=45, value=c(30, 45), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_J_tranche_10", label= "Majoration 10, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                           )
                         ),
                         conditionalPanel(
                           condition = "input.choixgroupe == 'K' ",
                           fluidRow(
                             column(width = 12,
                                    actionButton(inputId = "reset_K_values", label = "Réinitialiser les valeurs pour le groupe K",icon = icon('arrows-rotate'), class = "btn-success"))),
                           br(),
                           
                           p("Choix des tranches d'ancienneté"),
                           
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="K_Anc_1_tranches", label="Tranche 1", min=0, max=45, value=c(0, 1), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_K_tranche_1", label= "Majoration 1, en %", min=0, max= 50, value=0, width="90%"),
                               sliderInput(inputId="K_Anc_3_tranches", label="Tranche 3", min=0, max=45, value=c(2.5, 4), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_K_tranche_3", label= "Majoration 3, en %", min=0, max= 50, value=7, width="90%"),
                               sliderInput(inputId="K_Anc_5_tranches", label="Tranche 5", min=0, max=45, value=c(5, 10), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_K_tranche_5", label= "Majoration 5, en %", min=0, max= 50, value=12, width="90%"),
                               sliderInput(inputId="K_Anc_7_tranches", label="Tranche 7", min=0, max=45, value=c(15, 20), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_K_tranche_7", label= "Majoration 7, en %", min=0, max= 50, value=17, width="90%"),
                               sliderInput(inputId="K_Anc_9_tranches", label="Tranche 9", min=0, max=45, value=c(25, 30), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_K_tranche_9", label= "Majoration 9, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                             
                             
                           ),
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="K_Anc_2_tranches", label="Tranche 2", min=0, max=45, value=c(1, 2.5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_K_tranche_2", label= "Majoration 2, en %", min=0, max= 50, value=3, width="90%"),
                               sliderInput(inputId="K_Anc_4_tranches", label="Tranche 4", min=0, max=45, value=c(4, 5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_K_tranche_4", label= "Majoration 4, en %", min=0, max= 50, value=10, width="90%"),
                               sliderInput(inputId="K_Anc_6_tranches", label="Tranche 6", min=0, max=45, value=c(10, 15), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_K_tranche_6", label= "Majoration 6, en %", min=0, max= 50, value=14, width="90%"),
                               sliderInput(inputId="K_Anc_8_tranches", label="Tranche 8", min=0, max=45, value=c(20, 25), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_K_tranche_8", label= "Majoration 8, en %", min=0, max= 50, value=20, width="90%"),
                               sliderInput(inputId="K_Anc_10_tranches", label="Tranche 10", min=0, max=45, value=c(30, 45), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_K_tranche_10", label= "Majoration 10, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                           )
                         ),
                         conditionalPanel(
                           condition = "input.choixgroupe == 'L' ",
                           fluidRow(
                             column(width = 12,
                                    actionButton(inputId = "reset_L_values", label = "Réinitialiser les valeurs pour le groupe L",icon = icon('arrows-rotate'), class = "btn-success"))),
                           br(),
                           
                           p("Choix des tranches d'ancienneté"),
                           
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="L_Anc_1_tranches", label="Tranche 1", min=0, max=45, value=c(0, 1), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_L_tranche_1", label= "Majoration 1, en %", min=0, max= 50, value=0, width="90%"),
                               sliderInput(inputId="L_Anc_3_tranches", label="Tranche 3", min=0, max=45, value=c(2.5, 4), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_L_tranche_3", label= "Majoration 3, en %", min=0, max= 50, value=7, width="90%"),
                               sliderInput(inputId="L_Anc_5_tranches", label="Tranche 5", min=0, max=45, value=c(5, 10), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_L_tranche_5", label= "Majoration 5, en %", min=0, max= 50, value=12, width="90%"),
                               sliderInput(inputId="L_Anc_7_tranches", label="Tranche 7", min=0, max=45, value=c(15, 20), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_L_tranche_7", label= "Majoration 7, en %", min=0, max= 50, value=17, width="90%"),
                               sliderInput(inputId="L_Anc_9_tranches", label="Tranche 9", min=0, max=45, value=c(25, 30), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_L_tranche_9", label= "Majoration 9, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                             
                             
                           ),
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="L_Anc_2_tranches", label="Tranche 2", min=0, max=45, value=c(1, 2.5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_L_tranche_2", label= "Majoration 2, en %", min=0, max= 50, value=3, width="90%"),
                               sliderInput(inputId="L_Anc_4_tranches", label="Tranche 4", min=0, max=45, value=c(4, 5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_L_tranche_4", label= "Majoration 4, en %", min=0, max= 50, value=10, width="90%"),
                               sliderInput(inputId="L_Anc_6_tranches", label="Tranche 6", min=0, max=45, value=c(10, 15), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_L_tranche_6", label= "Majoration 6, en %", min=0, max= 50, value=14, width="90%"),
                               sliderInput(inputId="L_Anc_8_tranches", label="Tranche 8", min=0, max=45, value=c(20, 25), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_L_tranche_8", label= "Majoration 8, en %", min=0, max= 50, value=20, width="90%"),
                               sliderInput(inputId="L_Anc_10_tranches", label="Tranche 10", min=0, max=45, value=c(30, 45), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_L_tranche_10", label= "Majoration 10, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                           )
                         ),
                         conditionalPanel(
                           condition = "input.choixgroupe == 'M' ",
                           fluidRow(
                             column(width = 12,
                                    actionButton(inputId = "reset_M_values", label = "Réinitialiser les valeurs pour le groupe M",icon = icon('arrows-rotate'), class = "btn-success"))),
                           br(),
                           
                           p("Choix des tranches d'ancienneté"),
                           
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="M_Anc_1_tranches", label="Tranche 1", min=0, max=45, value=c(0, 1), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_M_tranche_1", label= "Majoration 1, en %", min=0, max= 50, value=0, width="90%"),
                               sliderInput(inputId="M_Anc_3_tranches", label="Tranche 3", min=0, max=45, value=c(2.5, 4), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_M_tranche_3", label= "Majoration 3, en %", min=0, max= 50, value=7, width="90%"),
                               sliderInput(inputId="M_Anc_5_tranches", label="Tranche 5", min=0, max=45, value=c(5, 10), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_M_tranche_5", label= "Majoration 5, en %", min=0, max= 50, value=12, width="90%"),
                               sliderInput(inputId="M_Anc_7_tranches", label="Tranche 7", min=0, max=45, value=c(15, 20), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_M_tranche_7", label= "Majoration 7, en %", min=0, max= 50, value=17, width="90%"),
                               sliderInput(inputId="M_Anc_9_tranches", label="Tranche 9", min=0, max=45, value=c(25, 30), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_M_tranche_9", label= "Majoration 9, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                             
                             
                           ),
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="M_Anc_2_tranches", label="Tranche 2", min=0, max=45, value=c(1, 2.5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_M_tranche_2", label= "Majoration 2, en %", min=0, max= 50, value=3, width="90%"),
                               sliderInput(inputId="M_Anc_4_tranches", label="Tranche 4", min=0, max=45, value=c(4, 5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_M_tranche_4", label= "Majoration 4, en %", min=0, max= 50, value=10, width="90%"),
                               sliderInput(inputId="M_Anc_6_tranches", label="Tranche 6", min=0, max=45, value=c(10, 15), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_M_tranche_6", label= "Majoration 6, en %", min=0, max= 50, value=14, width="90%"),
                               sliderInput(inputId="M_Anc_8_tranches", label="Tranche 8", min=0, max=45, value=c(20, 25), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_M_tranche_8", label= "Majoration 8, en %", min=0, max= 50, value=20, width="90%"),
                               sliderInput(inputId="M_Anc_10_tranches", label="Tranche 10", min=0, max=45, value=c(30, 45), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_M_tranche_10", label= "Majoration 10, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                           )
                         ),
                         conditionalPanel(
                           condition = "input.choixgroupe == 'N' ",
                           fluidRow(
                             column(width = 12,
                                    actionButton(inputId = "reset_N_values", label = "Réinitialiser les valeurs pour le groupe N",icon = icon('arrows-rotate'), class = "btn-success"))),
                           br(),
                           
                           p("Choix des tranches d'ancienneté"),
                           
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="N_Anc_1_tranches", label="Tranche 1", min=0, max=45, value=c(0, 1), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_N_tranche_1", label= "Majoration 1, en %", min=0, max= 50, value=0, width="90%"),
                               sliderInput(inputId="N_Anc_3_tranches", label="Tranche 3", min=0, max=45, value=c(2.5, 4), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_N_tranche_3", label= "Majoration 3, en %", min=0, max= 50, value=7, width="90%"),
                               sliderInput(inputId="N_Anc_5_tranches", label="Tranche 5", min=0, max=45, value=c(5, 10), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_N_tranche_5", label= "Majoration 5, en %", min=0, max= 50, value=12, width="90%"),
                               sliderInput(inputId="N_Anc_7_tranches", label="Tranche 7", min=0, max=45, value=c(15, 20), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_N_tranche_7", label= "Majoration 7, en %", min=0, max= 50, value=17, width="90%"),
                               sliderInput(inputId="N_Anc_9_tranches", label="Tranche 9", min=0, max=45, value=c(25, 30), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_N_tranche_9", label= "Majoration 9, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                             
                             
                           ),
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="N_Anc_2_tranches", label="Tranche 2", min=0, max=45, value=c(1, 2.5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_N_tranche_2", label= "Majoration 2, en %", min=0, max= 50, value=3, width="90%"),
                               sliderInput(inputId="N_Anc_4_tranches", label="Tranche 4", min=0, max=45, value=c(4, 5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_N_tranche_4", label= "Majoration 4, en %", min=0, max= 50, value=10, width="90%"),
                               sliderInput(inputId="N_Anc_6_tranches", label="Tranche 6", min=0, max=45, value=c(10, 15), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_N_tranche_6", label= "Majoration 6, en %", min=0, max= 50, value=14, width="90%"),
                               sliderInput(inputId="N_Anc_8_tranches", label="Tranche 8", min=0, max=45, value=c(20, 25), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_N_tranche_8", label= "Majoration 8, en %", min=0, max= 50, value=20, width="90%"),
                               sliderInput(inputId="N_Anc_10_tranches", label="Tranche 10", min=0, max=45, value=c(30, 45), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_N_tranche_10", label= "Majoration 10, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                           )
                         ),
                         conditionalPanel(
                           condition = "input.choixgroupe == 'O' ",
                           fluidRow(
                             column(width = 12,
                                    actionButton(inputId = "reset_O_values", label = "Réinitialiser les valeurs pour le groupe O",icon = icon('arrows-rotate'), class = "btn-success"))),
                           br(),
                           
                           p("Choix des tranches d'ancienneté"),
                           
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="O_Anc_1_tranches", label="Tranche 1", min=0, max=45, value=c(0, 1), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_O_tranche_1", label= "Majoration 1, en %", min=0, max= 50, value=0, width="90%"),
                               sliderInput(inputId="O_Anc_3_tranches", label="Tranche 3", min=0, max=45, value=c(2.5, 4), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_O_tranche_3", label= "Majoration 3, en %", min=0, max= 50, value=7, width="90%"),
                               sliderInput(inputId="O_Anc_5_tranches", label="Tranche 5", min=0, max=45, value=c(5, 10), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_O_tranche_5", label= "Majoration 5, en %", min=0, max= 50, value=12, width="90%"),
                               sliderInput(inputId="O_Anc_7_tranches", label="Tranche 7", min=0, max=45, value=c(15, 20), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_O_tranche_7", label= "Majoration 7, en %", min=0, max= 50, value=17, width="90%"),
                               sliderInput(inputId="O_Anc_9_tranches", label="Tranche 9", min=0, max=45, value=c(25, 30), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_O_tranche_9", label= "Majoration 9, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                             
                             
                           ),
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="O_Anc_2_tranches", label="Tranche 2", min=0, max=45, value=c(1, 2.5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_O_tranche_2", label= "Majoration 2, en %", min=0, max= 50, value=3, width="90%"),
                               sliderInput(inputId="O_Anc_4_tranches", label="Tranche 4", min=0, max=45, value=c(4, 5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_O_tranche_4", label= "Majoration 4, en %", min=0, max= 50, value=10, width="90%"),
                               sliderInput(inputId="O_Anc_6_tranches", label="Tranche 6", min=0, max=45, value=c(10, 15), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_O_tranche_6", label= "Majoration 6, en %", min=0, max= 50, value=14, width="90%"),
                               sliderInput(inputId="O_Anc_8_tranches", label="Tranche 8", min=0, max=45, value=c(20, 25), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_O_tranche_8", label= "Majoration 8, en %", min=0, max= 50, value=20, width="90%"),
                               sliderInput(inputId="O_Anc_10_tranches", label="Tranche 10", min=0, max=45, value=c(30, 45), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_O_tranche_10", label= "Majoration 10, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                           )
                         ),
                         conditionalPanel(
                           condition = "input.choixgroupe == 'P' ",
                           fluidRow(
                             column(width = 12,
                                    actionButton(inputId = "reset_P_values", label = "Réinitialiser les valeurs pour le groupe P",icon = icon('arrows-rotate'), class = "btn-success"))),
                           br(),
                           
                           p("Choix des tranches d'ancienneté"),
                           
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="P_Anc_1_tranches", label="Tranche 1", min=0, max=45, value=c(0, 1), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_P_tranche_1", label= "Majoration 1, en %", min=0, max= 50, value=0, width="90%"),
                               sliderInput(inputId="P_Anc_3_tranches", label="Tranche 3", min=0, max=45, value=c(2.5, 4), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_P_tranche_3", label= "Majoration 3, en %", min=0, max= 50, value=7, width="90%"),
                               sliderInput(inputId="P_Anc_5_tranches", label="Tranche 5", min=0, max=45, value=c(5, 10), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_P_tranche_5", label= "Majoration 5, en %", min=0, max= 50, value=12, width="90%"),
                               sliderInput(inputId="P_Anc_7_tranches", label="Tranche 7", min=0, max=45, value=c(15, 20), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_P_tranche_7", label= "Majoration 7, en %", min=0, max= 50, value=17, width="90%"),
                               sliderInput(inputId="P_Anc_9_tranches", label="Tranche 9", min=0, max=45, value=c(25, 30), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_P_tranche_9", label= "Majoration 9, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                             
                             
                           ),
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="P_Anc_2_tranches", label="Tranche 2", min=0, max=45, value=c(1, 2.5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_P_tranche_2", label= "Majoration 2, en %", min=0, max= 50, value=3, width="90%"),
                               sliderInput(inputId="P_Anc_4_tranches", label="Tranche 4", min=0, max=45, value=c(4, 5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_P_tranche_4", label= "Majoration 4, en %", min=0, max= 50, value=10, width="90%"),
                               sliderInput(inputId="P_Anc_6_tranches", label="Tranche 6", min=0, max=45, value=c(10, 15), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_P_tranche_6", label= "Majoration 6, en %", min=0, max= 50, value=14, width="90%"),
                               sliderInput(inputId="P_Anc_8_tranches", label="Tranche 8", min=0, max=45, value=c(20, 25), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_P_tranche_8", label= "Majoration 8, en %", min=0, max= 50, value=20, width="90%"),
                               sliderInput(inputId="P_Anc_10_tranches", label="Tranche 10", min=0, max=45, value=c(30, 45), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_P_tranche_10", label= "Majoration 10, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                           )
                         ),
                         conditionalPanel(
                           condition = "input.choixgroupe == 'Q' ",
                           fluidRow(
                             column(width = 12,
                                    actionButton(inputId = "reset_Q_values", label = "Réinitialiser les valeurs pour le groupe Q",icon = icon('arrows-rotate'), class = "btn-success"))),
                           br(),
                           
                           p("Choix des tranches d'ancienneté"),
                           
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="Q_Anc_1_tranches", label="Tranche 1", min=0, max=45, value=c(0, 1), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_Q_tranche_1", label= "Majoration 1, en %", min=0, max= 50, value=0, width="90%"),
                               sliderInput(inputId="Q_Anc_3_tranches", label="Tranche 3", min=0, max=45, value=c(2.5, 4), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_Q_tranche_3", label= "Majoration 3, en %", min=0, max= 50, value=7, width="90%"),
                               sliderInput(inputId="Q_Anc_5_tranches", label="Tranche 5", min=0, max=45, value=c(5, 10), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_Q_tranche_5", label= "Majoration 5, en %", min=0, max= 50, value=12, width="90%"),
                               sliderInput(inputId="Q_Anc_7_tranches", label="Tranche 7", min=0, max=45, value=c(15, 20), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_Q_tranche_7", label= "Majoration 7, en %", min=0, max= 50, value=17, width="90%"),
                               sliderInput(inputId="Q_Anc_9_tranches", label="Tranche 9", min=0, max=45, value=c(25, 30), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_Q_tranche_9", label= "Majoration 9, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                             
                             
                           ),
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="Q_Anc_2_tranches", label="Tranche 2", min=0, max=45, value=c(1, 2.5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_Q_tranche_2", label= "Majoration 2, en %", min=0, max= 50, value=3, width="90%"),
                               sliderInput(inputId="Q_Anc_4_tranches", label="Tranche 4", min=0, max=45, value=c(4, 5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_Q_tranche_4", label= "Majoration 4, en %", min=0, max= 50, value=10, width="90%"),
                               sliderInput(inputId="Q_Anc_6_tranches", label="Tranche 6", min=0, max=45, value=c(10, 15), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_Q_tranche_6", label= "Majoration 6, en %", min=0, max= 50, value=14, width="90%"),
                               sliderInput(inputId="Q_Anc_8_tranches", label="Tranche 8", min=0, max=45, value=c(20, 25), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_Q_tranche_8", label= "Majoration 8, en %", min=0, max= 50, value=20, width="90%"),
                               sliderInput(inputId="Q_Anc_10_tranches", label="Tranche 10", min=0, max=45, value=c(30, 45), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_Q_tranche_10", label= "Majoration 10, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                           )
                         ),
                         conditionalPanel(
                           condition = "input.choixgroupe == 'R' ",
                           fluidRow(
                             column(width = 12,
                                    actionButton(inputId = "reset_R_values", label = "Réinitialiser les valeurs pour le groupe R",icon = icon('arrows-rotate'), class = "btn-success"))),
                           br(),
                           
                           p("Choix des tranches d'ancienneté"),
                           
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="R_Anc_1_tranches", label="Tranche 1", min=0, max=45, value=c(0, 1), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_R_tranche_1", label= "Majoration 1, en %", min=0, max= 50, value=0, width="90%"),
                               sliderInput(inputId="R_Anc_3_tranches", label="Tranche 3", min=0, max=45, value=c(2.5, 4), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_R_tranche_3", label= "Majoration 3, en %", min=0, max= 50, value=7, width="90%"),
                               sliderInput(inputId="R_Anc_5_tranches", label="Tranche 5", min=0, max=45, value=c(5, 10), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_R_tranche_5", label= "Majoration 5, en %", min=0, max= 50, value=12, width="90%"),
                               sliderInput(inputId="R_Anc_7_tranches", label="Tranche 7", min=0, max=45, value=c(15, 20), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_R_tranche_7", label= "Majoration 7, en %", min=0, max= 50, value=17, width="90%"),
                               sliderInput(inputId="R_Anc_9_tranches", label="Tranche 9", min=0, max=45, value=c(25, 30), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_R_tranche_9", label= "Majoration 9, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                             
                             
                           ),
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="R_Anc_2_tranches", label="Tranche 2", min=0, max=45, value=c(1, 2.5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_R_tranche_2", label= "Majoration 2, en %", min=0, max= 50, value=3, width="90%"),
                               sliderInput(inputId="R_Anc_4_tranches", label="Tranche 4", min=0, max=45, value=c(4, 5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_R_tranche_4", label= "Majoration 4, en %", min=0, max= 50, value=10, width="90%"),
                               sliderInput(inputId="R_Anc_6_tranches", label="Tranche 6", min=0, max=45, value=c(10, 15), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_R_tranche_6", label= "Majoration 6, en %", min=0, max= 50, value=14, width="90%"),
                               sliderInput(inputId="R_Anc_8_tranches", label="Tranche 8", min=0, max=45, value=c(20, 25), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_R_tranche_8", label= "Majoration 8, en %", min=0, max= 50, value=20, width="90%"),
                               sliderInput(inputId="R_Anc_10_tranches", label="Tranche 10", min=0, max=45, value=c(30, 45), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_R_tranche_10", label= "Majoration 10, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                           )
                         ),
                         conditionalPanel(
                           condition = "input.choixgroupe == 'S' ",
                           fluidRow(
                             column(width = 12,
                                    actionButton(inputId = "reset_S_values", label = "Réinitialiser les valeurs pour le groupe S",icon = icon('arrows-rotate'), class = "btn-success"))),
                           br(),
                           
                           p("Choix des tranches d'ancienneté"),
                           
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="S_Anc_1_tranches", label="Tranche 1", min=0, max=45, value=c(0, 1), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_S_tranche_1", label= "Majoration 1, en %", min=0, max= 50, value=0, width="90%"),
                               sliderInput(inputId="S_Anc_3_tranches", label="Tranche 3", min=0, max=45, value=c(2.5, 4), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_S_tranche_3", label= "Majoration 3, en %", min=0, max= 50, value=7, width="90%"),
                               sliderInput(inputId="S_Anc_5_tranches", label="Tranche 5", min=0, max=45, value=c(5, 10), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_S_tranche_5", label= "Majoration 5, en %", min=0, max= 50, value=12, width="90%"),
                               sliderInput(inputId="S_Anc_7_tranches", label="Tranche 7", min=0, max=45, value=c(15, 20), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_S_tranche_7", label= "Majoration 7, en %", min=0, max= 50, value=17, width="90%"),
                               sliderInput(inputId="S_Anc_9_tranches", label="Tranche 9", min=0, max=45, value=c(25, 30), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_S_tranche_9", label= "Majoration 9, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                             
                             
                           ),
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="S_Anc_2_tranches", label="Tranche 2", min=0, max=45, value=c(1, 2.5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_S_tranche_2", label= "Majoration 2, en %", min=0, max= 50, value=3, width="90%"),
                               sliderInput(inputId="S_Anc_4_tranches", label="Tranche 4", min=0, max=45, value=c(4, 5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_S_tranche_4", label= "Majoration 4, en %", min=0, max= 50, value=10, width="90%"),
                               sliderInput(inputId="S_Anc_6_tranches", label="Tranche 6", min=0, max=45, value=c(10, 15), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_S_tranche_6", label= "Majoration 6, en %", min=0, max= 50, value=14, width="90%"),
                               sliderInput(inputId="S_Anc_8_tranches", label="Tranche 8", min=0, max=45, value=c(20, 25), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_S_tranche_8", label= "Majoration 8, en %", min=0, max= 50, value=20, width="90%"),
                               sliderInput(inputId="S_Anc_10_tranches", label="Tranche 10", min=0, max=45, value=c(30, 45), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_S_tranche_10", label= "Majoration 10, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                           )
                         ),
                         conditionalPanel(
                           condition = "input.choixgroupe == 'T' ",
                           fluidRow(
                             column(width = 12,
                                    actionButton(inputId = "reset_T_values", label = "Réinitialiser les valeurs pour le groupe T",icon = icon('arrows-rotate'), class = "btn-success"))),
                           br(),
                           
                           p("Choix des tranches d'ancienneté"),
                           
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="T_Anc_1_tranches", label="Tranche 1", min=0, max=45, value=c(0, 1), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_T_tranche_1", label= "Majoration 1, en %", min=0, max= 50, value=0, width="90%"),
                               sliderInput(inputId="T_Anc_3_tranches", label="Tranche 3", min=0, max=45, value=c(2.5, 4), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_T_tranche_3", label= "Majoration 3, en %", min=0, max= 50, value=7, width="90%"),
                               sliderInput(inputId="T_Anc_5_tranches", label="Tranche 5", min=0, max=45, value=c(5, 10), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_T_tranche_5", label= "Majoration 5, en %", min=0, max= 50, value=12, width="90%"),
                               sliderInput(inputId="T_Anc_7_tranches", label="Tranche 7", min=0, max=45, value=c(15, 20), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_T_tranche_7", label= "Majoration 7, en %", min=0, max= 50, value=17, width="90%"),
                               sliderInput(inputId="T_Anc_9_tranches", label="Tranche 9", min=0, max=45, value=c(25, 30), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_T_tranche_9", label= "Majoration 9, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                             
                             
                           ),
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="T_Anc_2_tranches", label="Tranche 2", min=0, max=45, value=c(1, 2.5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_T_tranche_2", label= "Majoration 2, en %", min=0, max= 50, value=3, width="90%"),
                               sliderInput(inputId="T_Anc_4_tranches", label="Tranche 4", min=0, max=45, value=c(4, 5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_T_tranche_4", label= "Majoration 4, en %", min=0, max= 50, value=10, width="90%"),
                               sliderInput(inputId="T_Anc_6_tranches", label="Tranche 6", min=0, max=45, value=c(10, 15), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_T_tranche_6", label= "Majoration 6, en %", min=0, max= 50, value=14, width="90%"),
                               sliderInput(inputId="T_Anc_8_tranches", label="Tranche 8", min=0, max=45, value=c(20, 25), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_T_tranche_8", label= "Majoration 8, en %", min=0, max= 50, value=20, width="90%"),
                               sliderInput(inputId="T_Anc_10_tranches", label="Tranche 10", min=0, max=45, value=c(30, 45), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_T_tranche_10", label= "Majoration 10, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                           )
                         ),
                         conditionalPanel(
                           condition = "input.choixgroupe == 'U'",
                           fluidRow(
                             column(width = 12,
                                    actionButton(inputId = "reset_U_values", label = "Réinitialiser les valeurs pour le groupe U",icon = icon('arrows-rotate'), class = "btn-success"))),
                           br(),
                           
                           p("Choix des tranches d'ancienneté"),
                           
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="U_Anc_1_tranches", label="Tranche 1", min=0, max=45, value=c(0, 1), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_U_tranche_1", label= "Majoration 1, en %", min=0, max= 50, value=0, width="90%"),
                               sliderInput(inputId="U_Anc_3_tranches", label="Tranche 3", min=0, max=45, value=c(2.5, 4), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_U_tranche_3", label= "Majoration 3, en %", min=0, max= 50, value=7, width="90%"),
                               sliderInput(inputId="U_Anc_5_tranches", label="Tranche 5", min=0, max=45, value=c(5, 10), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_U_tranche_5", label= "Majoration 5, en %", min=0, max= 50, value=12, width="90%"),
                               sliderInput(inputId="U_Anc_7_tranches", label="Tranche 7", min=0, max=45, value=c(15, 20), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_U_tranche_7", label= "Majoration 7, en %", min=0, max= 50, value=17, width="90%"),
                               sliderInput(inputId="U_Anc_9_tranches", label="Tranche 9", min=0, max=45, value=c(25, 30), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_U_tranche_9", label= "Majoration 9, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                             
                             
                           ),
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="U_Anc_2_tranches", label="Tranche 2", min=0, max=45, value=c(1, 2.5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_U_tranche_2", label= "Majoration 2, en %", min=0, max= 50, value=3, width="90%"),
                               sliderInput(inputId="U_Anc_4_tranches", label="Tranche 4", min=0, max=45, value=c(4, 5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_U_tranche_4", label= "Majoration 4, en %", min=0, max= 50, value=10, width="90%"),
                               sliderInput(inputId="U_Anc_6_tranches", label="Tranche 6", min=0, max=45, value=c(10, 15), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_U_tranche_6", label= "Majoration 6, en %", min=0, max= 50, value=14, width="90%"),
                               sliderInput(inputId="U_Anc_8_tranches", label="Tranche 8", min=0, max=45, value=c(20, 25), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_U_tranche_8", label= "Majoration 8, en %", min=0, max= 50, value=20, width="90%"),
                               sliderInput(inputId="U_Anc_10_tranches", label="Tranche 10", min=0, max=45, value=c(30, 45), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_U_tranche_10", label= "Majoration 10, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                           )
                         ),
                         conditionalPanel(
                           condition = "input.choixgroupe == 'V' ",
                           fluidRow(
                             column(width = 12,
                                    actionButton(inputId = "reset_V_values", label = "Réinitialiser les valeurs pour le groupe V",icon = icon('arrows-rotate'), class = "btn-success"))),
                           br(),
                           
                           p("Choix des tranches d'ancienneté"),
                           
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="V_Anc_1_tranches", label="Tranche 1", min=0, max=45, value=c(0, 1), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_V_tranche_1", label= "Majoration 1, en %", min=0, max= 50, value=0, width="90%"),
                               sliderInput(inputId="V_Anc_3_tranches", label="Tranche 3", min=0, max=45, value=c(2.5, 4), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_V_tranche_3", label= "Majoration 3, en %", min=0, max= 50, value=7, width="90%"),
                               sliderInput(inputId="V_Anc_5_tranches", label="Tranche 5", min=0, max=45, value=c(5, 10), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_V_tranche_5", label= "Majoration 5, en %", min=0, max= 50, value=12, width="90%"),
                               sliderInput(inputId="V_Anc_7_tranches", label="Tranche 7", min=0, max=45, value=c(15, 20), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_V_tranche_7", label= "Majoration 7, en %", min=0, max= 50, value=17, width="90%"),
                               sliderInput(inputId="V_Anc_9_tranches", label="Tranche 9", min=0, max=45, value=c(25, 30), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_V_tranche_9", label= "Majoration 9, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                             
                             
                           ),
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="V_Anc_2_tranches", label="Tranche 2", min=0, max=45, value=c(1, 2.5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_V_tranche_2", label= "Majoration 2, en %", min=0, max= 50, value=3, width="90%"),
                               sliderInput(inputId="V_Anc_4_tranches", label="Tranche 4", min=0, max=45, value=c(4, 5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_V_tranche_4", label= "Majoration 4, en %", min=0, max= 50, value=10, width="90%"),
                               sliderInput(inputId="V_Anc_6_tranches", label="Tranche 6", min=0, max=45, value=c(10, 15), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_V_tranche_6", label= "Majoration 6, en %", min=0, max= 50, value=14, width="90%"),
                               sliderInput(inputId="V_Anc_8_tranches", label="Tranche 8", min=0, max=45, value=c(20, 25), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_V_tranche_8", label= "Majoration 8, en %", min=0, max= 50, value=20, width="90%"),
                               sliderInput(inputId="V_Anc_10_tranches", label="Tranche 10", min=0, max=45, value=c(30, 45), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_V_tranche_10", label= "Majoration 10, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                           )
                         ),
                         conditionalPanel(
                           condition = "input.choixgroupe == 'W' ",
                           fluidRow(
                             column(width = 12,
                                    actionButton(inputId = "reset_W_values", label = "Réinitialiser les valeurs pour le groupe W",icon = icon('arrows-rotate'), class = "btn-success"))),
                           br(),
                           
                           p("Choix des tranches d'ancienneté"),
                           
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="W_Anc_1_tranches", label="Tranche 1", min=0, max=45, value=c(0, 1), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_W_tranche_1", label= "Majoration 1, en %", min=0, max= 50, value=0, width="90%"),
                               sliderInput(inputId="W_Anc_3_tranches", label="Tranche 3", min=0, max=45, value=c(2.5, 4), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_W_tranche_3", label= "Majoration 3, en %", min=0, max= 50, value=7, width="90%"),
                               sliderInput(inputId="W_Anc_5_tranches", label="Tranche 5", min=0, max=45, value=c(5, 10), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_W_tranche_5", label= "Majoration 5, en %", min=0, max= 50, value=12, width="90%"),
                               sliderInput(inputId="W_Anc_7_tranches", label="Tranche 7", min=0, max=45, value=c(15, 20), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_W_tranche_7", label= "Majoration 7, en %", min=0, max= 50, value=17, width="90%"),
                               sliderInput(inputId="W_Anc_9_tranches", label="Tranche 9", min=0, max=45, value=c(25, 30), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_W_tranche_9", label= "Majoration 9, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                             
                             
                           ),
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="W_Anc_2_tranches", label="Tranche 2", min=0, max=45, value=c(1, 2.5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_W_tranche_2", label= "Majoration 2, en %", min=0, max= 50, value=3, width="90%"),
                               sliderInput(inputId="W_Anc_4_tranches", label="Tranche 4", min=0, max=45, value=c(4, 5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_W_tranche_4", label= "Majoration 4, en %", min=0, max= 50, value=10, width="90%"),
                               sliderInput(inputId="W_Anc_6_tranches", label="Tranche 6", min=0, max=45, value=c(10, 15), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_W_tranche_6", label= "Majoration 6, en %", min=0, max= 50, value=14, width="90%"),
                               sliderInput(inputId="W_Anc_8_tranches", label="Tranche 8", min=0, max=45, value=c(20, 25), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_W_tranche_8", label= "Majoration 8, en %", min=0, max= 50, value=20, width="90%"),
                               sliderInput(inputId="W_Anc_10_tranches", label="Tranche 10", min=0, max=45, value=c(30, 45), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_W_tranche_10", label= "Majoration 10, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                           )
                         ),
                         conditionalPanel(
                           condition = "input.choixgroupe == 'X' ",
                           fluidRow(
                             column(width = 12,
                                    actionButton(inputId = "reset_X_values", label = "Réinitialiser les valeurs pour le groupe X",icon = icon('arrows-rotate'), class = "btn-success"))),
                           br(),
                           
                           p("Choix des tranches d'ancienneté"),
                           
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="X_Anc_1_tranches", label="Tranche 1", min=0, max=45, value=c(0, 1), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_X_tranche_1", label= "Majoration 1, en %", min=0, max= 50, value=0, width="90%"),
                               sliderInput(inputId="X_Anc_3_tranches", label="Tranche 3", min=0, max=45, value=c(2.5, 4), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_X_tranche_3", label= "Majoration 3, en %", min=0, max= 50, value=7, width="90%"),
                               sliderInput(inputId="X_Anc_5_tranches", label="Tranche 5", min=0, max=45, value=c(5, 10), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_X_tranche_5", label= "Majoration 5, en %", min=0, max= 50, value=12, width="90%"),
                               sliderInput(inputId="X_Anc_7_tranches", label="Tranche 7", min=0, max=45, value=c(15, 20), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_X_tranche_7", label= "Majoration 7, en %", min=0, max= 50, value=17, width="90%"),
                               sliderInput(inputId="X_Anc_9_tranches", label="Tranche 9", min=0, max=45, value=c(25, 30), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_X_tranche_9", label= "Majoration 9, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                             
                             
                           ),
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="X_Anc_2_tranches", label="Tranche 2", min=0, max=45, value=c(1, 2.5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_X_tranche_2", label= "Majoration 2, en %", min=0, max= 50, value=3, width="90%"),
                               sliderInput(inputId="X_Anc_4_tranches", label="Tranche 4", min=0, max=45, value=c(4, 5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_X_tranche_4", label= "Majoration 4, en %", min=0, max= 50, value=10, width="90%"),
                               sliderInput(inputId="X_Anc_6_tranches", label="Tranche 6", min=0, max=45, value=c(10, 15), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_X_tranche_6", label= "Majoration 6, en %", min=0, max= 50, value=14, width="90%"),
                               sliderInput(inputId="X_Anc_8_tranches", label="Tranche 8", min=0, max=45, value=c(20, 25), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_X_tranche_8", label= "Majoration 8, en %", min=0, max= 50, value=20, width="90%"),
                               sliderInput(inputId="X_Anc_10_tranches", label="Tranche 10", min=0, max=45, value=c(30, 45), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_X_tranche_10", label= "Majoration 10, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                           )
                         ),
                         conditionalPanel(
                           condition = "input.choixgroupe == 'Y' ",
                           fluidRow(
                             column(width = 12,
                                    actionButton(inputId = "reset_Y_values", label = "Réinitialiser les valeurs pour le groupe Y",icon = icon('arrows-rotate'), class = "btn-success"))),
                           br(),
                           
                           p("Choix des tranches d'ancienneté"),
                           
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="Y_Anc_1_tranches", label="Tranche 1", min=0, max=45, value=c(0, 1), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_Y_tranche_1", label= "Majoration 1, en %", min=0, max= 50, value=0, width="90%"),
                               sliderInput(inputId="Y_Anc_3_tranches", label="Tranche 3", min=0, max=45, value=c(2.5, 4), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_Y_tranche_3", label= "Majoration 3, en %", min=0, max= 50, value=7, width="90%"),
                               sliderInput(inputId="Y_Anc_5_tranches", label="Tranche 5", min=0, max=45, value=c(5, 10), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_Y_tranche_5", label= "Majoration 5, en %", min=0, max= 50, value=12, width="90%"),
                               sliderInput(inputId="Y_Anc_7_tranches", label="Tranche 7", min=0, max=45, value=c(15, 20), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_Y_tranche_7", label= "Majoration 7, en %", min=0, max= 50, value=17, width="90%"),
                               sliderInput(inputId="Y_Anc_9_tranches", label="Tranche 9", min=0, max=45, value=c(25, 30), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_Y_tranche_9", label= "Majoration 9, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                             
                             
                           ),
                           column(
                             width=6,
                             fluidRow(
                               align="center",
                               sliderInput(inputId="Y_Anc_2_tranches", label="Tranche 2", min=0, max=45, value=c(1, 2.5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_Y_tranche_2", label= "Majoration 2, en %", min=0, max= 50, value=3, width="90%"),
                               sliderInput(inputId="Y_Anc_4_tranches", label="Tranche 4", min=0, max=45, value=c(4, 5), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_Y_tranche_4", label= "Majoration 4, en %", min=0, max= 50, value=10, width="90%"),
                               sliderInput(inputId="Y_Anc_6_tranches", label="Tranche 6", min=0, max=45, value=c(10, 15), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_Y_tranche_6", label= "Majoration 6, en %", min=0, max= 50, value=14, width="90%"),
                               sliderInput(inputId="Y_Anc_8_tranches", label="Tranche 8", min=0, max=45, value=c(20, 25), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_Y_tranche_8", label= "Majoration 8, en %", min=0, max= 50, value=20, width="90%"),
                               sliderInput(inputId="Y_Anc_10_tranches", label="Tranche 10", min=0, max=45, value=c(30, 45), step=0.5, post = " ans", width="90%"),
                               numericInput(inputId = "maj_Y_tranche_10", label= "Majoration 10, en %", min=0, max= 50, value=23, width="90%")
                               
                             )
                           )
                         ),
                         highchartOutput(outputId = "plot_majoration_anciennete", width = "100%"))
        )),
        box(
          width=12,
          title="Primes incluses dans la rémunération effective",
          status="warning",
          solidHeader = TRUE,
          collapsible=TRUE,
          collapsed = TRUE,
          selectInput(inputId = "remannu_ou_salmens",
                      label = " Choix de la périodicité des variables de rémunération",
                      choices = c("Annuelle", "Mensuelle"),
                      selected = "Mensuelle"),
          
          conditionalPanel(condition = "input.remannu_ou_salmens == 'Annuelle'",
                           checkboxGroupInput(inputId = "primes_choisies_remannu",
                                              label = "Choix des primes à inclure dans le calcul de la rémunération annuelle:",
                                              choices = c("Primes de sujetion", "Prime de déroulement de carrière", "Prime vacances", "Prime de polyvalence","13e mois et au-delà","Bonus et primes de performance"
                                              ),
                                              selected = c("Primes de sujetion", "Prime de déroulement de carrière", "Prime vacances", "Prime de polyvalence","13e mois et au-delà","Bonus et primes de performance"
                                              )),
                           numericInputIcon(inputId = "multiple_mini",label = "Coefficient multiplicateur des minima pour le passage en valeurs annuelles :",
                                            min =11, max =14, step = 0.1, value = 12, icon = icon("signal")) 
          ),
          
          conditionalPanel(condition = "input.remannu_ou_salmens == 'Mensuelle'",
                           checkboxGroupInput(inputId = "primes_choisies_salmens",
                                              label = "Choix des primes à inclure dans le calcul de la rémunération effective à comparer aux minima :",
                                              choices = c("Primes de sujetion", "Prime de déroulement de carrière" , "Prime vacances" , "Prime de polyvalence","13e mois et au-delà","Bonus et primes de performance"
                                              ),
                                              selected = c("Primes de sujetion", "Prime de déroulement de carrière", "Prime vacances", "Prime de polyvalence","13e mois et au-delà","Bonus et primes de performance"
                                              ))
          )
          
          
        )
      ),
      
      column(
        width = 8,
        strong(p("Consultation des résultats", style="color:grey; text-align:center; font-style: bold; font-size:25px;
                 border:1px; border-radius:4px;")),
        
        fluidRow(
          column(
            width = 4,
            pickerInput(
              inputId = "choixfiliere",
              label = tags$span("Choix de filière :", class = "custom-title"),
              choices = c(sort(unique(salaires$filiere))),
              multiple = T ,
              options = list(`none-selected-text` = "Aucune sélection"),
              selected = c(sort(unique(salaires$filiere)))
              ),
            pickerInput(
              inputId = "choixfamille",
              label = tags$span("Choix de famille :", class = "custom-title"),
              choices = c(sort(unique(salaires$famille))),
              multiple = T ,
              options = list(`none-selected-text` = "Aucune sélection"),
              selected = c(sort(unique(salaires$famille)))
          )),
          
          column(
            width = 4,
            
            pickerInput(
              "choixgrp",
              tags$span("Choix du groupe :", class = "custom-title"),
              choices = sort(c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V","W", "X","Y")),
              multiple = T ,
              options = list(`none-selected-text` = "Aucune sélection"),
              selected = sort(c("A","B","C","D","E","F","G","H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V","W", "X","Y"))),
            pickerInput(
              "choixcsp",
              tags$span("Choix de la catégorie socio-pro. :", class = "custom-title"),
              choices = c(sort(unique(salaires$CAT))),
              multiple = T ,
              options = list(`none-selected-text` = "Aucune sélection"),
              selected = c(sort(unique(salaires$CAT))))
          ),
          
          column(
            width = 4,
            pickerInput(
              "choixtranc",
              tags$span("Choix de la tranche d'ancienneté :", class = "custom-title"),
              choices = sort(unique(salaires$tranc)),
              multiple = T ,
              options = list(`none-selected-text` = "Aucune sélection"),
              selected = sort(unique(salaires$tranc))),
            pickerInput(
              "choixreseau",
              tags$span("Choix du groupe employeur :", class = "custom-title"),
              choices = sort(unique(salaires$groupe_empl)),
              multiple = T ,
              options = list(`none-selected-text` = "Aucune sélection"),
              selected = sort(unique(salaires$groupe_empl)))
          )
        ),
        
        fluidRow(
          box(
            width = 12,
            status = "warning",
            solidHeader = TRUE,
            collapsible = TRUE,
            collapsed = FALSE,
            
            title = "Chiffres clés des impacts",
            
            fluidRow(
                valueBoxOutput("eff_reval", width = 6),
                valueBoxOutput("eff_part", width = 6)),
            fluidRow(
                valueBoxOutput("cout_an_tot", width = 6),
                valueBoxOutput("cout_part", width = 6)
            )
          )
        ),

        fluidRow(
        
          box(
            width = 12,
            title = "Détail des revalorisations et des coûts associés",
            status = "warning",
            solidHeader = TRUE,
            collapsible = TRUE,
            collapsed = FALSE,
            
            div(
            

                column(width = 6, selectInput("metric_choice", "Choix de l'indicateur à afficher :", 
                            choices = c("Nombre de salariés revalorisés" = "revalorise",
                                        "Montant total en euros des revalorisations" = "cout_reval",
                                        "Part des effectifs revalorisés" = "part_effectif",
                                        "Montant total des revalorisations en % de la masse salariale" = "part_cout")),
                       checkboxInput("Exclure0","Afficher uniquement les résultats non nuls", TRUE),),
                column(width = 6, selectInput("grouping", "Afficher les résultats par :",
                            choices = c("Filères" = "filiere", "Familles" = "famille", "Emplois-repères" = "lib_repere", "Tranches d'ancienneté" = " tranc", "Groupes" = "grp"))),
                       
            
                highchartOutput("revalorise_chart",height = "497px"))
            )

        ),
        
        fluidRow(
          box(
            width = 12,
            title = "Transposition des effectifs dans la nouvelle classification",
            status = "warning",
            solidHeader = TRUE,
            collapsible = TRUE,
            collapsed = FALSE,
            div(
              selectInput("choixvariable3", "Choix de la variable d'intérêt :", 
                          choices = c("Groupe" = "grp",
                                      "Score" = "scores",
                                      "Emploi-repère" = "code_repere",
                                      "Catégorie socio-professionnelle" = "CAT",
                                      "Coefficient de base" = "coef_tr")),
            highchartOutput("effectif_chart")
            )
          )),
        
        fluidRow(
        box( #box pour le tableau
          width = 12,
          title = "Données individuelles",
          status = "warning",
          solidHeader = TRUE,
          collapsible = TRUE,
          div(id = "collapse_div",
              actionButton("collapse_button", "Sélectionner les variables à afficher", class = "custom-collapse-button"),
              div(id = "collapsible_content",
                  fluidRow(
                    title = "Sélections du tableau : ",
                    class = "collapse-container",
                    column(
                      width = 3,
                      materialSwitch(
                        inputId = 'EMPLOI', 
                        status = 'warning',
                        label = translate_var_col[['EMPLOI']],
                        right = TRUE,
                        value = T
                      ),
                      materialSwitch(
                        inputId = 'groupe_empl',
                        label = translate_var_col[['groupe_empl']],
                        status = 'warning',
                        right = TRUE,
                        value = T
                      ),
                      materialSwitch(
                        inputId = 'lib_repere',
                        label = translate_var_col[['lib_repere']],
                        status = 'warning',
                        right = TRUE,
                        value = T
                      ),
                      materialSwitch(
                        inputId = 'scores',
                        label = translate_var_col[['scores']], 
                        status = 'warning',
                        right = TRUE,
                        value = T
                      ),
                      materialSwitch(
                        inputId = 'grp',
                        label = translate_var_col[['grp']],
                        status = 'warning',
                        right = TRUE,
                        value = T
                      ),
                      materialSwitch(
                        inputId = 'q_newmin',
                        label = translate_var_col[['q_newmin']], 
                        status = 'warning',
                        right = TRUE,
                        value = T
                      ),
                      materialSwitch(
                        inputId = 'revalorise_oui',
                        label = translate_var_col[['revalorise_oui']],
                        status = 'warning',
                        right = TRUE,
                        value = T
                      ),
                      materialSwitch(
                        inputId = 'q_newsal',
                        label = translate_var_col[['q_newsal']], 
                        status = 'warning',
                        right = TRUE,
                        value = T
                        
                      ),
                      materialSwitch(
                        inputId = 'nom_entr',
                        label = translate_var_col[['nom_entr']], 
                        status = 'warning',
                        right = TRUE
                      ),
                      materialSwitch(
                        inputId = 'taille_entr',
                        label = translate_var_col[['taille_entr']], 
                        status = 'warning',
                        right = TRUE
                      ),
                      materialSwitch(
                        inputId = 'CLASSE',
                        label = translate_var_col[['CLASSE']], 
                        status = 'warning',
                        right = TRUE
                      )
                    ),
                    column(
                      width =3,

                      materialSwitch(
                        inputId = 'ID',
                        label = translate_var_col[['ID']], 
                        status = 'warning',
                        right = TRUE
                      ),
                      materialSwitch(
                        inputId = 'CODPOS',
                        label = translate_var_col[['CODPOS']], 
                        status = 'warning',
                        right = TRUE
                      ),
                      materialSwitch(
                        inputId = 'libcom',
                        label = translate_var_col[['libcom']], 
                        status = 'warning',
                        right = TRUE
                      ),
                      materialSwitch(
                        inputId = 'depetab',
                        label = translate_var_col[['depetab']], 
                        status = 'warning',
                        right = TRUE
                      ),
                      materialSwitch(
                        inputId = 'regetab',
                        label = translate_var_col[['regetab']], 
                        status = 'warning',
                        right = TRUE
                      ),
                      materialSwitch(
                        inputId = 'filiere',
                        label = translate_var_col[['filiere']], 
                        status = 'warning',
                        right = TRUE
                      ),
                      materialSwitch(
                        inputId = 'famille',
                        label = translate_var_col[['famille']], 
                        status = 'warning',
                        right = TRUE
                      ),
                      materialSwitch(
                        inputId = 'code_repere',
                        label = translate_var_col[['code_repere']], 
                        status = 'warning',
                        right = TRUE
                      ),
                      materialSwitch(
                        inputId = 'GENRE',
                        label = translate_var_col[['GENRE']], 
                        status = 'warning',
                        right = TRUE
                      ),
                      materialSwitch(
                        inputId = 'CONTRAT',
                        label = translate_var_col[['CONTRAT']], 
                        status = 'warning',
                        right = TRUE
                      ),
                    ),
                    column(
                      width =3,
                      materialSwitch(
                        inputId = 'CAT',
                        label = translate_var_col[['CAT']], 
                        status = 'warning',
                        right = TRUE
                      ),
                      materialSwitch(
                        inputId = 'age',
                        label = translate_var_col[['age']],
                        status = 'warning',
                        right = TRUE
                      ),
                      materialSwitch(
                        inputId = 'anc',
                        label = translate_var_col[['anc']], 
                        status = 'warning',
                        right = TRUE
                      ),
                      materialSwitch(
                        inputId = 'tps_partiel',
                        label = translate_var_col[['tps_partiel']], 
                        status = 'warning',
                        right = TRUE
                      ),
                      materialSwitch(
                        inputId = 'coef_tr',
                        label = translate_var_col[['coef_tr']], 
                        status = 'warning',
                        right = TRUE
                      ),
                      materialSwitch(
                        inputId = 'etp_tp',
                        label = translate_var_col[['etp_tp']],
                        status = 'warning',
                        right = TRUE
                      ),
                      materialSwitch(
                        inputId = 'MOD_ANC',
                        label = translate_var_col[['MOD_ANC']], 
                        status = 'warning',
                        right = TRUE
                      ),

                      materialSwitch(
                        inputId = 'MOD_CAR',
                        label = translate_var_col[['MOD_CAR']], 
                        status = 'warning',
                        right = TRUE
                      ),

                      materialSwitch(
                        inputId = 'q_salmens',
                        label = translate_var_col[['q_salmens']], 
                        status = 'warning',
                        right = TRUE,
                        value = F
                      ),
                      materialSwitch(
                        inputId = 'coef',
                        label = translate_var_col[['coef']],
                        status = 'warning',
                        right = TRUE
                      )
                    ),
                    column(
                      width =3,
                      materialSwitch(
                        inputId = 'q_primeanc',
                        label = translate_var_col[['q_primeanc']], 
                        status = 'warning',
                        right = TRUE,
                        value = F
                        
                      ),
                      materialSwitch(
                        inputId = 'q_primecar',
                        label = translate_var_col[['q_primecar']], 
                        status = 'warning',
                        right = TRUE,
                        value = F
                        
                      ),
                      materialSwitch(
                        inputId = 'q_prime13',
                        label = translate_var_col[['q_prime13']], 
                        status = 'warning',
                        right = TRUE,
                        value = F
                        
                      ),
                      materialSwitch(
                        inputId = 'q_prime14',
                        label = translate_var_col[['q_prime14']],
                        status = 'warning',
                        right = TRUE,
                        value = F
                        
                      ),
                      materialSwitch(
                        inputId = 'q_primeobj',
                        label = translate_var_col[['q_primeobj']], 
                        status = 'warning',
                        right = TRUE,
                        value = F
                        
                      ),
                      materialSwitch(
                        inputId = 'q_primepol',
                        label = translate_var_col[['q_primepol']], 
                        status = 'warning',
                        right = TRUE,
                        value = F
                        
                      ),
                      materialSwitch(
                        inputId = 'q_primeorg',
                        label = translate_var_col[['q_primeorg']], 
                        status = 'warning',
                        right = TRUE,
                        value = F
                        
                      ),
                      materialSwitch(
                        inputId = 'q_primevac',
                        label = translate_var_col[['q_primevac']], 
                        status = 'warning',
                        right = TRUE,
                        value = F
                        
                      ),
                      materialSwitch(
                        inputId = 'cout_reval',
                        label = translate_var_col[['cout_reval']], 
                        status = 'warning',
                        right = TRUE,
                        value =F
                      ),
                      materialSwitch(
                        inputId = 'q_remannu',
                        label = translate_var_col[['q_remannu']], 
                        status = 'warning',
                        right = TRUE
                      )

                    )
                  )
              )
          ),
        br(),
        htmlOutput("texttab"),
        dataTableOutput("table"), 
        downloadButton(
          outputId = "downloadindiv",
          label = "Télécharger le tableau",
          class = "btn-default",
          style = "width:100%;",
          icon = icon("table")
        ),
        ))

        
        
        

      )
    )
  ),

)            
  


import 'package:travel_inspiration/Models/FlightType.dart';
import 'package:travel_inspiration/Models/TravelClass.dart';

class MyStrings {

  static const int insp_key = 1;
  static const int reflect_key = 2;

  static const String fromHaudos = "Haudos";
  static const String fromFavCity = "favCity";

  /*===== font family  */
  static const String cagliostro = "Cagliostro";
  static const String bodoni72 = "Bodoni 72";
  static const String bodoni72_Bold = "Bodoni_Bold";
  static const String courier_prime = "Courier Prime";
  static const String courier_prime_italic = "Courier_Prime_Italic";
  static const String courier_prime_bold = "Courier_Prime_Bold";
  static const String courier_prime_bold_italic = "Courier_Prime_Bold_Italic";

  /*=============== validation msg ==================*/
  static const emailreq= "L'adresse e-mail est requise !";
  static const emailvalid= "Veuillez entrer une adresse e-mail valide";
  static const passwordreqOld=" Les anciens mots de passe sont requis";
  static const passwordreqNew="Un nouveau mot de passe est requis !";
  static const passwordreq="Les mots de passe sont requis !";
  static const passwordreqvalid= "Le mot de passe doit avoir plus de 6 caractères";
  static const cgvvalid= "Veuillez vérifier les règles dans les conditions générales de ventes";
  static const validName="Veuillez saisir un nom valide";
  static const dateofBirthreq= "La date de naissance est requise";
  static const dateofVacationStart= "La date de vacances est requise !";
  static const arrivalDate= "la date d'arrivée est requise !";
  static const dateofVacationEnd= "La date de destination est requise ! ";
  static const validAddress="Veuillez saisir une adresse valide";
  static const validCodePostal="Veuillez saisir un code postal valide";
  static const validCity="Veuillez saisir une ville valide :";
  static const validPhoneNo="Veuillez saisir un numéro de téléphone valide";
  static const validAvtar=" Veuillez choisir votre photo de profi";
  static const validProjName="Veuillez saisir le nom du projet";
  static const validPersonCount="Veuillez ajouter une personne";







  /*===========  home screen ==============*/
  static const String application_pour_des =
      "L’application pour des voyages inspirés & réfléchis";
  static const String laisse_tes_pas =
      "Laisse tes pas te guider vers ta destination idéale !";
  static const String je_suis_haudosseen = "Je suis Haudosséen.ne";
  static const String devenir_haudosseen = "Devenir Haudosséen.ne";
  static const String devenir_haudosseen_multiLine = "Devenir\n Haudosséen.ne";

  /*===========login screen===============*/
  static const String email = "EMAIL";
  static const String mot_de_passe = "MOT DE PASSE";
  static const String mot_de_passe_oublie = "Mot de passe oublié";
  static const String se_connecter = "Se connecter";

/*===========forgot password screen===============*/

  static const String envoyer_email = "Envoyer l’email"; // send email
  static const String return_homepage = "Retourner à la page\nde connexion";
  static const String sent_mail_msg = "Un email a été envoyé à l’adresse email indiqué pour réinitialiser ton mot de passe. Retourne sur ta page de connexion lorsque ton mot de passe est modifié.";
  static const String spam_verify = "N’oublie pas de vérifier tes spams !";

  /*===========Sign up screen===============*/
  static const String accept_cgv = "accepter les "; // accept the CGV
  static const String cgv = "CGV"; // accept the CGV
  static const String signin_with_google = "Se connecter\navec Google";
  static const String password_rules =
      "Le mot de passe doit avoir au minimum 8 caractères :\n- minuscules\n- 1 chiffre minimum\n- 1 caractère spécial\nminimum (@#!% « ;,?/:=+-_’&)";
  static const String cvg_rules =
      "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? »";


  /*===== signup confirm screen=======*/
  static const String genial_tu_es = "Génial tu es parmi.e nous !";
  static const String actives_ton_compte =
      "Actives ton compte depuis l’email reçu.";
  static const String commerce_aventure = "Commencer l’aventure";

  /*======== create profile ======================*/
  static const String create_profile = "CRÉÉ.E\n TON PROFIL";
  static const String add_nickname = "Ajouter un pseudo";
  static const String create_later = "CRÉER PLUS TARD";
  static const String choose_option = "Choisissez l'option";
  static const String choose_date = "Choisissez une date";
  static const String camera = "Caméra";
  static const String gallery = "Galerie";
  static const String address = "Adresse";
  static const String postal_code = "Code postal";
  static const String city = "Ville";
  static const String phone_number = "Numéro de téléphone";
  static const String telephone_info =
      "Ton numéro de téléphone te servira seulement pour partager tes projet de vacances avec tes amis sur Haudos.";
  static const String uk = "Royaume - Uni";
  static const String country = "Pays";
  static const String date = "Date";
  static const String month = "Mois";
  static const String year = "Année";
  static const String date_of_birth = "Date de naissance";
  static const String select_date = "Sélectionne une date";
  static const String select_month = "Sélectionne un mois";
  static const String select_year = "Sélectionne une année";
  static const List<String> monthList = [
    "Janvier",
    "Février",
    "Mars",
    "Avril",
    "Mai",
    "Juin",
    "Juillet",
    "Aout",
    "Septembre",
    "Octobre",
    "Novembre",
    "Décembre"
  ];
  static const List<String> yearList = [
    "2040",
    "2039",
    "2038",
    "2037",
    "2036",
    "2035",
    "2034",
    "2033",
    "2032",
    "2031",
    "2030",
    "2029",
    "2028",
    "2027",
    "2026",
    "2025",
    "2024",
    "2023",
    "2022",
    "2021"
  ];
  static const List<String> countryList = [
    "Allemagne",
    "Belgique",
    "Croatie",
    "Espagne",
    "Royaume-Uni"
  ];

  static  List<FlightType> flightType = [
    FlightType(type: "Domestic",value: "1"),
    FlightType(type: "International",value: "2"),
  ];

  static  List<TravelClass> classType = [
    TravelClass(className: "Economy", classCode: "E"),
    TravelClass(className: "Premium Economy", classCode: "PE"),
    TravelClass(className: "Business",classCode:  "B"),
    TravelClass(className: "First Class", classCode: "F"),
  ];

/*===================SettingScreen===========================*/
  static const String settings = "PARAMÈTRES";
  static const String my_account = "MON COMPTE";
  static const String change_my_password = "Modifier mon mot de passe";
  static const String mode_of_transport_used = "Mode de transport utilisé";
  static const String language = "Langue";
  static const String become_premium = "Devenir premium";
  static const String notification = "Notifications";
  static const String privacy_policy = "Politique de confidentialité";
  static const String other_information = "AUTRES INFORMATIONS";
  static const String auters_info = "AUTRES\nINFORMATIONS";
  static const String terms_conditions = "Termes \& conditions";
  static const String faq = "FAQ";
  static const String sign_out = "Se déconnecter";
  static const String delete_my_account = "Supprimer mon compte";

  //=======faq screen=========//
  static String txtTu="Tu as une question ? \nTu trouveras ta réponse ici.";
  static String txtSelectionneuntheme="Sélectionne un thème";



  /*===========change password screen=============================*/
static const String current_password = "Mot de passe actuel";
static const String new_password = "Nouveau mot de passe";
static const String new_password_validated = "Nouveau mot de passe validé";
static const String confirmation_msg = "Une confirmation a été envoyée sur ton adresse email.";
static const String back_to_settings = "Revenir aux paramètres";
static const String back_to_menu = "Revenir au menu";

//==========start new adventure screen=========
static String Repartiede="REPARTIR DE O KILOMETRES";
static String Comulermes="COMULER MES KILOMETRES";
static String txtComencer="COMMENCER UNE NOUVELLE AVENTURE";
static String txtLeplus="Le plus beau voyage c' est celui qu' on a pas encore fait.";
static String txtLoick="Loïck Peyron Navigateur français";
static String txtRademaree="Redémarre ton chemin de 0 kilomètres.";
static String txtReprendre="Reprendre ton chemin depuis tes kilomètres actuels.";

//==========inspire mode screen=========
static String txtInspireModeCommencerle="COMMENCER L'AVENTURE";

//==========chose route mode screen=========
static String txtInspireMode="MODE INSPIRÉ";
static String txtModeReflechi="MODE RÉFLÉCHI";
  static String txtModeReflechi2="MODE REFLECHI";

static String txtChoisie="CHOISI.E TON MODE DE PARCOURS";
static String txtTune="Tu ne peux pas voyager sur un chemin sans etre toi meme le chemin.";
static String txtBouddha="Bouddha";
static String txtLeModeReflechi="Le mode réfléchi est destiné aux utilisateurs qui ont un projet de vacances planifié. Tu sais déjà quand tu souhaites voyager.";
static String txtLeModeInspire="Le mode inspiré est destiné aux utilisateurs qui ont un projet de voyage mais qui n’ont pas encore programmé de date.";



//========create your project in inspire mode screen======
static String txtASTU="AS-TU DÉJÀ UN NOM POUR TON PROJET ?";
static String txtLeVoyage="Le voyage est une espèce de porte par où l’on sort de la réalité comme pour pénétrer dans une réalité inexplorée qui semble un rêve ";
static String txtGuyde="Guy de Maupassant Écrivain français";
static String txtSitun="Si tu n’as pas de nom de projet, celui-ci sera intitulé \« inspiré \» dans ton carnet de voyages.";
static String txtOUI="OUI";
static String txtNON="NON";

//=======premium info screen======
static String txtHaudospremium="HAUDOS PREMIUM";
static String txtAbonmentMonth="ABONNEMENT MENSUEL";
static String txtProchain="Prochain prélèvement le 12 mars 2021";
static String txtAnnulable="Annulable à tout moment sans frais.";
static String txtExclusive="*Exclusivités";
static String txtFonctiona="*Fonctionnalités à vie*";
static String txtVoirles="Voir les";




//========gia list screen========
static String txtGaia="GAIA";
static String txtVoyagede="VOYAGER DE FAÇON ÉCOLO";

static String txtPourplus="Pour plus d'information et voir les consigns pour publier un article, tu peux aller voir la ";
static String txtFAQ="FAQ";
static String txtou=" ou demander a Istya par email ou sur notre compte ";
static String txtFacebook="Facebook ";
static String txten="en postant sur sa ";
static String txtrubri="rubrique du mardi.";
static String txtEnvoie="Envoie ton article a Gaia pour revision";
  static String dummyText="Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a ge urieto electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software"
      " like Aldus PageMaker including versions of LoremLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a ge urieto electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software"
      " like Aldus PageMaker including versions of Lorem ILorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a ge urieto electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software"
      " like Aldus PageMaker including versions of Lorem ILorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a ge urieto electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software"
      " like Aldus PageMaker including versions of Lorem ILorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a ge urieto electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software"
      " like Aldus PageMaker including versions of Lorem ILorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a ge urieto electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software"
      " like Aldus PageMaker including versions of Lorem I Ipsum";

//==============my account mode of transport==============//
static String txtmodede="Mode de transport utilisé";
static String txtchoisdetes="Choisi.e tes modes de transports du quotidien";
static String txtmyCompte="MON COMPTE";
static String txtLangue="Langue";
static String txtlangFranlang="Francais";
static String txtLangAnglais="Anglais";
static String txtLangIspagnol="Ispagnol";
static String txtLangItalien="Italien";

//======my account notification=======//
 static String txtNotifications="Notifications";
 static String txtDestination="Destinations de la semaine";
 static String txtNotificationpush="Notification push des 5 destinations en fonction de tes kilomètres";
 static String txtKilometres="Kilomètres à mi-parcours";
 static String txtNotificationdu="Notifications du nombre de "
     "kilomètres parcourus à mi-parcours de la semaine";
 static String txtVacanceen="Vacances en approche";
 static String txtRecevoir="Recevoir une notification 5 jours avant "
     "la date de ton départ pour vérifier que tout est prêt";
 static String txtDatelimite="Date limite des destinations";
 static String txtDatelimiteInfo="Recevoir une notification lorsque la date limite de ton projet arrive à expiration";

  static String txtRecevoir2="Recevoir une notification lorsque "
      "la date de ton projet arrive à expiration";
  static String txtNotificationdu2="Notifications du nombre de "
      "kilomètres parcourus à mi-parcours de ma date limite";
 //===========faq screen===========//
 static String txtFAQASKISTYA="FAQ - ASK ISTYA";

 static String txtCOMPTEPREMIUM="COMPTE PREMIUM";
 static String txtGENERAL="GÉNÉRAL";
  static String txtMONCARNET="MON CARNET DE VOYAGE";
  static String txtMESDOCUMENTS="MES DOCUMENTS";
  static String txtMONBUDGET="MON BUDGET";
  static String txtMAVALISE="MA VALISE";
  static String txtCARTEINTERACTIVE="CARTE INTERACTIVE";
  static String txtGAIAMOI="GAIA & MOI";
  static String txtMONHAUDOS="MON HAUDOS";

  //============travelouge screen========
  static String txtCARNETDEVOYAGE="CARNET DE VOYAGE";
  static String txtMesdestinations="Mes destinations haudos";
  static String txtMesvilles="Mes villes favorites";
  static String txtMesprojets="Mes projets de vacances";
  static String txtPinDestination="ÉPINGLER UNE DESTINATION";
  static String txtfav="Enregistré en favori";


  //my destination popup screen========
  static String txtHOTELS="HÔTELS";
  static String txtRESTAURANTS="RESTAURANTS";
  static String txtACTIVITES="ACTIVITÉS";
  static String txtVOLS="VOLS";
  static String txtTRAINS="TRAINS";
  static String txtROUTE="ROUTE";

  //pin destination to project screen=====
  static String txtEPINGLERUNE="ÉPINGLER UNE DESTINATION";
  static String txtADVENTURE2023="ADVENTURE2023";
  static String txtGPOWERHOLIDAYS="GPOWERHOLIDAYS";
  static String txtBAEME="BAE&ME";
  static String txtSUNSET21CANNES="SUNSET21 - CANNES";

//=========hotel list screen===========
  static String txtMONTPELLIER="MONTPELLIER";
  static String txtRechercherunhotel="Rechercher un hôtel";
  static String txtHOTELSEPINGLES="HÔTELS ÉPINGLÉS";
  static String txtRechercherunrestaurant="Rechercher un restaurant";
  static String txtRechercherunactivity="Rechercher un activité";
  static String txtRESTAURANTSEPINGLES="RESTAURANTS ÉPINGLÉS";
  static String txtACTIVITYSEPINGLES="ACTIVITÉ ÉPINGLÉS";
  static String txtRechercherunvol="Rechercher un vol";
  static String txtMESVOLS="MES VOLS";
  static String txtALLER="ALLER";
  static String txtRETOUR="RETOUR";
  static String txtDepuis="Depuis:";
  static String txtOu="Où?";
  static String txtQuand="Quand?";
  static String txtPassagers="Passagers";
  static String txtRechercher="Rechercher";
  static String txtJevoyagedepuis="Je voyage depuis";
  static String txtJevoyageVers="Je voyage vers";
  static String pinned="Épinglé!";

  static String txtValider="Valider";
  static String txtChoixdesdates="Choix des dates";
  /*===========change dob screen=============================*/
static const String dob_update_msg = "Tes informations ont bien été enregistrées !";

/*==================== create project - reflect mode ====================*/
static const String name_of_project = "NOM DU PROJET";
static const String my_vacation_date = "Ma date de vacances";
static const String deadline_deatination_date = "Date limite pour recevoir mes destinations";
static const String number_of_person = "Nombre de personnes";
static const String show_mode_msg = "Retrouve tes projets de vacances dans ton carnet de voyage et modifies ton mode de transport dans les paramètres.";



/*========= inspired mode screen=============================*/
static const String profile = "PROFIL";
static const String gaia = "GAIA";
static const String inspire_mode = "MODE INSPIRÉ";
static const String journey_always_start = "Un voyage de 1000 kilomètres commence toujours par un pas";
static const String lao_tseu = "Lao Tseu";
static const String see_my_journey = "VOIR MON PARCOURS";
static const String my_trvel_book = "MON CARNET DE VOYAGE";
static const String project_name_info = "Retrouves tes projets de vacances dans ton carnet de voyage.";

/*=============reflect mode ====================*/
static const String reflect_mode = "MODE REFLÉCHI";
static const String current_destination = "Destinations en cours";

/*============== My Profile =========================*/
static const String premium_account = "COMPTE PREMIUM";
static const String projects = "PROJETS";
static const String total_km = "PARCOURUS AU TOTAL";
static const String inspire = "Inspiré";
static const String reflect = "Réfléchi";

/*================ Gallery =============================*/
static const String premium = "PREMIUM";
static const String my_documents = "MES DOCUMENTS";
static const String my_budget = "MON BUDGET";
static const String my_suitcase = "MA VALISE";
static const String intractive_map = "CARTE INTERACTIVE";
static const String my_haudos = "MON HAUDOS";
static const String future = "À VENIR";
static const String to_buy = "ACHETER";
static const String see_sales_condition = "Voir les conditions de ventes";
static const String premium_desc = "L’arrêt d’un compte premium annule tous tes avantages et fonctionnalités.";
static const String premium_info = "Le compte Premium te donnes accès à toutes les fonctionnalités, à des avantages exclusifs et des avants-premières Haudos.";
static const String premium_annual = "Premium annuel";
static const String premium_monthly = "Premium mensuel";
static const String document_info = "Epingles,copies,photographies tes documents électroniques pour ne jamais les perdre de vue.";
static const String document_desc = "L’achat des fonctionnalités individuelles sont à vie";
static const String budget_info = "Contrôle et détermine ton budget de vacances en fonction de ton projet et de tes envies.";
static const String carte_info = "Interagis et croise le chemin d’autres haudosséen.nes qui dispose de la fonctionnalité et partage tes projets.";
static const String mon_haudos_info = "Créé.e ton circuit de vacances et accèdes à toutes les informations pour être bien préparé.e pour tout planifier.";
static const String valise_info = "Fais ton inventaire de tes affaires avant ton départ pour être sûr de ne rien oublier.";
static const String full_version = "Version complète";
static const String purchase_only = "Achat seul*";
static const String each_item_added = "Chaque article ajouté";


/*===================  become premium ==============================*/
static const String premium_account_allows_you = "Le compte premium te permet :";
static const String premium_account_allows_msg = "L’accès à toutes les fonctionnalités de\nl’application même après les mis à jours*\nAvantages exclusifs\nAccès en avant-première des\nfonctionnalités Haudos\nAvantages aux jeux concours";
static const String condition_msg = "*L’annulation du compte premium supprime tes avantages et les fonctionnalités payantes.";
static const String see_terms_conditins_of_sale = "Voir termes et conditions générales de vente.";

/*=============== delete account ====================================*/
static const String delete_ac_msg  = "La suppression de ton compte Haudos est irrévocable. Tu perdras toutes tes fonctionnalités acquises et avantages de ton compte premium (si compte premium). Tu n’auras plus accès à tes projets de vacances, ni aux partages fait avec les autres utilisateurs.\n\nSi tu souhaites revenir sur l’application, tu devras te recréer un compte et acheter les fonctionnalités individuellement ou souscrire à nouveau à un compte premium. Comme alternative tu peux te déconnecter et revenir quand cela t’enchantes.";
static const String delete_warn_msg  = "Tu peux toujours faire marche arrière et continuer ton chemin avec nous.";
static const String changed_my_mind  = "J’ai changé d’avis";
static const String account_deletion  = "Suppression du compte";
static const String account_deletion_msg  = "Nous espérons te revoir parmi.e nous ! Continue ton aventure Haudos via nos réseaux sociaux";
static const String haudosapp  = "@Haudosapp";

/*============== create a project ==============================*/
static const String create_new_project = "CRÉER UN NOUVEAU PROJET";
static const String vacation_date = "Date de vacances";

/*==================== delete a destination ====================*/
static const String delete_destination = "SUPPRIMER UNE DESTINATION";
static const String delete_destination_msg = "Es-tu sûr.e de vouloir supprimer cette destination de ton carnet de voyage ?\n Tu ne pourras plus la revoir même si tu repars de zéro kilomètres.";
static const String remove = "Supprimer \?";

/*===================== hotel details =========================*/
static const String description = "Description";
static const String commodites = "Commodités";
static const String room_types = "Types de chambres";
static const String hours = "Horaires";
static const String picture_gallery = "Galerie photos";
static const String review = "Avis";
static const String read_all_reviews = "Voir tous les avis";
static const String to_book = "Réserver";

/*============== reviews==============*/
  static const String the_legal = "LE REGAL";

/*================== routeScreen=================================*/
static const String find_road_route = "Rechercher un itinéraire de route";
static const String my_routes = "MES ROUTES";

//===========destination in progress screen=======
static String txtArretermonparcours="Arrêter mon parcours";
static String stop_journey="Carnet de voyage";
static String choose_destination_complete_vacation_plan="Choisi.e une destination pour compléter ton projet de vacances.";

//==============passanger screen=============
static String txtAdults="Adultes";
static String txtAdultSubTitle="Au dessous de 12 ans";
static String txtChildren="Enfants";
static String txtChildrenSubTitle="2 à 12 ans";
static String txtBabe="Bébé";
static String txtBabeSubTitle="En dessous de 2 ans";
static String txtFlightPopupData="Pour éviter d’écrire manuellement ton vol, achètes la fonctionnalité « mes documents » dans la galerie.";
static String txtDeviensPremium="Deviens Premium";
static String txtRechercheruntrain="Rechercher un train";
static String txtMesTrains="MES TRAINS";


//===============flight summary screen========
static String txtTotal="TOTAL";
static String txtReserversurle="Réserver sur le site partenaire";
/*=========== train screen ===============*/
static const String find_train = "Rechercher un train";
static const String my_trains = "MES TRAINS";


static String txtNoInternetConnection="Pas de connexion Internet";
static String txtNoRecordFound="No record found!";

/*================== vacation project file ==================*/
static const String project_release_in_reflect = "Projet réalisé en mode réfléchi";
static const String project_release_in_inspire = "Projet réalisé en mode inspiré";
static const String travel = "Je voyage :";


static const String Departure = "Départ";
static const String Arrival = "Arrivée";
static const String Arrival_date = "Date d’arrivée";
static const String Date = "Date";
static const String Month = "Mois";
static const String Year = "Année";
static const String Date_of_departure = "Date de départ";
static const String Airline_company = "Compagnie aérienne";
static const String TICKET = "TICKET";
static const String Please_enter_depart = "Please enter depart";
static const String Please_enter_arrival = "Please enter arrival";
static const String Please_enter_ticket = "Please enter ticket";
static const String Please_select_arrival_departure_date = "Please select arrival & departure date";
static const String Please_select_airline = "Please select airline";
static const String Please_select_train = "Please select train";


}

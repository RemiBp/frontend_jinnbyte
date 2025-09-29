// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get helloWorld => 'Bonjour le monde!';

  @override
  String get createAnAccount => 'Créer un compte';

  @override
  String get chooseAccountType =>
      'Choisissez le type de compte que vous souhaitez créer :';

  @override
  String get userAccountTitle => 'Compte utilisateur';

  @override
  String get userAccountDescription =>
      'Pour découvrir des restaurants et des activités, et suivre vos prestataires favoris.';

  @override
  String get restaurantProviderAccountTitle => 'Compte restaurateur';

  @override
  String get restaurantProviderAccountDescription =>
      'Pour gérer votre restaurant et promouvoir vos offres.';

  @override
  String get leisureProviderAccountTitle => 'Compte prestataire de loisirs';

  @override
  String get leisureProviderAccountDescription =>
      'Pour gérer vos activités de loisirs et attirer de nouveaux clients.';

  @override
  String get wellnessProviderAccountTitle => 'Compte prestataire de bien-être';

  @override
  String get wellnessProviderAccountDescription =>
      'Pour gérer vos activités de bien-être et attirer de nouveaux clients.';

  @override
  String get signupTitle => 'Inscription';

  @override
  String get signupSubtitle =>
      'Entrez votre email et mot de passe pour vous inscrire';

  @override
  String get businessName => 'Nom de l\'entreprise';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailPlaceholder => 'Adresse e-mail';

  @override
  String get passwordLabel => 'Mot de passe';

  @override
  String get signupAgreement => 'En vous inscrivant, vous acceptez nos';

  @override
  String get termsOfService => 'Conditions d\'utilisation';

  @override
  String get andLabel => 'et';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get signupWithApple => 'Apple';

  @override
  String get signupWithGoogle => 'Google';

  @override
  String get alreadyHaveAccount => 'Vous avez déjà un compte ? ';

  @override
  String get loginButton => 'Connexion';

  @override
  String get otpVerification => 'Vérification OTP';

  @override
  String verificationPrompt(Object email) {
    return 'Entrez le code de vérification à 6 chiffres envoyé à dummy@example.com';
  }

  @override
  String get didNotReceiveCode => 'Vous n\'avez pas reçu le code ?';

  @override
  String get resendCode => 'Renvoyer';

  @override
  String get verifyButton => 'Vérifier';

  @override
  String get uploadDocumentsTitle => 'Télécharger les documents';

  @override
  String get uploadDocumentsSubtitle =>
      'Veuillez télécharger vos documents pour continuer la vérification.';

  @override
  String get businessRegistrationDocument =>
      'Document d\'enregistrement de l\'entreprise';

  @override
  String get expiryDate => 'Date d\'expiration';

  @override
  String get selectDate => 'Sélectionner une date';

  @override
  String get chooseFile => 'Choisir un fichier';

  @override
  String get maxFileSizeNote => 'Taille maximale du fichier (PDF) : 2 Mo';

  @override
  String get utilityBillOrInvoice => 'Facture de services publics ou facture';

  @override
  String get submitForReview => 'Soumettre pour révision';

  @override
  String get loginInstruction =>
      'Entrez votre email et mot de passe pour vous connecter';

  @override
  String get rememberMe => 'Se souvenir de moi';

  @override
  String get forgotPassword => 'Mot de passe oublié';

  @override
  String get noAccountPrompt => 'Vous n’avez pas de compte ?';

  @override
  String get forgotPasswordInstruction =>
      'Veuillez entrer votre email pour recevoir un code de vérification.';

  @override
  String get sendOtpButton => 'Envoyer le code';

  @override
  String get resetPasswordTitle => 'Réinitialiser le mot de passe';

  @override
  String get resetPasswordNote =>
      'Votre nouveau mot de passe doit être différent des mots de passe précédemment utilisés.';

  @override
  String get newPasswordLabel => 'Nouveau mot de passe';

  @override
  String get confirmPasswordLabel => 'Confirmez le mot de passe';

  @override
  String get profileSetup => 'Configuration du profil';

  @override
  String get address => 'Adresse';

  @override
  String get briefDescription => 'Brève description';

  @override
  String get writeSomethingBrief => 'Écrivez quelque chose de bref...';

  @override
  String get gallery => 'galerie';

  @override
  String get camera => 'caméra';

  @override
  String get chooseYourPhoto => 'Choisissez votre photo';

  @override
  String get links => 'Liens';

  @override
  String get next => 'Suivant';

  @override
  String get selectLanguage => 'Sélectionner la langue';

  @override
  String get choosePreferredLanguage =>
      'Choisissez votre langue préférée pour continuer';

  @override
  String get continueText => 'Continuer';

  @override
  String get phoneNumber => 'Numéro de téléphone';

  @override
  String get setting => 'Setting';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get changePassword => 'Change Password';

  @override
  String get documents => 'Documents';

  @override
  String get businessHours => 'Business Hours';

  @override
  String get manageSlots => 'Manage Slots';

  @override
  String get menu => 'Menu';

  @override
  String get unavailability => 'Unavailability';

  @override
  String get language => 'Language';

  @override
  String get logout => 'Logout';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get cuisine => 'Cuisine';

  @override
  String get services => 'Services';

  @override
  String get update => 'Update';

  @override
  String get reclaimAccount => 'Récupérez votre compte';

  @override
  String get retrieveAccess => 'Récupérez l\'accès à votre profil existant';

  @override
  String get chooseOption => 'Choisissez votre option';

  @override
  String get categoryRestaurant => 'Restaurant';

  @override
  String get categoryLeisure => 'Loisir';

  @override
  String get categoryWellness => 'Bien-être';

  @override
  String get searchPlaceholder => 'Rechercher par nom...';

  @override
  String get claimAccount => 'Réclamer le compte';

  @override
  String get orText => 'Ou';

  @override
  String get uploadDocuments => 'Télécharger des documents';

  @override
  String get uploadDocumentsDescription =>
      'Veuillez télécharger votre document pour continuer la vérification.';

  @override
  String get backButton => 'Retour';

  @override
  String get thankYou => 'Merci !';

  @override
  String get underReviewMessage =>
      'Votre profil est maintenant en cours d\'examen. Nous vous répondrons dans deux jours ouvrables.';

  @override
  String get documentBusinessRegistration =>
      'Documents d\'enregistrement de l\'entreprise';

  @override
  String get documentLeaseContract => 'Contrat de bail commercial';

  @override
  String get documentUtilityBill => 'Facture de services publics';

  @override
  String get documentSupplierInvoice => 'Facture fournisseur';

  @override
  String get documentInsuranceCertificate =>
      'Attestation d\'assurance professionnelle';

  @override
  String get documentTax => 'Document fiscal';

  @override
  String get documentAuthorizationLetter => 'Lettre d\'autorisation signée';

  @override
  String get create => 'Créer';

  @override
  String get createPost => 'Créer une publication';

  @override
  String get photos => 'Photos';

  @override
  String get fileSupported => 'Fichier pris en charge :';

  @override
  String get imageLimit => 'Jusqu\'à 5 images';

  @override
  String get exampleTitle => 'ex. Brunch du dimanche à The Maple House';

  @override
  String get title => 'Titre';

  @override
  String get eventDescriptionPlaceholder => 'Décrivez votre événement...';

  @override
  String get exampleTags => 'ex. : #chaleureux, #terrasse';

  @override
  String get tags => 'Tags';

  @override
  String get addLocation => 'Ajouter un lieu';

  @override
  String get location => 'Lieu';

  @override
  String get cancel => 'Annuler';

  @override
  String get publish => 'Publier';

  @override
  String get errorSelectImage => 'Veuillez sélectionner au moins une image';

  @override
  String get errorEnterTitle => 'Veuillez entrer un titre';

  @override
  String get errorEnterDescription => 'Veuillez entrer une description';

  @override
  String get errorEnterTags => 'Veuillez entrer des tags pertinents';

  @override
  String get errorEnterAddress => 'Veuillez entrer une adresse';

  @override
  String get searchUserPlaceholder =>
      'Rechercher par nom d’utilisateur ou par nom...';

  @override
  String get description => 'Description';

  @override
  String get deleteEventConfirmation => 'Supprimer l’événement ?';

  @override
  String get deleteEventMessage =>
      'Cette action supprimera définitivement l’événement.';

  @override
  String get events => 'Événements';

  @override
  String get sampleEventName => 'Soirée Vin & Dîner';

  @override
  String get statusActive => 'Actif';

  @override
  String get statusDraft => 'Brouillon';

  @override
  String get statusCompleted => 'Terminé';

  @override
  String get createEvent => 'Créer un événement';

  @override
  String get noEvents => 'Aucun événement pour l’instant';

  @override
  String get noEventsMessage =>
      'Vous n’avez encore créé aucun événement. Commencez par ajouter votre premier — cela ne prend qu’une minute !';

  @override
  String get eventDetails => 'Détails de l’événement';

  @override
  String get exampleDish => 'Ex. : Brochette de bœuf...';

  @override
  String get eventName => 'Nom de l’événement';

  @override
  String get eventGallery => 'Galerie de l’événement';

  @override
  String get uploadLimit => 'Téléchargez jusqu’à 5 images';

  @override
  String get uploadEventImages => 'Télécharger les images de l’événement*';

  @override
  String get restaurantOrVenue => 'Nom du restaurant ou du lieu';

  @override
  String get venueName => 'Nom du lieu';

  @override
  String get venueAddress => 'Adresse du lieu';

  @override
  String get capacityPricing => 'Capacité & Tarification';

  @override
  String get maxPersons => 'Nombre maximum de personnes';

  @override
  String get maxCapacity => 'Capacité maximale';

  @override
  String get pricePerPerson => 'Prix par personne';

  @override
  String get schedule => 'Programme';

  @override
  String get eventDate => 'Date de l’événement';

  @override
  String get startTime => 'Heure de début';

  @override
  String get endTime => 'Heure de fin';

  @override
  String get saveAsDraft => 'Enregistrer comme brouillon';

  @override
  String get tapToUpload => 'Appuyez pour télécharger une image';

  @override
  String get event => 'Événement';

  @override
  String get participants => 'Participants';

  @override
  String get showAll => 'Tout afficher';

  @override
  String get aboutEvent => 'À propos de l’événement';

  @override
  String get readMore => 'Lire plus';

  @override
  String get seeLess => 'Voir moins';

  @override
  String get socialLinks => 'Liens sociaux';

  @override
  String get delete => 'Supprimer';

  @override
  String get edit => 'Modifier';
}

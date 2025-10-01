import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// The conventional newborn programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Hello World!'**
  String get helloWorld;

  /// No description provided for @createAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Create an Account'**
  String get createAnAccount;

  /// No description provided for @chooseAccountType.
  ///
  /// In en, this message translates to:
  /// **'Choose the type of account you want to create:'**
  String get chooseAccountType;

  /// No description provided for @userAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'User Account'**
  String get userAccountTitle;

  /// No description provided for @userAccountDescription.
  ///
  /// In en, this message translates to:
  /// **'To discover restaurants and activities, and follow your favorite providers.'**
  String get userAccountDescription;

  /// No description provided for @restaurantProviderAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Provider Account'**
  String get restaurantProviderAccountTitle;

  /// No description provided for @restaurantProviderAccountDescription.
  ///
  /// In en, this message translates to:
  /// **'To manage your restaurant and promote your offerings.'**
  String get restaurantProviderAccountDescription;

  /// No description provided for @leisureProviderAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Leisure Provider Account'**
  String get leisureProviderAccountTitle;

  /// No description provided for @leisureProviderAccountDescription.
  ///
  /// In en, this message translates to:
  /// **'To manage your leisure activities and attract new clients.'**
  String get leisureProviderAccountDescription;

  /// No description provided for @wellnessProviderAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Wellness Provider Account'**
  String get wellnessProviderAccountTitle;

  /// No description provided for @wellnessProviderAccountDescription.
  ///
  /// In en, this message translates to:
  /// **'To manage your well-being activity and attract new clients.'**
  String get wellnessProviderAccountDescription;

  /// No description provided for @signupTitle.
  ///
  /// In en, this message translates to:
  /// **'Signup'**
  String get signupTitle;

  /// No description provided for @signupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and password to signup'**
  String get signupSubtitle;

  /// No description provided for @businessName.
  ///
  /// In en, this message translates to:
  /// **'Business Name'**
  String get businessName;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @fullNamePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullNamePlaceholder;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get userName;

  /// No description provided for @userNamePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get userNamePlaceholder;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @emailPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailPlaceholder;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @signupAgreement.
  ///
  /// In en, this message translates to:
  /// **'By signing up, you agree to our'**
  String get signupAgreement;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @andLabel.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get andLabel;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @signupWithApple.
  ///
  /// In en, this message translates to:
  /// **'Apple'**
  String get signupWithApple;

  /// No description provided for @signupWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get signupWithGoogle;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAccount;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @otpVerification.
  ///
  /// In en, this message translates to:
  /// **'OTP Verification'**
  String get otpVerification;

  /// No description provided for @verificationPrompt.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6 -digit verification code sent to {email}}'**
  String verificationPrompt(Object email);

  /// No description provided for @didNotReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Didn’t receive code?'**
  String get didNotReceiveCode;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resendCode;

  /// No description provided for @verifyButton.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verifyButton;

  /// No description provided for @uploadDocumentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Upload Documents'**
  String get uploadDocumentsTitle;

  /// No description provided for @uploadDocumentsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please upload your document to proceed with verification.'**
  String get uploadDocumentsSubtitle;

  /// No description provided for @businessRegistrationDocument.
  ///
  /// In en, this message translates to:
  /// **'Business Registration Document'**
  String get businessRegistrationDocument;

  /// No description provided for @expiryDate.
  ///
  /// In en, this message translates to:
  /// **'Expiry Date'**
  String get expiryDate;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get selectDate;

  /// No description provided for @chooseFile.
  ///
  /// In en, this message translates to:
  /// **'Choose a file'**
  String get chooseFile;

  /// No description provided for @maxFileSizeNote.
  ///
  /// In en, this message translates to:
  /// **'Max file size (PDF): 2MB'**
  String get maxFileSizeNote;

  /// No description provided for @utilityBillOrInvoice.
  ///
  /// In en, this message translates to:
  /// **'Utility Bill or Invoice'**
  String get utilityBillOrInvoice;

  /// No description provided for @submitForReview.
  ///
  /// In en, this message translates to:
  /// **'Submit for Review'**
  String get submitForReview;

  /// No description provided for @loginInstruction.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and password to log in '**
  String get loginInstruction;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// No description provided for @noAccountPrompt.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account?'**
  String get noAccountPrompt;

  /// No description provided for @forgotPasswordInstruction.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email to receive verification code.'**
  String get forgotPasswordInstruction;

  /// No description provided for @sendOtpButton.
  ///
  /// In en, this message translates to:
  /// **'Send OTP'**
  String get sendOtpButton;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPasswordTitle;

  /// No description provided for @resetPasswordNote.
  ///
  /// In en, this message translates to:
  /// **'Your new password must be different from previous used passwords.'**
  String get resetPasswordNote;

  /// No description provided for @newPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPasswordLabel;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordLabel;

  /// No description provided for @profileSetup.
  ///
  /// In en, this message translates to:
  /// **'Profile Setup'**
  String get profileSetup;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @briefDescription.
  ///
  /// In en, this message translates to:
  /// **'Brief Description'**
  String get briefDescription;

  /// No description provided for @writeSomethingBrief.
  ///
  /// In en, this message translates to:
  /// **'Write something brief...'**
  String get writeSomethingBrief;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'gallery'**
  String get gallery;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'camera'**
  String get camera;

  /// No description provided for @chooseYourPhoto.
  ///
  /// In en, this message translates to:
  /// **'Choose your photo'**
  String get chooseYourPhoto;

  /// No description provided for @links.
  ///
  /// In en, this message translates to:
  /// **'Links'**
  String get links;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @choosePreferredLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred language to continue'**
  String get choosePreferredLanguage;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get setting;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @documents.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get documents;

  /// No description provided for @businessHours.
  ///
  /// In en, this message translates to:
  /// **'Business Hours'**
  String get businessHours;

  /// No description provided for @manageSlots.
  ///
  /// In en, this message translates to:
  /// **'Manage Slots'**
  String get manageSlots;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @unavailability.
  ///
  /// In en, this message translates to:
  /// **'Unavailability'**
  String get unavailability;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @cuisine.
  ///
  /// In en, this message translates to:
  /// **'Cuisine'**
  String get cuisine;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @reclaimAccount.
  ///
  /// In en, this message translates to:
  /// **'Reclaim Your Account'**
  String get reclaimAccount;

  /// No description provided for @retrieveAccess.
  ///
  /// In en, this message translates to:
  /// **'Retrieve access to your existing profile'**
  String get retrieveAccess;

  /// No description provided for @chooseOption.
  ///
  /// In en, this message translates to:
  /// **'Choose your option'**
  String get chooseOption;

  /// No description provided for @categoryRestaurant.
  ///
  /// In en, this message translates to:
  /// **'Restaurant'**
  String get categoryRestaurant;

  /// No description provided for @categoryLeisure.
  ///
  /// In en, this message translates to:
  /// **'Leisure'**
  String get categoryLeisure;

  /// No description provided for @categoryWellness.
  ///
  /// In en, this message translates to:
  /// **'Wellness'**
  String get categoryWellness;

  /// No description provided for @searchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search by name...'**
  String get searchPlaceholder;

  /// No description provided for @claimAccount.
  ///
  /// In en, this message translates to:
  /// **'Claim Account'**
  String get claimAccount;

  /// No description provided for @orText.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get orText;

  /// No description provided for @uploadDocuments.
  ///
  /// In en, this message translates to:
  /// **'Upload Documents'**
  String get uploadDocuments;

  /// No description provided for @uploadDocumentsDescription.
  ///
  /// In en, this message translates to:
  /// **'Please upload your document to proceed with verification.'**
  String get uploadDocumentsDescription;

  /// No description provided for @backButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backButton;

  /// No description provided for @thankYou.
  ///
  /// In en, this message translates to:
  /// **'Thank you!'**
  String get thankYou;

  /// No description provided for @underReviewMessage.
  ///
  /// In en, this message translates to:
  /// **'Your profile are now under review. We will get back to you in two business day.'**
  String get underReviewMessage;

  /// No description provided for @documentBusinessRegistration.
  ///
  /// In en, this message translates to:
  /// **'Buisness  Registration Documents'**
  String get documentBusinessRegistration;

  /// No description provided for @documentLeaseContract.
  ///
  /// In en, this message translates to:
  /// **'Commercial Lease Contract'**
  String get documentLeaseContract;

  /// No description provided for @documentUtilityBill.
  ///
  /// In en, this message translates to:
  /// **'Utility Bill'**
  String get documentUtilityBill;

  /// No description provided for @documentSupplierInvoice.
  ///
  /// In en, this message translates to:
  /// **'Supplier Invoice'**
  String get documentSupplierInvoice;

  /// No description provided for @documentInsuranceCertificate.
  ///
  /// In en, this message translates to:
  /// **'Professional Insurance Certificate'**
  String get documentInsuranceCertificate;

  /// No description provided for @documentTax.
  ///
  /// In en, this message translates to:
  /// **'Tax Document'**
  String get documentTax;

  /// No description provided for @documentAuthorizationLetter.
  ///
  /// In en, this message translates to:
  /// **'Signed Authorization Letter'**
  String get documentAuthorizationLetter;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @createPost.
  ///
  /// In en, this message translates to:
  /// **'Create Post'**
  String get createPost;

  /// No description provided for @photos.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get photos;

  /// No description provided for @fileSupport.
  ///
  /// In en, this message translates to:
  /// **'File supported:'**
  String get fileSupport;

  /// No description provided for @imageLimit.
  ///
  /// In en, this message translates to:
  /// **'Up to 5 images'**
  String get imageLimit;

  /// No description provided for @exampleTitle.
  ///
  /// In en, this message translates to:
  /// **'e.g Sunday Brunch at The Maple House'**
  String get exampleTitle;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @eventDescriptionPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Describe your event...'**
  String get eventDescriptionPlaceholder;

  /// No description provided for @exampleTags.
  ///
  /// In en, this message translates to:
  /// **'e.g: #cozy, #outdoor_seating'**
  String get exampleTags;

  /// No description provided for @tags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tags;

  /// No description provided for @addLocation.
  ///
  /// In en, this message translates to:
  /// **'Add location'**
  String get addLocation;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @publish.
  ///
  /// In en, this message translates to:
  /// **'Publish'**
  String get publish;

  /// No description provided for @errorSelectImage.
  ///
  /// In en, this message translates to:
  /// **'Please Select at least one image'**
  String get errorSelectImage;

  /// No description provided for @errorEnterTitle.
  ///
  /// In en, this message translates to:
  /// **'Please Enter title'**
  String get errorEnterTitle;

  /// No description provided for @errorEnterDescription.
  ///
  /// In en, this message translates to:
  /// **'Please Enter description'**
  String get errorEnterDescription;

  /// No description provided for @errorEnterTags.
  ///
  /// In en, this message translates to:
  /// **'Please Enter relative tags'**
  String get errorEnterTags;

  /// No description provided for @errorEnterAddress.
  ///
  /// In en, this message translates to:
  /// **'Please Enter address'**
  String get errorEnterAddress;

  /// No description provided for @searchUserPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search by username or name...'**
  String get searchUserPlaceholder;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @deleteEventConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Delete Event?'**
  String get deleteEventConfirmation;

  /// No description provided for @deleteEventMessage.
  ///
  /// In en, this message translates to:
  /// **'This action will permanently remove the event.'**
  String get deleteEventMessage;

  /// No description provided for @events.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get events;

  /// No description provided for @sampleEventName.
  ///
  /// In en, this message translates to:
  /// **'Wine & Dine Evening'**
  String get sampleEventName;

  /// No description provided for @statusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get statusActive;

  /// No description provided for @statusDraft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get statusDraft;

  /// No description provided for @statusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get statusCompleted;

  /// No description provided for @createEvent.
  ///
  /// In en, this message translates to:
  /// **'Create Event'**
  String get createEvent;

  /// No description provided for @noEvents.
  ///
  /// In en, this message translates to:
  /// **'No Events Yet'**
  String get noEvents;

  /// No description provided for @noEventsMessage.
  ///
  /// In en, this message translates to:
  /// **'You haven’t created any events yet. Start by adding your first one — it only takes a minute!'**
  String get noEventsMessage;

  /// No description provided for @eventDetails.
  ///
  /// In en, this message translates to:
  /// **'Event Details'**
  String get eventDetails;

  /// No description provided for @exampleDish.
  ///
  /// In en, this message translates to:
  /// **'E.g: Brochette boeuf...'**
  String get exampleDish;

  /// No description provided for @eventName.
  ///
  /// In en, this message translates to:
  /// **'Event Name'**
  String get eventName;

  /// No description provided for @eventGallery.
  ///
  /// In en, this message translates to:
  /// **'Event Gallery'**
  String get eventGallery;

  /// No description provided for @uploadLimit.
  ///
  /// In en, this message translates to:
  /// **'Upload up to 5 images'**
  String get uploadLimit;

  /// No description provided for @uploadEventImages.
  ///
  /// In en, this message translates to:
  /// **'Upload Event Images*'**
  String get uploadEventImages;

  /// No description provided for @restaurantOrVenue.
  ///
  /// In en, this message translates to:
  /// **'Restaurant name or venue'**
  String get restaurantOrVenue;

  /// No description provided for @venueName.
  ///
  /// In en, this message translates to:
  /// **'Venue Name'**
  String get venueName;

  /// No description provided for @venueAddress.
  ///
  /// In en, this message translates to:
  /// **'Address of venue'**
  String get venueAddress;

  /// No description provided for @capacityPricing.
  ///
  /// In en, this message translates to:
  /// **'Capacity & Pricing'**
  String get capacityPricing;

  /// No description provided for @maxPersons.
  ///
  /// In en, this message translates to:
  /// **'Maximum number of persons'**
  String get maxPersons;

  /// No description provided for @maxCapacity.
  ///
  /// In en, this message translates to:
  /// **'Maximum Capacity'**
  String get maxCapacity;

  /// No description provided for @pricePerPerson.
  ///
  /// In en, this message translates to:
  /// **'Price per person'**
  String get pricePerPerson;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule;

  /// No description provided for @eventDate.
  ///
  /// In en, this message translates to:
  /// **'Event Date'**
  String get eventDate;

  /// No description provided for @startTime.
  ///
  /// In en, this message translates to:
  /// **'Start Time'**
  String get startTime;

  /// No description provided for @endTime.
  ///
  /// In en, this message translates to:
  /// **'End Time'**
  String get endTime;

  /// No description provided for @saveAsDraft.
  ///
  /// In en, this message translates to:
  /// **'Save as Draft'**
  String get saveAsDraft;

  /// No description provided for @tapToUpload.
  ///
  /// In en, this message translates to:
  /// **'Tap to upload image'**
  String get tapToUpload;

  /// No description provided for @event.
  ///
  /// In en, this message translates to:
  /// **'Event'**
  String get event;

  /// No description provided for @participants.
  ///
  /// In en, this message translates to:
  /// **'Participants'**
  String get participants;

  /// No description provided for @showAll.
  ///
  /// In en, this message translates to:
  /// **'Show All'**
  String get showAll;

  /// No description provided for @aboutEvent.
  ///
  /// In en, this message translates to:
  /// **'About Event'**
  String get aboutEvent;

  /// No description provided for @readMore.
  ///
  /// In en, this message translates to:
  /// **'Read More'**
  String get readMore;

  /// No description provided for @seeLess.
  ///
  /// In en, this message translates to:
  /// **'See Less'**
  String get seeLess;

  /// No description provided for @socialLinks.
  ///
  /// In en, this message translates to:
  /// **'Social Links'**
  String get socialLinks;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @yourExperience.
  ///
  /// In en, this message translates to:
  /// **'Your Experience'**
  String get yourExperience;

  /// No description provided for @overallRestaurantRating.
  ///
  /// In en, this message translates to:
  /// **'Overall Restaurant Rating'**
  String get overallRestaurantRating;

  /// No description provided for @service.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get service;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @portions.
  ///
  /// In en, this message translates to:
  /// **'Portions'**
  String get portions;

  /// No description provided for @ambiance.
  ///
  /// In en, this message translates to:
  /// **'Ambiance'**
  String get ambiance;

  /// No description provided for @dishesAndMenusConsumed.
  ///
  /// In en, this message translates to:
  /// **'Dishes and Menus Consumed'**
  String get dishesAndMenusConsumed;

  /// No description provided for @rateTheSelectedDishes.
  ///
  /// In en, this message translates to:
  /// **'Rate The Selected Dishes'**
  String get rateTheSelectedDishes;

  /// No description provided for @yourRatingForThisDish.
  ///
  /// In en, this message translates to:
  /// **'Your rating for this dish:'**
  String get yourRatingForThisDish;

  /// No description provided for @fileSupported.
  ///
  /// In en, this message translates to:
  /// **'File supported: PNG, JPG'**
  String get fileSupported;

  /// No description provided for @chooseAFile.
  ///
  /// In en, this message translates to:
  /// **'Choose a file'**
  String get chooseAFile;

  /// No description provided for @upTo5Images.
  ///
  /// In en, this message translates to:
  /// **'Up to 5 images'**
  String get upTo5Images;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @whichRestaurantDidYouVisit.
  ///
  /// In en, this message translates to:
  /// **'Which restaurant did you visit?'**
  String get whichRestaurantDidYouVisit;

  /// No description provided for @whichWellnessDidYouVisit.
  ///
  /// In en, this message translates to:
  /// **'Which wellness did you visit?'**
  String get whichWellnessDidYouVisit;

  /// No description provided for @whichLeisureEventDidYouAttend.
  ///
  /// In en, this message translates to:
  /// **'Which leisure event did you attend?'**
  String get whichLeisureEventDidYouAttend;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @distance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distance;

  /// No description provided for @place.
  ///
  /// In en, this message translates to:
  /// **'Place'**
  String get place;

  /// No description provided for @dishName.
  ///
  /// In en, this message translates to:
  /// **'Dish Name'**
  String get dishName;

  /// No description provided for @dishRating.
  ///
  /// In en, this message translates to:
  /// **'Dish Rating'**
  String get dishRating;

  /// No description provided for @resetAll.
  ///
  /// In en, this message translates to:
  /// **'Reset All'**
  String get resetAll;

  /// No description provided for @applyFilters.
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get applyFilters;

  /// No description provided for @any.
  ///
  /// In en, this message translates to:
  /// **'Any'**
  String get any;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

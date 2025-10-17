// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get createAnAccount => 'Create an Account';

  @override
  String get chooseAccountType =>
      'Choose the type of account you want to create:';

  @override
  String get userAccountTitle => 'User Account';

  @override
  String get userAccountDescription =>
      'To discover restaurants and activities, and follow your favorite providers.';

  @override
  String get restaurantProviderAccountTitle => 'Restaurant Provider Account';

  @override
  String get restaurantProviderAccountDescription =>
      'To manage your restaurant and promote your offerings.';

  @override
  String get leisureProviderAccountTitle => 'Leisure Provider Account';

  @override
  String get leisureProviderAccountDescription =>
      'To manage your leisure activities and attract new clients.';

  @override
  String get wellnessProviderAccountTitle => 'Wellness Provider Account';

  @override
  String get wellnessProviderAccountDescription =>
      'To manage your well-being activity and attract new clients.';

  @override
  String get signupTitle => 'Signup';

  @override
  String get signupSubtitle => 'Enter your email and password to signup';

  @override
  String get businessName => 'Business Name';

  @override
  String get fullName => 'Full Name';

  @override
  String get fullNamePlaceholder => 'Full Name';

  @override
  String get userName => 'Username';

  @override
  String get userNamePlaceholder => 'Username';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailPlaceholder => 'Email address';

  @override
  String get passwordLabel => 'Password';

  @override
  String get signupAgreement => 'By signing up, you agree to our';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get andLabel => 'and';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get signupWithApple => 'Apple';

  @override
  String get signupWithGoogle => 'Google';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get loginButton => 'Login';

  @override
  String get otpVerification => 'OTP Verification';

  @override
  String verificationPrompt(Object email) {
    return 'Enter the 6 -digit verification code sent to $email';
  }

  @override
  String get didNotReceiveCode => 'Didn’t receive code?';

  @override
  String get resendCode => 'Resend';

  @override
  String get verifyButton => 'Verify';

  @override
  String get uploadDocumentsTitle => 'Upload Documents';

  @override
  String get uploadDocumentsSubtitle =>
      'Please upload your document to proceed with verification.';

  @override
  String get businessRegistrationDocument => 'Business Registration Document';

  @override
  String get expiryDate => 'Expiry Date';

  @override
  String get selectDate => 'Select date';

  @override
  String get chooseFile => 'Choose a file';

  @override
  String get maxFileSizeNote => 'Max file size (PDF): 2MB';

  @override
  String get utilityBillOrInvoice => 'Utility Bill or Invoice';

  @override
  String get submitForReview => 'Submit for Review';

  @override
  String get loginInstruction => 'Enter your email and password to log in ';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get forgotPassword => 'Forgot Password';

  @override
  String get noAccountPrompt => 'Don’t have an account?';

  @override
  String get forgotPasswordInstruction =>
      'Please enter your email to receive verification code.';

  @override
  String get sendOtpButton => 'Send OTP';

  @override
  String get resetPasswordTitle => 'Reset Password';

  @override
  String get resetPasswordNote =>
      'Your new password must be different from previous used passwords.';

  @override
  String get newPasswordLabel => 'New Password';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get profileSetup => 'Profile Setup';

  @override
  String get address => 'Address';

  @override
  String get briefDescription => 'Brief Description';

  @override
  String get writeSomethingBrief => 'Write something brief...';

  @override
  String get gallery => 'gallery';

  @override
  String get camera => 'camera';

  @override
  String get chooseYourPhoto => 'Choose your photo';

  @override
  String get links => 'Links';

  @override
  String get next => 'Next';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get choosePreferredLanguage =>
      'Choose your preferred language to continue';

  @override
  String get continueText => 'Continue';

  @override
  String get phoneNumber => 'Phone Number';

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
  String get modify => 'Modify';

  @override
  String get checkIn => 'Check-In';

  @override
  String get upcoming => 'Upcoming';

  @override
  String get inProgress => 'In-Progress';

  @override
  String get completed => 'Completed';

  @override
  String get cancelled => 'Cancelled';

  @override
  String get noUpcomingBooking => 'No upcoming booking';

  @override
  String get noUpcomingBookingMessage => 'You have no upcoming booking';

  @override
  String get bookingInformation => 'Booking Information';

  @override
  String get internalNotes => 'Internal Notes';

  @override
  String get customerInformation => 'Customer Information';

  @override
  String get customerName => 'Customer Name:';

  @override
  String get emailLabel1 => 'Email:';

  @override
  String get bookings => 'Bookings';

  @override
  String get selectProfileImage => 'Select profile image';

  @override
  String get failedToGetImageUrl => 'Failed to get image url';

  @override
  String get phoneLabel => 'Phone:';

  @override
  String get bookingDetails => 'Booking Details';

  @override
  String get language => 'Language';

  @override
  String get validFacebookLink => 'Please enter a valid Facebook link';

  @override
  String get validInstagramLink => 'Please enter a valid Instagram link';

  @override
  String get validWebsiteLink => 'Please enter a valid website link';

  @override
  String get validTwitterLink => 'Please enter a valid Twitter/X link';

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
  String get reclaimAccount => 'Reclaim Your Account';

  @override
  String get retrieveAccess => 'Retrieve access to your existing profile';

  @override
  String get chooseOption => 'Choose your option';

  @override
  String get categoryRestaurant => 'Restaurant';

  @override
  String get categoryLeisure => 'Leisure';

  @override
  String get categoryWellness => 'Wellness';

  @override
  String get searchPlaceholder => 'Search by name...';

  @override
  String get claimAccount => 'Claim Account';

  @override
  String get orText => 'Or';

  @override
  String get uploadDocuments => 'Upload Documents';

  @override
  String get uploadDocumentsDescription =>
      'Please upload your document to proceed with verification.';

  @override
  String get backButton => 'Back';

  @override
  String get thankYou => 'Thank you!';

  @override
  String get underReviewMessage =>
      'Your profile are now under review. We will get back to you in two business day.';

  @override
  String get documentBusinessRegistration => 'Buisness  Registration Documents';

  @override
  String get documentLeaseContract => 'Commercial Lease Contract';

  @override
  String get documentUtilityBill => 'Utility Bill';

  @override
  String get documentSupplierInvoice => 'Supplier Invoice';

  @override
  String get documentInsuranceCertificate =>
      'Professional Insurance Certificate';

  @override
  String get documentTax => 'Tax Document';

  @override
  String get documentAuthorizationLetter => 'Signed Authorization Letter';

  @override
  String get create => 'Create';

  @override
  String get createPost => 'Create Post';

  @override
  String get photos => 'Photos';

  @override
  String get fileSupport => 'File supported:';

  @override
  String get imageLimit => 'Up to 5 images';

  @override
  String get exampleTitle => 'e.g Sunday Brunch at The Maple House';

  @override
  String get title => 'Title';

  @override
  String get passwordManager => 'Password Manager';

  @override
  String get currentPassword => 'Current password';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get eventTypeLabel => 'Event Type';

  @override
  String get eventTypePlaceholder => 'Select event type';

  @override
  String get passwordMissing => 'Password is missing';

  @override
  String get passwordInvalidCharacters =>
      'Password contains invalid characters (no emojis allowed)';

  @override
  String get emailMissing => 'Email is missing';

  @override
  String get invalidEmail => 'Invalid Email';

  @override
  String get invalidPassword => 'Invalid Password';

  @override
  String get interest => 'Interest';

  @override
  String get choices => 'Choices';

  @override
  String get seeMore => 'See more';

  @override
  String get eventsNearYou => 'Events near you';

  @override
  String get surpriseMe => 'Surprise me';

  @override
  String get seeFullMenu => 'See Full Menu';

  @override
  String get organizer => 'Organizer';

  @override
  String get moreEventsLikeThis => 'More Events Like This';

  @override
  String get showAll => 'Show All';

  @override
  String get ticketPrice => 'Ticket Price';

  @override
  String get perPerson => '/per person';

  @override
  String get bookNow => 'Book Now';

  @override
  String get browseByCategory => 'Browse by Category';

  @override
  String get expiryDate1Placeholder => 'Please Select Expiry Date 1';

  @override
  String get businessRegistrationPlaceholder =>
      'Please Select Business Registration Document';

  @override
  String get expiryDate2Placeholder => 'Please Select Expiry Date 2';

  @override
  String get utilityBillPlaceholder => 'Please Select Utility Bill or Invoice';

  @override
  String get businessNameMissing => 'Business Name is Missing';

  @override
  String get businessNameInvalidCharacters =>
      'Business Name contains invalid characters (no emojis allowed)';

  @override
  String get noInternet => 'No internet';

  @override
  String get enterOtpPlaceholder => 'Please enter the otp';

  @override
  String get otpVerifiedSuccess => 'Otp Verified Successful';

  @override
  String get genericError => 'Something bad happened,Try again.';

  @override
  String get noInternetConnection => 'No Internet Connection';

  @override
  String get success => 'Success';

  @override
  String get registrationSuccessful => 'Registration Successful';

  @override
  String get eventDescriptionPlaceholder => 'Describe your event...';

  @override
  String get exampleTags => 'e.g: #cozy, #outdoor_seating';

  @override
  String get tags => 'Tags';

  @override
  String get addLocation => 'Add location';

  @override
  String get location => 'Location';

  @override
  String get cancel => 'Cancel';

  @override
  String get publish => 'Publish';

  @override
  String get errorSelectImage => 'Please Select at least one image';

  @override
  String get errorEnterTitle => 'Please Enter title';

  @override
  String get errorEnterDescription => 'Please Enter description';

  @override
  String get errorEnterTags => 'Please Enter relative tags';

  @override
  String get errorEnterAddress => 'Please Enter address';

  @override
  String get searchUserPlaceholder => 'Search by username or name...';

  @override
  String get description => 'Description';

  @override
  String get deleteEventConfirmation => 'Delete Event?';

  @override
  String get deleteEventMessage =>
      'This action will permanently remove the event.';

  @override
  String get events => 'Events';

  @override
  String get sampleEventName => 'Wine & Dine Evening';

  @override
  String get statusActive => 'Active';

  @override
  String get statusDraft => 'Draft';

  @override
  String get statusCompleted => 'Completed';

  @override
  String get createEvent => 'Create Event';

  @override
  String get noEvents => 'No Events Yet';

  @override
  String get noEventsMessage =>
      'You haven’t created any events yet. Start by adding your first one — it only takes a minute!';

  @override
  String get eventDetails => 'Event Details';

  @override
  String get exampleDish => 'E.g: Brochette boeuf...';

  @override
  String get eventName => 'Event Name';

  @override
  String get eventGallery => 'Event Gallery';

  @override
  String get uploadLimit => 'Upload up to 5 images';

  @override
  String get uploadEventImages => 'Upload Event Images*';

  @override
  String get restaurantOrVenue => 'Restaurant name or venue';

  @override
  String get venueName => 'Venue Name';

  @override
  String get venueAddress => 'Address of venue';

  @override
  String get capacityPricing => 'Capacity & Pricing';

  @override
  String get maxPersons => 'Maximum number of persons';

  @override
  String get maxCapacity => 'Maximum Capacity';

  @override
  String get pricePerPerson => 'Price per person';

  @override
  String get schedule => 'Schedule';

  @override
  String get eventDate => 'Event Date';

  @override
  String get startTime => 'Start Time';

  @override
  String get endTime => 'End Time';

  @override
  String get saveAsDraft => 'Save as Draft';

  @override
  String get tapToUpload => 'Tap to upload image';

  @override
  String get event => 'Event';

  @override
  String get participants => 'Participants';

  @override
  String get aboutEvent => 'About Event';

  @override
  String get readMore => 'Read More';

  @override
  String get seeLess => 'See Less';

  @override
  String get socialLinks => 'Social Links';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get yourExperience => 'Your Experience';

  @override
  String get overallRestaurantRating => 'Overall Restaurant Rating';

  @override
  String get service => 'Service';

  @override
  String get price => 'Price';

  @override
  String get portions => 'Portions';

  @override
  String get ambiance => 'Ambiance';

  @override
  String get dishesAndMenusConsumed => 'Dishes and Menus Consumed';

  @override
  String get rateTheSelectedDishes => 'Rate The Selected Dishes';

  @override
  String get yourRatingForThisDish => 'Your rating for this dish:';

  @override
  String get fileSupported => 'File supported: PNG, JPG';

  @override
  String get chooseAFile => 'Choose a file';

  @override
  String get upTo5Images => 'Up to 5 images';

  @override
  String get remove => 'Remove';

  @override
  String get whichRestaurantDidYouVisit => 'Which restaurant did you visit?';

  @override
  String get whichWellnessDidYouVisit => 'Which wellness did you visit?';

  @override
  String get whichLeisureEventDidYouAttend =>
      'Which leisure event did you attend?';

  @override
  String get filters => 'Filters';

  @override
  String get distance => 'Distance';

  @override
  String get place => 'Place';

  @override
  String get dishName => 'Dish Name';

  @override
  String get dishRating => 'Dish Rating';

  @override
  String get resetAll => 'Reset All';

  @override
  String get applyFilters => 'Apply Filters';

  @override
  String get any => 'Any';
}

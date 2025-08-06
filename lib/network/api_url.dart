const String baseUrl = "http://choice-app-prod-env.eba-wqrm9be2.eu-west-3.elasticbeanstalk.com";//production url


const String loginApiUrl = "$baseUrl/api/producer/auth/login";
const String signUpApiUrl = "$baseUrl/api/producer/auth/register";
const String verifySignupOtpApiUrl = "$baseUrl/api/producer/auth/verifyOtp";
const String resendSignupOtpApiUrl = "$baseUrl/api/producer/auth/resendSignUpOtp";
const String verifyFgOtpApiUrl = "$baseUrl/api/producer/auth/verifyForgotPasswordOtp";
const String resendFgOtpApiUrl = "$baseUrl/api/producer/auth/resendForgotPasswordOtp";
const String forgotPasswordApiUrl = "$baseUrl/api/producer/auth/forgotPassword";
const String resetPasswordApiUrl = "$baseUrl/api/producer/auth/resetPassword";
const String submitDocsApiUrl = "$baseUrl/api/producer/auth/submitDocuments";
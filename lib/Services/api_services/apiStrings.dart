import 'apiConstants.dart';

final Uri getUserRegister = Uri.parse('${baseUrl}register');
final Uri getCountry = Uri.parse('${baseUrl}get_countries');
final Uri getSate= Uri.parse('${baseUrl}get_states');
final Uri getUserLogin= Uri.parse('${baseUrl}login');
final Uri sendOTPAPI= Uri.parse('${baseUrl}sendotp');
final Uri forgotAPI= Uri.parse('${baseUrl}forgot_password');
final Uri homeSliderAPI= Uri.parse('${baseUrl}golf_banners');
final Uri homeCategoryAPI= Uri.parse('${baseUrl}ground_category');
final Uri homeGroundAPI= Uri.parse('${baseUrl}all_ground?category=');
final Uri verifyOTPAPI = Uri.parse('${baseUrl}verifyotp');
final Uri getPrivacyPolicyAPI = Uri.parse('${baseUrl}policies?slug=privacy_policy');
final Uri getTermsAPI = Uri.parse('${baseUrl}policies?slug=terms_and_condition');
final Uri changePasswordAPI = Uri.parse('${baseUrl}change_password');
final Uri getProfileApi = Uri.parse('${baseUrl}get_profile');
final Uri updateProfileApi = Uri.parse('${baseUrl}update_profile');
final Uri getFAQApi = Uri.parse('${baseUrl}faqs?user_type=0');
final Uri getTransactionApi = Uri.parse('${baseUrl}transaction_histroy');
final Uri fetchProductByFillters = Uri.parse('${baseUrl}add_money');
final Uri getCommunity = Uri.parse('${baseUrl}get_community');
final Uri deleteCommunity = Uri.parse('${baseUrl}delete_community');
final Uri getMedia = Uri.parse('${baseUrl}get_media');
final Uri getMediaApi = Uri.parse('${baseUrl}get_media');
final Uri UpdatePurchesProducttt = Uri.parse('${baseUrl}product_update');
final Uri GetBookingHistory = Uri.parse('${baseUrl}booking_history');
final Uri GetBookingDetails = Uri.parse('${baseUrl}booking_details');
final Uri GetGroundDetails = Uri.parse('${baseUrl}ground');
final Uri AvailableTimeSlot = Uri.parse('${baseUrl}available_slots');
final Uri BookingGround = Uri.parse('${baseUrl}booking');
final Uri ApplyPromocode = Uri.parse('${baseUrl}applied_offer');
final Uri Addreview = Uri.parse('${baseUrl}ground_review');
final Uri cancleBooking = Uri.parse('${baseUrl}cancel_booking');
final Uri raiseComplaintRequest = Uri.parse('${baseUrl}raise_complaint');
final Uri GetNotification = Uri.parse('${baseUrl}get_notification');
final Uri supportAPI = Uri.parse('${baseUrl}policies?slug=support_us');
final Uri SearchbytimeSlotAPI = Uri.parse('${baseUrl}search_by_slot_availability');



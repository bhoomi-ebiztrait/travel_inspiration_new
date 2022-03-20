class ApiParameter {
  static const BASE_URL = "https://solutiontrackers.com/TravelApp/api/";
  // static const GOOGLE_API_KEY = "AIzaSyBRNil_iYmWUTUysdN_CU7KgDmv-ramMcM";
  static const GOOGLE_API_KEY = "AIzaSyChyfRRNXGlEzpZ3TjywKJKppBtJdU5180";

  static DateTime DOB_START = DateTime(1953, 01, 01);
  static DateTime DOB_END = DateTime(2003, 12, 31);
  static DateTime START_DATE = DateTime(2003, 12, 31);
  static DateTime END_DATE = DateTime(2030, 12, 31);
  static int REFLECT_MODE = 1;
  static int CGV_ID = 3;
  static int TERMS_ID = 1;
  static int PRIVACY_ID = 2;

  static const MESSAGE = "message";
  static const STATUS = "status";
  static const CODE = "code";
  static const success = "success";

  static const ONE_POUND_VAL = 100.50;
  static const POUND_SYM = "£";


  // google places url

  // static const GoogleDirectionURL  = "https://maps.googleapis.com/maps/api/directions/json";
  static const GoogleDistanceURL  = "https://maps.googleapis.com/maps/api/distancematrix/json";
  static const GooglePlaceURL  = "https://maps.googleapis.com/maps/api/place/nearbysearch/json";
  static const GooglePlaceDetailsURL  = "https://maps.googleapis.com/maps/api/place/details/json";
  static const GooglePlacePhotosURL  = "https://maps.googleapis.com/maps/api/place/photo";
  static const PREFIXURL  = GooglePlacePhotosURL+"?key="+GOOGLE_API_KEY+"&maxwidth=200&photo_reference=";
  static const googleairportlistURL  = "https://maps.googleapis.com/maps/api/place/textsearch/json?";
  static const getIATAcode ="https://iatageo.com/getCode/";
// google keyword

  static const resturantType = "restaurant";
  static const hotelType = "hotels";
  static const activityType = "activity";
  //api endpoint

  static const loginURL = BASE_URL + "SignIn";
  static const loginWithbioURL = BASE_URL + "loginWithbio";
  static const signUp = BASE_URL + "SignUp";
  static const FORGOTPASSWORD = BASE_URL + "ForgotPassword";
  static const countryListURL = BASE_URL + "getCountryList";
  static const createProfileURL = BASE_URL + "createProfile";
  static const updateAvtarURL = BASE_URL + "updateAvatar";
  static const updateThemeURL = BASE_URL + "updateProjectImage";
  static const updateProjectURL = BASE_URL + "updateProject";
  static const selectModeURL = BASE_URL + "selectMode";
  static const pinDestinationURL = BASE_URL + "pinDestination";
  static const sendNotificationToUserURL = BASE_URL + "sendNotificationToUser";
  static const createPinURL = BASE_URL + "createPin";
  static const getPinListURL=BASE_URL+"getPinList";
  static const deletePinListURL=BASE_URL+"deletePin";
  static const createSubProjectURL = BASE_URL + "createSubReflectProject";
  static const createFavouriteURL = BASE_URL + "createBookmarkedDestination";
  static const deleteFavouriteURL = BASE_URL + "deleteBookmarkedDestination";
  static const getFavouriteListURL = BASE_URL + "getBookmarkedDestination";
  static const createReflectProjectURL = BASE_URL + "createReflectProject";
  static const createInspireProjectURL = BASE_URL + "createInspireProject";
  static const CHANGEPASSWORD=BASE_URL+"changePassword";
  static const GETFAQTITLELIST=BASE_URL+"getFaqTitleList";
  static const GETFAQLIST=BASE_URL+"getFaqList";
  static const GETARTICALLIST=BASE_URL+"getArticalList";
  static const getAuthInfoURL=BASE_URL+"getAuthInfo";
  static const GAIAINFO=BASE_URL+"gaiaInfo";
  static const GETLANGUAGE=BASE_URL+"getLanguage";
  static const UPDATELANGUAGE=BASE_URL+"updateLanguage";
  static const DELETEACCOUNT=BASE_URL+"deleteAccount";
  static const getProfileURL=BASE_URL+"getProfile";
  static const updateDOBURL=BASE_URL+"updateDOB";
  static const updateAddressURL=BASE_URL+"updateAddress";
  static const SIGNOUT=BASE_URL+"signOut";
  static const getAllProjectsURL=BASE_URL+"getAllProjects";
  static const gethuadosUsersURL=BASE_URL+"gethuadosUsers";
  static const getSettingsURL=BASE_URL+"fetch_general_setting";
  static const updateKmURL=BASE_URL+"updateKm";
  static const getAirlines=BASE_URL+"getAirlines";
  static const getTrains=BASE_URL+"getTrains";
  static const addFlight=BASE_URL+"addFlight";
  static const addRoute=BASE_URL+"addRoute";
  static const addTrain=BASE_URL+"addTrain";
  static const getFlightListURL=BASE_URL+"getFlightList";
  static const getTrainListURL=BASE_URL+"getTrainList";
  static const getMyRoutes=BASE_URL+"getMyRoutes";
  static const deleteProjectURL=BASE_URL+"deleteProject";
  static const general_setting=BASE_URL+"general_setting";
  static const verify_user=BASE_URL+"verify/user";
  static const availableFlightsURL="/TravelApp/api/availableFlights";
  static const searchFlights="/TravelApp/api/searchFlights";


  //sign up req param
  static const EMAIL = "email";
  static const PASSWORD = "password";
  static const ISCGVCHECKED = "isCGVChecked";
  static const DEVICETOKEN = "deviceToken";

  //change password req param
  static const userId="userId";
  static const old_password="old_password";
  static const new_password="new_password";

  //faq list title api res param
  static const titleId="title_id";
  static const title="title";
  static const image="image";
  static const data="data";
  static const userInfo="userInfo";

  //faq list res param
  static const queId="queId";
  static const question="question";
  static const answer="answer";


  static const id="id";
  static const detail="detail";
  static const access_token="access_token";

  //update language req param
  static const languageId="languageId";

  //get language res param
  static const language_name="language_name";
  static const language_code="language_code";


  static const projectId="projectId";
  static const departure="departure";
  static const arrival="arrival";
  static const depart_date="depart_date";
  static const arrive_date="arrive_date";
  static const airline="airline";
  static const ticketNo="ticketNo";
  static const type="type";
  static const mode="mode";

}

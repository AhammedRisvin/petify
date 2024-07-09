import '../env.dart';

class Urls {
  static String baseUrl = Environments.baseUrl;

  static String addBlogUrl = "${baseUrl}user/addBlog";
  static String addBlogViewUrl = "${baseUrl}user/addView";
  static String getBlogUrl = "${baseUrl}user/getblogs?&filter=";
  static String addEventUrl = "${baseUrl}user/addEvent";
  static String addDetails = "${baseUrl}user/addDetails";
  static String getEventsUrl = "${baseUrl}user/getEvents?filter=";
  static String login = "${baseUrl}user/login";
  static String getDocuments = "${baseUrl}user/documents?pet=";
  static String addPetDocument = "${baseUrl}user/document";
  static String getDewarming = "${baseUrl}user/getDewarming?petId=";
  static String postLostPetUrl = "${baseUrl}user/lostPet";
  static String getLostPetUrl = "${baseUrl}user/lostpets?status=";
  static String postFoundPet = "${baseUrl}user/foundPet/";
  static String addDewarming = "${baseUrl}user/addDewarming";
  static String editDewarming = "${baseUrl}user/editDewarming";
  static String deleteDewarming = "${baseUrl}user/deleteDewarming";
  static String vaccination = "${baseUrl}user/vaccination?pet=";
  static String deleteVaccination = "${baseUrl}user/vaccination/";
  static String updateVaccination = "${baseUrl}user/vaccination/";
  static String addNewGrowthUrl = "${baseUrl}user/addGrowth";
  static String editGrowthUrl = "${baseUrl}user/editGrowth";
  static String createCommunityUrl = "${baseUrl}user/createGroup";
  static String editCommunityUrl = "${baseUrl}user/editGroup/";
  static String getTrendingCommunityUrl = "${baseUrl}user/trendingGroups";
  static String addCoParent = "${baseUrl}user/pets/coParent";
  static String getPets = "${baseUrl}user/petsName";
  static String getPetsWithoutTempParent =
      "${baseUrl}user/pets/temporaryParent/unlistedpet";
  static String addTempAccess = "${baseUrl}user/pets/temporaryParent";
  static String addPetForTemporaryParent =
      "${baseUrl}user/pets/temporaryParent/addPet";

  static String addUserProfileUrl = "${baseUrl}user/petUserDetails";
  static String getUserProfileUrl = "${baseUrl}user/petUserDetails";
  static String addPetUrl = "${baseUrl}user/pet";
  static String getPetAchievements = "${baseUrl}user/petAchievments?pet=";
  static String createPetAchievment = "${baseUrl}user/petAchievment";
  static String deletePetAchievment = "${baseUrl}user/petAchievment?id=";
  static String getPetExpenses = "${baseUrl}user/petExpenses?pet=";
  static String deletePetExpense = "${baseUrl}user/petExpense/";
  static String createPetExpense = "${baseUrl}user/petExpense";
  static String getPetGrowthUrl = "${baseUrl}user/getGrowth?petId=";
  static String getCommunityHome = "${baseUrl}user/trendingGroups";
  static String getPetUrl = "${baseUrl}user/pets";
  static String createCommunityFeed = "${baseUrl}user/createFeed";
  static String communityJoin = "${baseUrl}user/joinGroup/";
  static String communityLeftGroup = "${baseUrl}user/leftGroup/";
  static String communityFeedLike = "${baseUrl}user/likeFeed/";
  static String communityFeedShare = "${baseUrl}user/shareFeed/";
  static String communityFeedDetail = "${baseUrl}user/fetchAllFeeds/";
  static String adminCommunityDetail = "${baseUrl}user/adminCommunityDetail/";
  static String removeUserFromGroup = "${baseUrl}user/removeUserFromGroup/";
  static String deleteCommunity = "${baseUrl}user/deleteGroup/";

  static String fetchAllMessages = "${baseUrl}user/fetchAllMessages/";
  static String commentFeed = "${baseUrl}user/commentFeed/";

  static String getListOfChatsUrl = "${baseUrl}user/fetchJoinedGroups";
  static String fetchJoinedGroupsSearch =
      "${baseUrl}user/fetchJoinedGroupsSearch?keyword=";
  static String searchCommunityGroupMembers =
      "${baseUrl}user/searchGroupMembers/";

  static String getCoParentUrl = "${baseUrl}user/pets/coParents";
  static String getTempAccessUrl = "${baseUrl}user/pets/temporaryParents";
  static String removeCoParent = "${baseUrl}user/pets/coParent/";
  static String removeTempAccess = "${baseUrl}user/pets/temporaryParent/";

  static String getTempParentPet =
      "${baseUrl}user/pets/temporaryParent/pets?temporaryParent=";

  static String removePetFromTempParent =
      "${baseUrl}user/pets/temporaryParent/removePet";

  static String editUserProfileUrl = "${baseUrl}user/petUserDetails";
  static String getPetServicesUrl = "${baseUrl}user/get-clinic-services";
  static String getPetClinicsUrl = "${baseUrl}user/get-clinics?serviceId=";

  static String getPetSlotUrl = "${baseUrl}user/get-slotes?clinicId=";

  static String bookServicesSlotUrl = "${baseUrl}user/book-slotes";

  static String allAppoinmentsUrl = "${baseUrl}user/get-all-appointments";
  static String upcomingAppoinmentsUrl =
      "${baseUrl}user/get-upcoming-appointments";
  static String endedAppoinmentsUrl = "${baseUrl}user/get-past-appointments";

  static String addNewDatePost = "${baseUrl}user/createDatingPost";
  static String editNewDatePostUrl = "${baseUrl}user/editDatingPost/";
  static String viewAllDatingPosts = "${baseUrl}user/viewAllDatingPosts";
  static String searchDatingPosts = "${baseUrl}user/viewAllDatingPosts?search=";
  static String categoryDatingPosts =
      "${baseUrl}user/viewAllDatingPosts?species=";
  static String filterDatingUrl =
      "${baseUrl}user/viewAllDatingPosts?longitude=";

  static String dateDetailsUrl = "${baseUrl}user/datingPost";

  static String getUserDatingPosts = "${baseUrl}user/fetchDatingUserPosts";
  static String deleteDatePost = "${baseUrl}user/deleteDatingPost/";
  static String getAllChats = "${baseUrl}user/fetchDatingChats";
  static String getAccessChat = "${baseUrl}user/accessDatingChat/";
  static String fetchAllMessagesSingleChat =
      "${baseUrl}user/fetchAllMessagesSingleChat/";
  static String fetchAllGroups = "${baseUrl}user/fetchAllGroups?keyword=";
  static String getAllAdoptedPets = "${baseUrl}user/fetchAllAdoptions?search=";
  static String getAdoptedPetDetails = "${baseUrl}user/adoptionDetail/";
  static String showInterest = "${baseUrl}user/addIntrest/";
  static String getInterestedPets = "${baseUrl}user/fetchIntrerestedAdoptions";
  static String unIntrestUrl = "${baseUrl}user/unIntrest/";

  static String getGrowthHistoryUrl = "${baseUrl}user/getGrowth-history?petId=";
  static String deleteGrowth = "${baseUrl}user/deleteGrowth";
  static String changeCurrentRole = "${baseUrl}user/change-current-role";
  static String createUserRole = "${baseUrl}user/create-role";
}

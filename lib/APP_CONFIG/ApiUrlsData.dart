abstract class ApiUrlsData {

  static String domain = "http://192.168.43.160:3000";
  //..................................appStart........................................
  static String appStart = "$domain/api/appstart";

  //.......................................user............................................
  static String userProfilePicUpdate =
      "$domain/api/user/profilepicupdate";
  static String userProfileDetailsUpdate =
      "$domain/api/user/updateprofile";

  static String userData = "$domain/api/user";

  static String mobileOtp = "$domain/api/user/mobileotp";
  static String verifyOtp = "$domain/api/user/verifyotp";
  static String userRegistration =
      "$domain/api/user/register";
  static String userFollowers = "$domain/api/user/followers";
  static String userFollowings =
      "$domain/api/user/followings";
  static String userHighlights =
      "$domain/api/user/highlights";

  ///user profile data and related posts
  static String userPosts = "$domain/api/user/posts";
  static String userProfileBasicData =
      "$domain/api/user/profile";

//..........................................newsfeed.......................................................
  static String newsFeedUrl = "$domain/api/home/newsfeed";

  static String contestUrl = "$domain/api/home/contests";
//............................................explore..................................................
  static String explorePage = "$domain/api/explore";

  //rewards
  static String rewardsPage = "$domain/api/home/rewards";

  //..................................................add post...................................
  static String addTextPost = "$domain/api/textpost/add";
  static String addImagePost = "$domain/api/imagepost/add";
  static String addVideoPost = "$domain/api/videopost/add";
  static String createContest =
      "$domain/api/contestpost/add";
  static String addPollPost = "$domain/api/pollpost/add";
  static String addEventPost = "$domain/api/eventpost/add";

  ///edit post
  ///[postId,description]
  static String editPost = "$domain/api/post/edit";

  ///delete post
  ///[postId]
  static String deletePost = "$domain/api/post/delete";

  //........................................comments..................................................
  static String comments = "$domain/api/post/comments";

  static String addComment = "$domain/api/post/comment/add";
  static String removeComment =
      "$domain/api/post/comment/remove";

  static String addSubComment =
      "$domain/api/post/subcomment/add";
  static String removeSubComment =
      "$domain/api/post/subcomment/remove";
  static String editComment =
      "$domain/api/post/comment/edit";
  static String editSubComment =
      "$domain/api/post/subcomment/edit";

  //reactions
  static String allPostReaction =
      "$domain/api/post/reactions";
  static String addPostReaction =
      "$domain/api/post/reaction/add";
  static String removePostReaction =
      "$domain/api/post/reaction/remove";

  //..............................................user story or status.................................

  static String addStatus = "$domain/api/status/add";
  static String removeStatus = "$domain/api/status/remove";
  static String getStatus = "$domain/api/status";
  static String statusHistory = "$domain/api/status/history";
  static String addStatusFromPost =
      "$domain/api/status/addfrompost";

  //........................................status comments section..................................
  static String statusComments = "$domain/api/status/comments";
  static String addStatusComments = "$domain/api/status/comment/add";
  static String editStatusComments = "$domain/api/status/comment/edit";
  static String deleteStatusComments = "$domain/api/status/comment/remove";




  //chat
  static String followlist = "$domain/api/followlists";
  static String sendMessage = "$domain/api/chatroom/message";
  static String newChatroom = "$domain/chatrooms";
  static String chatroomAllMessages =
      "$domain/chatroom/messages";

  //chat socket
  static String socketUrl = "http://18.188.219.114:3002";

  //contest urls
  static String addContestPoster =
      "$domain/api/contest/addposter";
  static String contestsOrganised =
      "$domain/api/contests/organised";

  static String contestsParticipated =
      "$domain/api/contests/participated";

  static String contestPosts = "$domain/api/contest/posts";

  static String contestParticipatePostUpload =
      "$domain/api/contest/participate/post";

  static String removeContestRequest =
      "$domain/api/contest/removerequest";

  static String removeContestParticipantPost =
      "$domain/api/contest/participate/remove";

  static String contestReaction =
      "$domain/api/contest/reaction";


      //.................................post promotions urls................................................
      static String checkPromotionPricing =
      "$domain/api/checkpricing";

      static String addPromotionPost =
      "$domain/api/addpromotion";

      static String promotionPaymentOrder =
      "$domain/api/paymentorder";

      static String promotionPaymentVerify=
      "$domain/api/paymentverify";


}

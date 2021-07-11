abstract class ApiUrlsData {
  static String domain = "http://18.188.219.114:3000";
  //appStart
  static String appStart = "http://18.188.219.114:3000/api/appstart";

  //user
  static String userProfilePicUpdate =
      "http://18.188.219.114:3000/api/user/profilepicupdate";
  static String userProfileDetailsUpdate =
      "http://18.188.219.114:3000/api/user/updateprofile";

  static String userData = "http://18.188.219.114:3000/api/user";

  static String mobileOtp = "http://18.188.219.114:3000/api/user/mobileotp";
  static String verifyOtp = "http://18.188.219.114:3000/api/user/verifyotp";
  static String userRegistration =
      "http://18.188.219.114:3000/api/user/register";
  static String userFollowers = "http://18.188.219.114:3000/api/user/followers";
  static String userFollowings =
      "http://18.188.219.114:3000/api/user/followings";
  static String userHighlights =
      "http://18.188.219.114:3000/api/user/highlights";

  ///user profile data and related posts
  static String userPosts = "http://18.188.219.114:3000/api/user/posts";
  static String userProfileBasicData =
      "http://18.188.219.114:3000/api/user/profile";

//newsfeed
  static String newsFeedUrl = "http://18.188.219.114:3000/api/home/newsfeed";

  static String contestUrl = "http://18.188.219.114:3000/api/home/contests";
//explore
  static String explorePage = "http://18.188.219.114:3000/api/explore";

  //rewards
  static String rewardsPage = "http://18.188.219.114:3000/api/home/rewards";

  //add post
  static String addTextPost = "http://18.188.219.114:3000/api/textpost/add";
  static String addImagePost = "http://18.188.219.114:3000/api/imagepost/add";
  static String addVideoPost = "http://18.188.219.114:3000/api/videopost/add";
  static String createContest =
      "http://18.188.219.114:3000/api/contestpost/add";
  static String addPollPost = "http://18.188.219.114:3000/api/pollpost/add";
  static String addEventPost = "http://18.188.219.114:3000/api/eventpost/add";

  ///edit post
  ///[postId,description]
  static String editPost = "http://18.188.219.114:3000/api/post/edit";

  ///delete post
  ///[postId]
  static String deletePost = "http://18.188.219.114:3000/api/post/delete";

  //comments
  static String comments = "http://18.188.219.114:3000/api/post/comments";

  static String addComment = "http://18.188.219.114:3000/api/post/comment/add";
  static String removeComment =
      "http://18.188.219.114:3000/api/post/comment/remove";

  static String addSubComment =
      "http://18.188.219.114:3000/api/post/subcomment/add";
  static String removeSubComment =
      "http://18.188.219.114:3000/api/post/subcomment/remove";
  static String editComment =
      "http://18.188.219.114:3000/api/post/comment/edit";
  static String editSubComment =
      "http://18.188.219.114:3000/api/post/subcomment/edit";

  //reactions
  static String allPostReaction =
      "http://18.188.219.114:3000/api/post/reactions";
  static String addPostReaction =
      "http://18.188.219.114:3000/api/post/reaction/add";
  static String removePostReaction =
      "http://18.188.219.114:3000/api/post/reaction/remove";

  //user story or status
  static String addStatus = "http://18.188.219.114:3000/api/status/add";
  static String removeStatus = "http://18.188.219.114:3000/api/status/remove";
  static String getStatus = "http://18.188.219.114:3000/api/status";
  static String statusHistory = "http://18.188.219.114:3000/api/status/history";
  static String addStatusFromPost =
      "http://18.188.219.114:3000/api/status/addfrompost";

  //chat
  static String followlist = "http://18.188.219.114:3000/api/followlists";
  static String sendMessage = "http://18.188.219.114:3000/api/chatroom/message";
  static String newChatroom = "http://18.188.219.114:3000/chatrooms";
  static String chatroomAllMessages =
      "http://18.188.219.114:3000/chatroom/messages";

  //chat socket
  static String socketUrl = "http://18.188.219.114:3002";

  //contest urls
  static String addContestPoster =
      "http://18.188.219.114:3000/api/contest/addposter";
  static String contestsOrganised =
      "http://18.188.219.114:3000/api/contests/organised";

  static String contestsParticipated =
      "http://18.188.219.114:3000/api/contests/participated";

  static String contestPosts = "http://18.188.219.114:3000/api/contest/posts";

  static String contestParticipatePostUpload =
      "http://18.188.219.114:3000/api/contest/participate/post";

  static String removeContestRequest =
      "http://18.188.219.114:3000/api/contest/removerequest";

  static String removeContestParticipantPost =
      "http://18.188.219.114:3000/api/contest/participate/remove";

  static String contestReaction =
      "http://18.188.219.114:3000/api/contest/reaction";
}

import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CommentDisplayController extends GetxController {
  String postId;
  List comments = [].obs;
  bool isCommentsLoaded = false;
  TextEditingController commentEditingController,
      subCommentEditingController,
      editCommentController,
      editSubCommentController;

  @override
  onInit() {
    commentEditingController = TextEditingController();
    subCommentEditingController = TextEditingController();
    editCommentController = TextEditingController();
    editSubCommentController = TextEditingController();

    print("initialised");
    super.onInit();
  }

  //get comments
  getComments() async {
    comments = [];
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.comments, {"postId": postId}, userToken);
    if (response == "error") {
      print("error");
    } else {
      isCommentsLoaded = true;
      comments.addAll(response);
      update();
    }
  }

  //add comment
  addComment(String comment) async {
    var response = await ApiServices.postWithAuth(ApiUrlsData.addComment,
        {"postId": postId, "comment": comment}, userToken);
    if (response == "error") {
      print("error");
    } else {
      comments.insert(0, response);
      print(response);
      commentEditingController.text = "";
      update();
      print(response);
      update();
    }
  }

  //add subcomments
  addSubComments(String commentId, String subComment) async {
    var response = await ApiServices.postWithAuth(ApiUrlsData.addSubComment,
        {"commentId": commentId, "subComment": subComment}, userToken);
    if (response == "error") {
      print("error");
    } else {
      // comments = [];
      // comments.addAll(response);
      //find the index of the editted comment
      int _index =
          comments.indexWhere((element) => element["_id"] == commentId);
      //remove the comment and then
      comments.removeAt(_index);
      //insert the comment
      comments.insert(_index, response);

      subCommentEditingController.text = "";
      update();
    }
  }

  //remove comment
  removeComment(String commentId) async {
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.removeComment, {"commentId": commentId}, userToken);
    if (response == "error") {
      print("error");
    } else {
      //find the index of the editted comment
      int _index =
          comments.indexWhere((element) => element["_id"] == commentId);
      //remove the comment and then
      comments.removeAt(_index);
      update();
    }
  }

  //remove subcomment
  removeSubComment(String commentId, String subCommentId) async {
    print(subCommentId);
    var response = await ApiServices.postWithAuth(ApiUrlsData.removeSubComment,
        {"commentId": commentId, "subCommentId": subCommentId}, userToken);
    if (response == "error") {
      print("error");
    } else {
      //find the index of the editted comment
      int _index =
          comments.indexWhere((element) => element["_id"] == commentId);
      //remove the comment and then
      comments.removeAt(_index);
      //insert the comment
      comments.insert(_index, response);
      print(response);
      update();
    }
  }

  //edit comment
  editComment(String commentId) async {
    print(commentId);
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.editComment,
        {"commentId": commentId, "newComment": editCommentController.text},
        userToken);
    if (response == "error") {
      print("error");
    } else {
      //find the index of the editted comment
      int _index =
          comments.indexWhere((element) => element["_id"] == commentId);
      //remove the comment and then
      comments.removeAt(_index);
      comments.insert(_index, response);
      update();
    }
  }

  //edit subComent
  editSubComment(String commentId, String subCommentId) async {
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.editSubComment,
        {
          "commentId": commentId,
          "subCommentId": subCommentId,
          "newSubComment": editSubCommentController.text
        },
        userToken);
    if (response == "error") {
      print("error");
    } else {
      //find the index of the editted comment
      int _index =
          comments.indexWhere((element) => element["_id"] == commentId);
      //remove the comment and then
      comments.removeAt(_index);
      comments.insert(_index, response);
      update();
    }
  }

  @override
  void dispose() {
    Get.delete<CommentDisplayController>();
    super.dispose();
  }
}

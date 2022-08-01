// ignore_for_file: unnecessary_this

import 'package:video_player/video_player.dart';

class VideosList {
  String? vidID;
  String? userid;
  String? catid;
  String? title;
  String? vidURL;
  String? dt;
  VideoPlayerController? controller;
  Future<void>? initializeVideoPlayerFuture;

  VideosList(
      {this.vidID,
      this.userid,
      this.catid,
      this.title,
      this.vidURL,
      this.dt,
      this.controller,
      this.initializeVideoPlayerFuture});

  VideosList.fromJson(Map<String, dynamic> json) {
    vidID = json['vidID'];
    userid = json['userid'];
    catid = json['catid'];
    title = json['title'];
    vidURL = json['vidURL'];
    dt = json['dt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vidID'] = this.vidID;
    data['userid'] = this.userid;
    data['catid'] = this.catid;
    data['title'] = this.title;
    data['vidURL'] = this.vidURL;
    data['dt'] = this.dt;
    return data;
  }
}

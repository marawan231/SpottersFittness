part of 'videos_cubit.dart';

@immutable
abstract class VideosState {}

class VideosInitial extends VideosState {}

class VideosListLoaded extends VideosState {
  final List<VideosList> videosList;

  VideosListLoaded(this.videosList);
}

class VideosListLoading extends VideosState {}

class VideosListError extends VideosState {
  final String error;

  VideosListError(this.error);
}

class VideoUploadedSuccess extends VideosState {
  VideoUploadedSuccess();
}

class VideoUploadLoading extends VideosState {}

class VideoUploadError extends VideosState {}

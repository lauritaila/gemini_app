import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'generated_history_provider.g.dart';

@Riverpod(keepAlive: true)
class GeneratedHistory extends _$GeneratedHistory {

  @override
  build()  => <String>[];

  void addImage(String imageUrl) {
    if(imageUrl == "") return;
    state = [imageUrl, ...state];
  }
}
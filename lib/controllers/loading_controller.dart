import 'package:momentum/momentum.dart';

import '../models/loading_model.dart';

class LoadingController extends MomentumController<LoadingModel> {
  @override
  LoadingModel init() {
    return LoadingModel(
      this,
      isLoading: false,
    );
  }

  void loading() {
    model.update(isLoading: true);
  }

  void noLoading() {
    model.update(isLoading: false);
  }
}

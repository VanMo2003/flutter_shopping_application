import 'package:momentum/momentum.dart';

import '../controllers/loading_controller.dart';

class LoadingModel extends MomentumModel<LoadingController> {
  final bool? isLoading;

  const LoadingModel(LoadingController controller, {this.isLoading})
      : super(controller);

  @override
  void update({bool? isLoading}) {
    LoadingModel(controller, isLoading: isLoading ?? this.isLoading)
        .updateMomentum();
  }
}

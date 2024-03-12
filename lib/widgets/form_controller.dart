typedef OnSubmitListener = Future<void> Function();

class FormController {
  OnSubmitListener? _onSubmitListener;

  set onSubmitListener(OnSubmitListener? listener) {
    _onSubmitListener = listener;
  }

  Future<void> submit() {
    if (_onSubmitListener != null) {
      return _onSubmitListener!();
    } else {
      return Future.value();
    }
  }
}

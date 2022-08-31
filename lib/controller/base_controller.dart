import 'package:test_page/helper/dialog_helper.dart';
import 'package:test_page/services/app_exceptions.dart';

class BaseController {
  void handleError(error) {
    hideLoading();
    if (error is BadRequestException) {
      // Show dialog
      var message = error.message;
      DialogHelper.showErrorDialog(description: message);
    } else if (error is FetchDataException) {
      var message = error.message;
      DialogHelper.showErrorDialog(description: message);
    } else if (error is ApiNotRespondingException) {
      DialogHelper.showErrorDialog(
          description: 'Oops! It took longer to responde.');
    }
  }

  showLoading([String? message]) {
    DialogHelper.showLoadig(message);
  }

  hideLoading() {
    DialogHelper.hideLoading();
  }
}

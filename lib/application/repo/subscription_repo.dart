import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/api_handler.dart';
import '../../env.dart';
import '../model/subscription_model.dart';

class SubscriptionRepo {
  /// journal repo
  Future<Attempt<SubscriptionPackages>> getPackages() async {
    try {


      final url = Uri.parse('$baseUrl/getPackages');

      final response = await http
          .get(url, headers: {"Content-Type": "application/json"})
          .timeout(const Duration(seconds: 10)); // Prevents infinite waiting

      if (response.statusCode == 200 || response.statusCode == 201) {
        return success(SubscriptionPackages.fromJson(jsonDecode(response.body)));
      } else if (response.statusCode == 401) {
        return failed(SessionExpired());
      } else if (response.statusCode == 403) {
        return failed(UnauthorizeAccess());
      }
      return failed(Failure(title: "Something went wrong"));
    } on http.ClientException catch (e) {
      return failed(Failure(title: e.message));
    } on FormatException catch (e) {
      return failed(Failure(title: e.message));
    } on Exception catch (e) {
      return failed(Failure(title: e.toString()));
    }
  }




// createPayment

// Future <Attempt<String>> createPayment()async{

// try{

// final response = await http.post(
//   Uri.parse('$baseUrl/createStripePayment'),
//   body: jsonEncode({
//     'priceId': 'price_XXXX',
//     'currency': 'usd',
//   }),
//   headers: {'Content-Type': 'application/json'},
// );

// final data = jsonDecode(response.body);
// final clientSecret = data['data']['clientSecret'];


// }catch(e){}

// }


//confirm payment


// await Stripe.instance.confirmPayment(
//   clientSecret,
//   PaymentMethodParams.card(
//     paymentMethodData: PaymentMethodData(),
//   ),
// );






  ///add journal
}

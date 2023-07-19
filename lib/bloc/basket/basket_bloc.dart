import 'package:apple_shop/bloc/basket/basket_event.dart';
import 'package:apple_shop/bloc/basket/basket_state.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/util/string_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zarinpal/zarinpal.dart';

import '../../data/repository/basket_repository.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final IBaskeRepository _basketRepository = locator.get();
  PaymentRequest _paymentRequests = PaymentRequest();
  BasketBloc() : super(BasketInitState()) {
    on<BasketFetchFromHiveEvent>(((event, emit) async {
      var basketItemList = await _basketRepository.getAllBasketItems();
      var finalprice = await _basketRepository.getfinal();
      emit(BasketDataFetchedState(basketItemList, finalprice));
    }));
    on<BasketPaymentEvent>(
      (event, emit) {
        _paymentRequests.setIsSandBox(true);
        _paymentRequests.setAmount(1000);
        _paymentRequests.setDescription('this is for test');
        _paymentRequests.setCallbackURL('expertflutter://shop');
        _paymentRequests.setMerchantID('kdjkdfjkdjkfsjldkfskdj');
        linkStream.listen((deeplink) {
          if (deeplink!.toLowerCase().contains('authority')) {
            String? authority = deeplink.extractValueFromQuery('Authority');
            String? status = deeplink.extractValueFromQuery('Status');
            ZarinPal()
                .verificationPayment(status!, authority!, _paymentRequests,
                    (isPaymentSuccess, refID, paymentRequest) {
              if (isPaymentSuccess) {
                print(refID);
              } else {
                print('error');
              }
            });
          }
        });
      },
    );
    on<BasketPaymentRequestEvent>(
      (event, emit) {
        ZarinPal().startPayment(_paymentRequests, (status, paymentGatewayUri) {
          if (status == 100) {
            launchUrl(Uri.parse(paymentGatewayUri!),
                mode: LaunchMode.externalApplication);
          }
        });
      },
    );
  }
}

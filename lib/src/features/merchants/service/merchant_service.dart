import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/src/core/service/firebase_service.dart';
import 'package:ecommerce/src/shared/model/merchant_model.dart';
import 'package:ecommerce/src/shared/service/firebase_auth_service.dart';

class MerchantService {
  MerchantService._privateConstructor();
  static final MerchantService instance = MerchantService._privateConstructor();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<MerchantModel> fetchStoreDetails() async {
    try {
      final userId = FirebaseAuthService.instance.currentUser!.uid;

      final merchant = await FirebaseService.instance
          .getDocumentBasedOnId<MerchantModel, MerchantModel>(
        collection: 'merchants',
        documentId: userId,
        tFromJson: MerchantModel.fromJson,
      );

      final store = await FirebaseService.instance.customQuery<Store, Store>(
        tFromJson: Store.fromJson,
        isList: false,
        snapshot: await _db
            .collection('stores')
            .where('ownerId',
                isEqualTo: FirebaseAuthService.instance.currentUser!.uid)
            .get(),
      );

      MerchantModel merchantModel = merchant.data;

      return merchantModel.copyWith(store: store.data);
    } catch (e) {
      return const MerchantModel();
    }
  }
}

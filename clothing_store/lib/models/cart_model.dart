import 'package:scoped_model/scoped_model.dart';
import 'package:clothing_store/datas/cart_product.dart';
import 'package:clothing_store/models/user_model.dart';

class CartModel extends Model{

  UserModel user;
  
  List<CartProduct> products = [];

  CartModel(this.user);
}






abstract class MainStates {}

class MainInitialStates extends MainStates {}

class UserLoginLoadingStates extends MainStates {}

class UserLoginSuccessStates extends MainStates {



  UserLoginSuccessStates();
}

class UserLoginErrorStates extends MainStates {
  final String error;

  UserLoginErrorStates( this.error);
}

class UserUpdateLoadingStates extends MainStates {}

class UserUpdateSuccessStates  extends MainStates {


  UserUpdateSuccessStates();
}

class UserUpdateErrorStates extends MainStates {
  final String error;

  UserUpdateErrorStates( this.error);
}



////////////////////// Home ///////////////////////////////

class HomeLoadingStates extends MainStates {}

class HomeSuccessStates extends MainStates {}

class HomeErrorStates extends MainStates {}

////////////////////// Favorites ///////////////////////////////

class FavoritesLoadingStates extends MainStates{}

class GetFavoritesSuccessStates extends MainStates{}

class GetFavoritesErrorStates extends MainStates{}

class ChangeFavoritesStates extends MainStates{}

class ChangeFavoritesSuccessStates extends MainStates
{


  ChangeFavoritesSuccessStates();

}


class ChangeFavoritesErrorStates extends MainStates{}

class ProductLoadingStates extends MainStates{}
class getamount_ProductsSuccessStates extends MainStates {



}

class getamount_ProductsErrorStates extends MainStates{
  final String error;

  getamount_ProductsErrorStates(this.error);
}

class ProductSuccessStates extends MainStates {


  ProductSuccessStates();
}
class getImagesSuccessStates extends MainStates {



}
class getImagesErrorStates extends MainStates{
  final String error;

  getImagesErrorStates(this.error);
}

class ProductErrorStates extends MainStates{
  final String error;

  ProductErrorStates(this.error);
}


class GetCategoriesSuccessStates extends MainStates{}

class GetCategoriesErrorStates extends MainStates{
  final String error;

  GetCategoriesErrorStates(this.error);
}
class GetUserSuccessStates extends MainStates{}

class GetUserErrorStates extends MainStates{
  final String error;

  GetUserErrorStates(this.error);
}

class CategoryDetailsLoadingStates extends MainStates{}

class CategoryDetailsSuccessStates extends MainStates{}

class CategoryDetailsErrorStates extends MainStates{}


class CartLoadingStates extends MainStates{}

class GetCartSuccessStates extends MainStates{}

class GetCartErrorStates extends MainStates{}

class ChangeCartStates extends MainStates{}

class ChangeCartSuccessStates extends MainStates{



  ChangeCartSuccessStates();

}

class ChangeCartErrorStates extends MainStates{}

class UpdateCartLoadingStates extends MainStates{}

class UpdateCartSuccessStates extends MainStates{}

class UpdateCartErrorStates extends MainStates{}
class UpdateuserLoadingStates extends MainStates{}

class UpdateuserSuccessStates extends MainStates{}

class UpdateuserErrorStates extends MainStates{
  final String error;
  UpdateuserErrorStates(this.error);
}


class ShowPasswordStates extends MainStates {}

class ChangeNavBarItem extends MainStates {}

class FaqLoadingStates extends MainStates {}

class GetFaqSuccessStates extends MainStates {}

class GetFaqErrorStates extends MainStates {}

class NotificationLoadingStates extends MainStates {}

class GetNotificationSuccessStates extends MainStates {}

class GetNotificationErrorStates extends MainStates {}


class UpdateProductLoadingStates extends MainStates{}

class UpdateProductSuccessStates extends MainStates{}

class UpdateProductErrorStates extends MainStates{
  final String error;

  UpdateProductErrorStates(this.error);
}



class CreateCategoryLoadingStates extends MainStates{}
class CreateCategorySuccessState extends MainStates{}

class CreateCategoryErrorStates extends MainStates{
  final String error;

  CreateCategoryErrorStates(this.error);
}
class LogOutLoadingState extends MainStates {}

class LogOutSuccessState extends MainStates {

}

class LogOutErrorState extends MainStates {
  final String error;

  LogOutErrorState(this.error);
}

class CreateImageSuccessState extends MainStates{}

class CreateImageErrorStates extends MainStates{
  final String error;

  CreateImageErrorStates(this.error);
}
class CreateproductLoadingStates extends MainStates{}

class CreateproductSuccessState extends MainStates{}

class CreateproductErrorStates extends MainStates{
  final String error;

  CreateproductErrorStates(this.error);
}

class deleteproductLoadingStates extends MainStates{}
class deleteProductsSuccessStates extends MainStates{}

class deleteProductsErrorStates extends MainStates{
  final String error;

  deleteProductsErrorStates(this.error);
}





class UpdateProductImageSuccessStates extends MainStates{}

class UpdateProductImageErrorStates extends MainStates{
  final String error;
  UpdateProductImageErrorStates(this.error);
}

class ImageintStates extends MainStates{}
class ImageSuccessStates extends MainStates{}

class ImageErrorStates extends MainStates{
  final String error;
  ImageErrorStates(this.error);
}
class DeleteUserIntiStates extends MainStates{}
class DeleteUserSuccessStates extends MainStates{}
class DeleteCatIntiStates extends MainStates{}
class DeleteCatSuccessStates extends MainStates{}
class GatImagesIntiStates extends MainStates{}
class GatImagesSuccessStates extends MainStates{}
class GatImageserrorStates extends MainStates{
  final String error;
  GatImageserrorStates(this.error);
}
class GetUserIdModelSuccessStates extends MainStates{}

class GetUserIdModelerrorStates extends MainStates{
  final String error;
  GetUserIdModelerrorStates(this.error);
}
class remove_from_cart_loading_stat extends MainStates{

}
class remove_from_cart_Success_stat extends MainStates{}


class CreateOrderLoadingStates extends MainStates{}

class CreateOrderSuccessState extends MainStates{}

class CreateOrderErrorStates extends MainStates {
  final String error;
  CreateOrderErrorStates(this.error);

}
  class updateCreateOrderLoadingStates extends MainStates{}

  class updateOrderSuccessState extends MainStates{}

  class updateOrderErrorStates extends MainStates{
  final String error;

  updateOrderErrorStates(this.error);
  }

class getUsersOrdersLoadingStates extends MainStates{}

class getUsersOrdersSuccessState extends MainStates{}
class donegetUsersOrdersSuccessState extends MainStates{}
class done2getUsersOrdersSuccessState extends MainStates{}
class getUsersOrdersErrorStates extends MainStates{
  final String error;

  getUsersOrdersErrorStates(this.error);
}

class getUsersWaitingOrdersLoadingStates extends MainStates{}

class getUsersWaitingOrdersSuccessState extends MainStates{}
class getUsersWaitingOrdersErrorStates extends MainStates{
  final String error;

  getUsersWaitingOrdersErrorStates(this.error);
}
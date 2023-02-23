class TableUsers {
  static String collectionName = 'users';
  static String TABLE_USERS_ID = 'userId';
}

class TableCategory {
  static String collectionName = 'categories';
}

class TableMedicines {
  static String collectionName = 'medicines';
  static String categoryId = 'category_id';
}

class TableOrders {
  static String collectionName = 'orders';
  static String orderBy = 'order_by';

}

class StoragePath {
  static String AVATAR_SMALL_THUMBNAIL = "250x250";

  static String USER_PROFILE_IMAGE_PATH = 'profile_image/';
}

class OrderStatus{
  static String status_pending = "pending";
  static String status_in_progress = "in progress";
  static String status_out_for_delivery = "out for delivery";
  static String status_delivered = "delivered";
}


import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/entity/post/vo_simple_product_post.dart';
import 'package:fast_app_base/entity/product/product_status.dart';
import 'package:fast_app_base/entity/product/vo_product.dart';
import 'package:fast_app_base/entity/user/vo_address.dart';
import 'package:fast_app_base/entity/user/vo_user.dart';

String picSum(int id) {
  return 'https://picsum.photos/id/$id/200/200';
}

final user1 = User(
  id: 1,
  nickname: '홍길동',
  temperature: 36.5,
  profileUrl: picSum(1010),
);

final user2 = User(
  id: 2,
  nickname: '바다',
  temperature: 36.5,
  profileUrl: picSum(700),
);

final user3 = User(
  id: 3,
  nickname: '파도',
  temperature: 36.5,
  profileUrl: picSum(900),
);

final product1 = Product(user1, '아이폰13', 700000, '깨끗하게 잘 쓰던 물건 입니다. 1', ProductStatus.normal, [picSum(500),picSum(501),picSum(502),picSum(503),]);
final product2 = Product(user2, '아이폰13', 700000, '깨끗하게 잘 쓰던 물건 입니다. 2', ProductStatus.normal, [picSum(504),picSum(505),picSum(506),picSum(507),]);
final product3 = Product(user3, '아이폰14', 700000, '깨끗하게 잘 쓰던 물건 입니다. 3', ProductStatus.normal, [picSum(508),picSum(509),picSum(510),picSum(511),]);

final post1 = SimpleProductPost(1, product1.user, product1, '포스트 입니다1.', Address('서울특별시 송파구 잠실본동1', '서울시'), 10, 30, DateTime.now().subtract(30.minutes));
final post2 = SimpleProductPost(2, product2.user, product2, '포스트 입니다2.', Address('대전광역시 송파구 잠실본동2', '대전시'), 11, 450, DateTime.now().subtract(5.minutes));
final post3 = SimpleProductPost(3, product3.user, product3, '포스트 입니다3.', Address('부산특별시 송파구 잠실본동3', '부산시'), 12, 421, DateTime.now().subtract(10.seconds));

final postList = [post1, post2, post3, post2,post3, post2, post1, post2];
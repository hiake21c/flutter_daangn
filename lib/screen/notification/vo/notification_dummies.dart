

import 'package:fast_app_base/common/dart/extension/num_duration_extension.dart';
import 'package:fast_app_base/screen/notification/vo/vo_notification.dart';

import 'notification_type.dart';

final notification1 = DaangnNotification(NotificationType.official, '💌 8월 가계부가 도착했어요!', '#당근#당근가계부#자원재순환#따뜻한거래', DateTime.now().subtract(3.hours));
final notification2 = DaangnNotification(NotificationType.legal, '당근페이 전자금융거래 이용약관 개정 안내', '계정사항 확인하기(2023년 10월 1일 적용)', DateTime.now().subtract(3.days));
final notification3 = DaangnNotification(NotificationType.official, '지금 새로워진 \'당근\'을 만나보세요.🥕', '종민님, 당근마켓의 새 이름 새 로고를 소개할께요!)', DateTime.now().subtract(4.days));
final notification4 = DaangnNotification(NotificationType.local, '가족집수리', '마음에 드셨다면 다른 이웃들을 위해 따뜻한 후기를 남겨주세요~', DateTime.now().subtract(7.days));

final notificationList = [notification1, notification2, notification3, notification4];
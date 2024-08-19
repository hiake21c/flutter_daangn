import 'dart:io';
import 'dart:math';

import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/util/app_keyboard_util.dart';
import 'package:fast_app_base/common/widget/w_round_button.dart';
import 'package:fast_app_base/entity/product/product_status.dart';
import 'package:fast_app_base/entity/product/vo_product.dart';
import 'package:fast_app_base/screen/dialog/d_message.dart';
import 'package:fast_app_base/screen/main/post_detail/s_post_detail.dart';
import 'package:fast_app_base/screen/main/tab/home/provider/post_provider.dart';
import 'package:fast_app_base/screen/write/d_select_image_source.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/widget/round_button_theme.dart';
import '../../entity/dummies.dart';
import '../../entity/post/vo_simple_product_post.dart';
import '../../entity/user/vo_address.dart';

class WriteScreen extends ConsumerStatefulWidget {
  const WriteScreen({super.key});

  @override
  ConsumerState<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends ConsumerState<WriteScreen>
    with KeyboardDetector {
  final List<String> imageList = [];

  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  bool isLoaded = false;

  @override
  void initState() {
    titleController.addListener(() {
      setState(() {});
    });
    priceController.addListener(() {
      setState(() {});
    });
    descriptionController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '내 물건 팔기'.text.bold.make(),
        actions: [Tap(onTap: () {}, child: '임시저장'.text.make().p(15))],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 150),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ImageSelectWidget(
              imageList,
              onTapDeleteImage: (path) {
                setState(() {
                  imageList.remove(path);
                });
              },
              onTap: () async {
                final selectedSource = await SelectImageSourceDialog().show();
                if (selectedSource == null) {
                  return;
                }

                try{
                  final pickedFile =
                      await ImagePicker().pickImage(source: selectedSource);
                  if (pickedFile == null) {
                    return;
                  }
                  setState(() {
                    imageList.add(pickedFile.path);
                  });
                } on PlatformException catch(e){
                  switch(e.code){
                    case 'invalid_image':
                      MessageDialog('지원하지 않는 이미지 형식 입니다.').show();
                      break;
                    case 'photo_access_denied':
                      MessageDialog('photo_access_denied').show();
                      break;
                    case 'camera_access_denied':
                      MessageDialog('camera_access_denied').show();
                      break;
                  }
                } catch(e){
                  // 권한이 필요해서. -> 앱 설정으로 이동
                  debugPrint(e.toString());
                }
              },
            ),
            _TitleEditor(titleController),
            height30,
            _PriceEditor(priceController),
            height30,
            _DescEditor(descriptionController),
          ],
        ).pSymmetric(h: 15),
      ),
      bottomSheet: isKeyboardOn
          ? null
          : RoundButton(
              text: isLoaded ? '저장 중' : '작성 완료',
              isFullWidth: true,
              borderRadius: 6,
              isEnabled: isVaild,
              rightWidget: isLoaded
                  ? const SizedBox(
                      width: 15,
                      height: 15,
                      child: CircularProgressIndicator(),
                    ).pOnly(right: 80)
                  : null,
              onTap: () {
                final title = titleController.text;
                final price = int.parse(priceController.text);
                final desc = descriptionController.text;
                setState(() {
                  isLoaded = true;
                });
                final list = ref.read(postProvider);
                final simpleProductPost = SimpleProductPost(
                  3,
                  user3,
                  Product(user3, title, price, desc, ProductStatus.normal,
                      imageList),
                  '포스트 입니다3.',
                  const Address('부산특별시 송파구 잠실본동3', '부산시'),
                  0,
                  0,
                  DateTime.now(),
                );
                ref.read(postProvider.notifier).state = List.of(list)
                  ..add(simpleProductPost);
                Nav.pop(context);
                Nav.push(PostDetailScreen(
                  simpleProductPost.id,
                  simpleProductPost: simpleProductPost,
                ));
              },
            ),
    );
  }

  bool get isVaild =>
      isNotBlank(titleController.text) &&
      isNotBlank(priceController.text) &&
      isNotBlank(descriptionController.text);
}

class _ImageSelectWidget extends StatelessWidget {
  final List<String> imageList;
  final VoidCallback onTap;
  final void Function(String path) onTapDeleteImage;

  const _ImageSelectWidget(
    this.imageList, {
    required this.onTap,
    required this.onTapDeleteImage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SelectImageButton(onTap: onTap, imageList: imageList).pOnly(top: 10, right: 8),
            ...imageList.map((imagePath) => Stack(
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.file(
                        File(imagePath),
                        fit: BoxFit.fill,
                      ).box.rounded.border(color: Colors.grey).make()),
                ).pOnly(left: 4, right: 10, top: 10),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Tap(
                      onTap: () {
                        onTapDeleteImage(imagePath);
                      },
                      child: Transform.rotate(
                        angle: pi / 4,
                        child: const Icon(Icons.add_circle),
                      ).pOnly(left: 30, bottom: 30),
                    ),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class SelectImageButton extends StatelessWidget {
  const SelectImageButton({
    super.key,
    required this.onTap,
    required this.imageList,
  });

  final VoidCallback onTap;
  final List<String> imageList;

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: onTap,
      child: SizedBox(
        width: 80,
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt),
            RichText(
                text: TextSpan(
              children: [
                TextSpan(
                    text: imageList.length.toString(),
                    style: TextStyle(color: Colors.orange)),
                TextSpan(text: '/10'),
              ],
            )),
          ],
        ).box.rounded.border(color: Colors.grey).make(),
      ),
    );
  }
}

class _TitleEditor extends StatelessWidget {
  final TextEditingController controller;

  _TitleEditor(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        '제목'.text.bold.make(),
        height5,
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: '제목을 입력해주세요',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
            ),
          ),
        ),
      ],
    );
  }
}

class _PriceEditor extends StatefulWidget {
  final TextEditingController controller;

  _PriceEditor(this.controller);

  @override
  State<_PriceEditor> createState() => _PriceEditorState();
}

class _PriceEditorState extends State<_PriceEditor> {
  bool isDonationMode = false;
  final priceNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        '거래 방식'.text.bold.make(),
        Row(
          children: [
            RoundButton(
                theme: isDonationMode
                    ? RoundButtonTheme.whiteWithBlueBorder
                    : RoundButtonTheme.blue,
                text: '판매 하기',
                onTap: () {
                  widget.controller.clear();
                  setState(() {
                    isDonationMode = false;
                  });
                  delay(() {
                    AppKeyboardUtil.show(context, priceNode);
                  });
                }),
            width10,
            RoundButton(
                theme: !isDonationMode
                    ? RoundButtonTheme.whiteWithBlueBorder
                    : RoundButtonTheme.blue,
                text: '나눔 하기',
                onTap: () {
                  setState(() {
                    widget.controller.text = '0';
                    isDonationMode = true;
                  });
                }),
          ],
        ),
        height5,
        TextField(
          focusNode: priceNode,
          enabled: !isDonationMode,
          keyboardType: TextInputType.number,
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: '\₩ 가격을 입력해 주세요.',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
            ),
          ),
        ),
      ],
    );
    ;
  }
}

class _DescEditor extends StatelessWidget {
  final TextEditingController controller;

  _DescEditor(this.controller);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        '자세한 설명'.text.bold.make(),
        height5,
        TextField(
          controller: controller,
          maxLines: 7,
          decoration: InputDecoration(
            hintText: '에 올릴 게시글 내용을 작성해주세요.',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
            ),
          ),
        ),
      ],
    );
  }
}

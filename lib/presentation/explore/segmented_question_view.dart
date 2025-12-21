import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../application/model/category_model.dart';
import '../../application/model/question_model.dart';
import '../../application/repo/question_repo.dart';
import '../../common/colors.dart';
import '../../common/custom_buttons.dart';
import '../../common/custom_question_tile.dart';
import '../../common/custom_text_style.dart';
import '../../common/gradiant_background.dart';
import '../../common/padding.dart';
import 'explore_view.dart';

class SegmentedQuestionView extends StatefulWidget {
  const SegmentedQuestionView({super.key, required this.category});
  final Category category;
  @override
  State<SegmentedQuestionView> createState() => _SegmentedQuestionViewState();
}

class _SegmentedQuestionViewState extends State<SegmentedQuestionView> {
  QuestionPaginator? _questionPaginator;
  List<Question> questionList = [];

  bool isLoading = false;
  bool isPaginating = false;
  bool reachEnd = false;

  final QuestionRepo _questionRepo = QuestionRepo();

  CategoryTileConfig? config;

  init() async {
    getQuestion();
  }

  void resetPaginator() async {
    _questionPaginator = null;
    questionList = [];
    getQuestion();
  }

  void getQuestion() async {
    if (_questionPaginator == null) {
      isLoading = true;
    } else {
      isPaginating = true;
    }
    if (_questionPaginator != null && _questionPaginator?.pageToken == null) {
      reachEnd = true;
      return;
    }
    setState(() {});

    final (data, error) = await _questionRepo.getJournals();

    if (data != null) {
      questionList.addAll(data.data);
    }

    isLoading = false;
    isPaginating = false;
    setState(() {});
  }

  @override
  void initState() {
    getQuestion();
    config = categoryTileConfigs[widget.category.colorPalette]!;
    super.initState();
  }

  int currentQuestion = 1;

  onPageChange(int index) {
    setState(() {
      currentQuestion = index + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: customGradientBackgroundWithSvg(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  primaryBackButton(context: context),
                  Column(
                    children: [
                      Text(widget.category.title, style: heading()),
                      Text(
                        widget.category.subTitle,
                        style: bodyMedium(color: customDarkGray),
                      ),
                    ],
                  ),

                  hPad30,
                ],
              ),
            ),

            vPad20,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Question"),
                Text(" $currentQuestion of "),
                Text("${questionList.length}"),
                hPad15,
              ],
            ),
            vPad10,
            CarouselSlider(
              items: List.generate(
                questionList.length,
                (i) => CustomQuestionTile(
                  index: i,
                  question: questionList[i],
                  bg: config!.backgroundColor,
                  bgImage: config!.backgroundImage,
                ),
              ),
              options: CarouselOptions(
                aspectRatio: 1,
                height: 400,
                viewportFraction: .95,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  onPageChange(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

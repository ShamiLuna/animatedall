import 'package:flutter/material.dart';
// import 'package:flutter_samples/app_clone/credit_cards_concept/credit_card.dart';
// import 'package:flutter_samples/app_clone/credit_cards_concept/credit_cards_concept_detail_page.dart';
import 'credit_card.dart';
import 'credit_card_widget.dart';
import 'credit_cards_concept_detail_page.dart';

//ignore: must_be_immutable
class CreditCardConceptPage extends StatelessWidget {
  final pageNotifier = ValueNotifier(0);
  int _lastPage = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const padding = EdgeInsets.all(18.0);
    return Theme(
      data: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bank Cards',

                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Balance',

                  ),
                  const SizedBox(height: 3),
                  ValueListenableBuilder<int>(
                      valueListenable: pageNotifier,
                      builder: (context, snapshot, _) {
                        final currentCard = creditCards[snapshot];
                        final lastCard = creditCards[_lastPage];
                        return TweenAnimationBuilder<double>(
                          tween: Tween<double>(
                            begin: lastCard.amount,
                            end: currentCard.amount,
                          ),
                          duration: const Duration(milliseconds: 500),
                          builder: (_, value, ___) => Text(
                            value.toStringAsFixed(2),

                          ),
                        );
                      }),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                onPageChanged: (page) {
                  _lastPage = pageNotifier.value;
                  pageNotifier.value = page;
                },
                controller: PageController(
                  viewportFraction: 0.7,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: creditCards.length,
                itemBuilder: (_, index) => Align(
                  child: Transform.translate(
                    offset: Offset(-30.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: CreditCardWidget(
                        onTap: () {
                          final page = CreditCardsConceptDetailPage(
                            card: creditCards[index],
                          );
                          Navigator.of(context).push(
                            PageRouteBuilder<Null>(
                              pageBuilder: (BuildContext context,
                                  Animation<double> animation, _) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: page,
                                );
                              },
                              transitionDuration: Duration(milliseconds: 900),
                            ),
                          );
                        },
                        card: creditCards[index],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'champion_detail_page.dart';
import 'champion_model.dart';

class ChampionCard extends StatefulWidget {
  final Champion champion;

  const ChampionCard(this.champion, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _ChampionCardState createState() => _ChampionCardState(champion);
}

class _ChampionCardState extends State<ChampionCard> {
  Champion champion;
  String? renderUrl;
  final GlobalKey<_ChampionCardState> _key = GlobalKey<_ChampionCardState>();

  _ChampionCardState(this.champion);

  @override
  void initState() {
    super.initState();
    renderChampionPic();
  }

  @override
  void didUpdateWidget(covariant ChampionCard oldWidget) {
    if (widget.champion.rating != oldWidget.champion.rating) {
      // Update UI when rating changes
      _key.currentState?.reload();
    }
    super.didUpdateWidget(oldWidget);
  }

  void reload() {
    // Reload the widget
    setState(() {});
  }

  Widget get championImage {
    var championAvatar = Hero(
      tag: champion,
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(renderUrl ?? ''),
          ),
        ),
      ),
    );

    var placeholder = Container(
      width: 100.0,
      height: 100.0,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.black54,
            Colors.black,
            Color.fromARGB(255, 84, 110, 122),
          ],
        ),
      ),
      alignment: Alignment.center,
      child: const Text(
        'CHAMP',
        textAlign: TextAlign.center,
      ),
    );

    var crossFade = AnimatedCrossFade(
      firstChild: placeholder,
      secondChild: championAvatar,
      crossFadeState: renderUrl == null
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 1000),
    );

    return crossFade;
  }

  void renderChampionPic() async {
    await champion.getImageUrl();
    if (mounted) {
      setState(() {
        renderUrl = champion.imageUrl;
      });
    }
  }

  Widget get championCard {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      color: const Color.fromRGBO(1, 10, 19, 100),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(50, 8, 8, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              widget.champion.name,
              style: const TextStyle(color: Colors.white, fontSize: 27.0),
            ),
            Text(
              '${widget.champion.title}',
              style: const TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            Row(
              children: <Widget>[
                Text(
                  '${widget.champion.partype}',
                  style: const TextStyle(color: Colors.white, fontSize: 18.0),
                ),
                const SizedBox(width: 10),
                if (widget.champion.tags.isNotEmpty)
                  Text(
                    widget.champion.tags.join(', '),
                    style: const TextStyle(color: Colors.grey, fontSize: 18.0),
                  ),
              ],
            ),
            Row(
              children: <Widget>[
                const Icon(Icons.star,
                    color: Color.fromRGBO(200, 155, 60, 100)),
                Text(
                  ': ${widget.champion.rating}/10',
                  style: const TextStyle(
                    color: Color.fromRGBO(200, 155, 60, 100),
                    fontSize: 17.0,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> showChampionDetailPage() async {
    // Use `await` to get the result (updated rating) when returning from ChampionDetailPage
    final updatedRating = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChampionDetailPage(champion),
      ),
    );

    // Update the rating in ChampionCard if it has changed
    if (updatedRating != null) {
      setState(() {
        champion.rating = updatedRating;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showChampionDetailPage(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            championImage,
            Expanded(
              child: championCard,
            ),
          ],
        ),
      ),
    );
  }
}

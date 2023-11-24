import 'package:flutter/material.dart';
import 'champion_model.dart';
import 'dart:async';

class ChampionDetailPage extends StatefulWidget {
  final Champion champion;
  const ChampionDetailPage(this.champion, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChampionDetailPageState createState() => _ChampionDetailPageState();
}

class _ChampionDetailPageState extends State<ChampionDetailPage> {
  final double championAvarterSize = 150.0;
  late double _sliderValue;

  @override
  void initState() {
    super.initState();
    _sliderValue = widget.champion.rating!.toDouble();
  }

  Widget get addYourRating {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Slider(
                  activeColor: Colors.white,
                  min: 0.0,
                  max: 10.0,
                  value: _sliderValue,
                  onChanged: (newRating) {
                    setState(() {
                      _sliderValue = newRating;
                    });
                  },
                  divisions: 10, // Number of intervals, since your max is 10
                ),
              ),
              Container(
                  width: 50.0,
                  alignment: Alignment.center,
                  child: Text(
                    '${_sliderValue.toInt()}',
                    style: const TextStyle(
                        color: Color.fromRGBO(200, 155, 60, 100),
                        fontSize: 25.0),
                  )),
            ],
          ),
        ),
        submitRatingButton,
        const SizedBox(height: 20.0),
      ],
    );
  }

  void updateRating() {
    if (_sliderValue < 5) {
      _ratingErrorDialog();
    } else {
      setState(() {
        widget.champion.rating = _sliderValue.toInt();
      });
    }
  }

  Future<void> _ratingErrorDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error!'),
            content: const Text("Come on! They're good!"),
            actions: <Widget>[
              TextButton(
                child: const Text('Try Again'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  Widget get submitRatingButton {
    return ElevatedButton(
      onPressed: () => updateRating(),
      child: const Text('Submit'),
    );
  }

  Widget get championImage {
    return Hero(
      tag: widget.champion,
      child: Container(
        height: championAvarterSize,
        width: championAvarterSize,
        constraints: const BoxConstraints(),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                  offset: Offset(1.0, 2.0),
                  blurRadius: 2.0,
                  spreadRadius: -1.0,
                  color: Color(0x33000000)),
              BoxShadow(
                  offset: Offset(2.0, 1.0),
                  blurRadius: 3.0,
                  spreadRadius: 0.0,
                  color: Color(0x24000000)),
              BoxShadow(
                  offset: Offset(3.0, 1.0),
                  blurRadius: 4.0,
                  spreadRadius: 2.0,
                  color: Color(0x1f000000))
            ],
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.champion.imageUrl ?? ""))),
      ),
    );
  }

  Widget get rating {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(
          Icons.star,
          size: 40.0,
          color: Color.fromRGBO(200, 155, 60, 100),
        ),
        Text('${widget.champion.rating}/10',
            style: const TextStyle(
                color: Color.fromRGBO(200, 155, 60, 100), fontSize: 30.0))
      ],
    );
  }

  Widget get championProfile {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(10, 50, 60, 100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          championImage,
          Text(widget.champion.name,
              style: const TextStyle(
                  color: Color.fromRGBO(250, 250, 250, 1), fontSize: 40.0)),

          Text('${widget.champion.title}',
              style: const TextStyle(color: Colors.white)),

          Text(
            'Ressource: ${widget.champion.partype}',
            style: const TextStyle(color: Colors.grey, fontSize: 10.0),
          ),
          const SizedBox(
              width: 10), // Add some spacing between partype and tags
          // Display tags
          if (widget.champion.tags.isNotEmpty)
            Text(
              widget.champion.tags.join(', '),
              style: const TextStyle(color: Colors.grey, fontSize: 10.0),
            ),
          Padding(
            padding: const EdgeInsets.only(
                left: 40.0, right: 40, top: 20, bottom: 20),
            child: Text(
              '${widget.champion.lore}',
              style: const TextStyle(color: Colors.grey, fontSize: 20.0),
            ),
          ),
          const Text(
            'Habilities',
            style: TextStyle(
                color: Color.fromRGBO(200, 155, 60, 1), fontSize: 30.0),
          ),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'Q: ${widget.champion.spellNames[0]}',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(35.0),
                      child: Image.network(
                        '${widget.champion.qhabilityimg}',
                        width: 80,
                        height: 80,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 250,
                      child: Text(
                        '${widget.champion.qdesc}',
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'W: ${widget.champion.spellNames[1]}',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(35.0),
                      child: Image.network(
                        '${widget.champion.whabilityimg}',
                        width: 80,
                        height: 80,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 250,
                      child: Text(
                        '${widget.champion.wdesc}',
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'E: ${widget.champion.spellNames[2]}',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(35.0),
                      child: Image.network(
                        '${widget.champion.ehabilityimg}',
                        width: 80,
                        height: 80,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 250,
                      child: Text(
                        '${widget.champion.edesc}',
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'R: ${widget.champion.spellNames[3]}',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(35.0),
                      child: Image.network(
                        '${widget.champion.rhabilityimg}',
                        width: 80,
                        height: 80,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 250,
                      child: Text(
                        '${widget.champion.rdesc}',
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 100),

          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              '${widget.champion.fullart}',
              width: 1000, // Set the width as per your requirement
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
            ),
            child: rating,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(10, 50, 60, 100),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(10, 20, 40, 100),
        title: Text('Meet ${widget.champion.name}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(widget.champion.rating);
          },
        ),
      ),
      body: ListView(
        children: <Widget>[championProfile, addYourRating],
      ),
    );
  }
}

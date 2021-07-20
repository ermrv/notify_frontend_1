import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final Color itemColor;
  final List<CustomBottomNavigationItem> children;
  final Function(int) onChange;
  final int currentIndex;

  CustomBottomNavigationBar(
      {@required this.itemColor,
      this.currentIndex = 0,
      @required this.children,
      this.onChange});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  void _changeIndex(int index) {
    if (widget.onChange != null) {
      widget.onChange(index);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.children.map((item) {
          String imageUrl = item.imageUrl;
          var color = item.color ?? widget.itemColor;
          var icon = item.icon;
          var label = item.label;
          var suffix = item.suffix;
          int index = widget.children.indexOf(item);
          return GestureDetector(
            onTap: () {
              _changeIndex(index);
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              width: widget.currentIndex == index
                  ? MediaQuery.of(context).size.width / widget.children.length +
                      20
                  : 50,
              padding: EdgeInsets.only(left: 10, right: 10),
              margin: EdgeInsets.only(top: 10, bottom: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: widget.currentIndex == index
                      ? color.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Stack(
                    children: [
                      imageUrl==null?
                      Icon(
                        icon,
                        size: 25,
                        color: widget.currentIndex == index
                            ? color.withOpacity(1)
                            : color.withOpacity(0.5),
                      ):Container(
                        padding: EdgeInsets.all(1.0),
                        height: 28.0,
                        width: 28.0,

                        decoration: BoxDecoration(shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [Colors.purple[900],Colors.deepOrange[900]])),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: CachedNetworkImage(imageUrl:imageUrl,fit: BoxFit.cover,))),
                      suffix == null
                          ? Container(
                              height: 0,
                              width: 0,
                            )
                          : Positioned(right: 0, child: suffix)
                    ],
                  ),
                  widget.currentIndex == index
                      ? Expanded(
                          flex: 2,
                          child: Text(
                            label ?? '',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: widget.currentIndex == index
                                    ? color
                                    : color.withOpacity(0.5),
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class CustomBottomNavigationItem {
  final imageUrl;
  final IconData icon;
  final Widget suffix;
  final String label;
  final Color color;

  CustomBottomNavigationItem(
      {this.imageUrl,
      this.icon,
      this.suffix,
      @required this.label,
      this.color});
}

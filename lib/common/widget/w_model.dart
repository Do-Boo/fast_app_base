import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/util/mysql/mysql_query.dart';
import 'package:fast_app_base/common/util/provider_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoundButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const RoundButton({super.key, required this.icon, required this.onPressed});

  @override
  State<RoundButton> createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.4),
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        border: Border.all(
          color: Vx.gray200,
          width: 1,
        ),
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(42),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => widget.onPressed(),
            child: Icon(widget.icon, color: const Color.fromARGB(255, 82, 88, 81), size: 42 * 0.6),
          ),
        ),
      ),
    );
  }
}

class SearchButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const SearchButton({super.key, required this.icon, required this.onPressed});

  @override
  State<SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
  final _controller = TextEditingController();
  bool _test = false;
  final _focusNode = FocusNode();

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: const EdgeInsets.only(right: 8.4),
      width: _test ? 210 : 42,
      height: 42,
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        border: Border.all(
          color: Vx.gray200,
          width: 1,
        ),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(42),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (_test)
            Flexible(
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                  hintText: "Search Text",
                  contentPadding: const EdgeInsets.only(left: 16),
                  suffixIcon: _controller.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close, size: 18),
                          onPressed: () => setState(() => _controller.clear()),
                        )
                      : null,
                ),
                onSubmitted: (e) {
                  Provider.of<SearchTextProvider>(context, listen: false).setSearchText(_controller.text);
                  Provider.of<SearchResultProvider>(context, listen: false).setSearchResult(searchList(_controller.text, DateTime.now()));
                },
              ),
            ),
          ClipRRect(
            borderRadius: BorderRadius.circular(42),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () async {
                  widget.onPressed();
                  setState(() => _test = !_test || _controller.text != "");
                  _test ? _focusNode.requestFocus() : _focusNode.unfocus();
                  if (_controller.text == "") return;
                  Provider.of<SearchTextProvider>(context, listen: false).setSearchText(_controller.text);
                  Provider.of<SearchResultProvider>(context, listen: false).setSearchResult(searchList(_controller.text, DateTime.now()));
                },
                child: Icon(widget.icon, color: const Color.fromARGB(255, 82, 88, 81), size: 42 * 0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

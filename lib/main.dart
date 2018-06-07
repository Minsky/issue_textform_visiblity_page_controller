// Original source for page controller setup: https://gist.github.com/collinjackson/4fddbfa2830ea3ac033e34622f278824
// Original source for EnsurVisibleWhenFocus: https://www.didierboelens.com/2018/04/hint-4-ensure-a-textfield-or-textformfield-is-visible-in-the-viewport-when-has-the-focus/)

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:viewportinpagecontroller/ensure_visible_when_focus.dart';
// import 'package:viewportinpagecontroller/ensurevisible_with_builder/visibleformpage_with_builder.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new TestPageviewController(),
//       home: new VisibleFormPageWithBuilder(),
    );
  }
}

class TestPageviewController extends StatefulWidget {
  @override
  State createState() => new TestPageviewControllerState();
}

class TestPageviewControllerState extends State<TestPageviewController> {
  final _controller = new PageController();

  static const _kDuration = const Duration(milliseconds: 300);

  static const _kCurve = Curves.ease;

  final _kArrowColor = Colors.black.withOpacity(0.8);

  static final FocusNode focusNode = new FocusNode();

  final List<Widget> _pages = <Widget>[
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: new VisibleFormPage(focusNode),
    ),
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child:
          new FlutterLogo(style: FlutterLogoStyle.stacked, colors: Colors.red),
    ),
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: new FlutterLogo(
          style: FlutterLogoStyle.horizontal, colors: Colors.green),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("PageViewController AppBar"),
      ),
      body: new IconTheme(
        data: new IconThemeData(color: _kArrowColor),
        child: new Stack(
          children: <Widget>[
            new PageView.builder(
              physics: new AlwaysScrollableScrollPhysics(),
              controller: _controller,
              itemBuilder: (BuildContext context, int index) {
                return _pages[index % _pages.length];
              },
            ),
            new Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: new Container(
                color: Colors.grey[800].withOpacity(0.5),
                padding: const EdgeInsets.all(20.0),
                child: new Center(
                  child: new DotsIndicator(
                    controller: _controller,
                    itemCount: _pages.length,
                    onPageSelected: (int page) {
                      _controller.animateToPage(
                        page,
                        duration: _kDuration,
                        curve: _kCurve,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VisibleFormPage extends StatefulWidget {
  FocusNode _focusNode;

  VisibleFormPage(this._focusNode);

  @override
  _VisibleFormPageState createState() => new _VisibleFormPageState(_focusNode);
}

class _VisibleFormPageState extends State<VisibleFormPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  FocusNode _focusNodeFirstName = new FocusNode();
  FocusNode _focusNodeLastName = new FocusNode();
  FocusNode _focusNodeDescription = new FocusNode();

  _VisibleFormPageState(this._focusNodeFirstName);

  static final TextEditingController _firstNameController =
      new TextEditingController();
  static final TextEditingController _lastNameController =
      new TextEditingController();
  static final TextEditingController _descriptionController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
        top: false,
        bottom: false,
        child: new Form(
          key: _formKey,
          child: new SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                /* -- Something large -- */
                Container(
                  width: double.infinity,
                  height: 150.0,
                  color: Colors.red,
                ),

                /* -- First Name -- */
                new EnsureVisibleWhenFocused(
                  focusNode: _focusNodeFirstName,
                  child: new TextFormField(
                    decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      filled: true,
                      icon: const Icon(Icons.person),
                      hintText: 'Enter your first name',
                      labelText: 'First name *',
                    ),
                    onSaved: (String value) {
                      //TODO
                    },
                    controller: _firstNameController,
                    focusNode: _focusNodeFirstName,
                  ),
                ),
                const SizedBox(height: 24.0),

                /* -- Last Name -- */
                new EnsureVisibleWhenFocused(
                  focusNode: _focusNodeLastName,
                  child: new TextFormField(
                    decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      filled: true,
                      icon: const Icon(Icons.person),
                      hintText: 'Enter your last name',
                      labelText: 'Last name *',
                    ),
                    onSaved: (String value) {
                      //TODO
                    },
                    controller: _lastNameController,
                    focusNode: _focusNodeLastName,
                  ),
                ),
                const SizedBox(height: 24.0),

                /* -- Some other fields -- */
                new Container(
                  width: double.infinity,
                  height: 250.0,
                  color: Colors.blue,
                ),

                /* -- Description -- */
                new EnsureVisibleWhenFocused(
                  focusNode: _focusNodeDescription,
                  child: new TextFormField(
                    decoration: const InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Tell us about yourself',
                      labelText: 'Describe yourself',
                    ),
                    onSaved: (String value) {
                      //TODO
                    },
                    maxLines: 5,
                    controller: _descriptionController,
                    focusNode: _focusNodeDescription,
                  ),
                ),
                const SizedBox(height: 24.0),

                /* -- Save Button -- */
                new Center(
                  child: new RaisedButton(
                    child: const Text('Save'),
                    onPressed: () {
                      //TODO
                    },
                  ),
                ),
                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      );
  }
}

/// An indicator showing the currently selected page of a PageController
class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.white,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  static const double _kDotSize = 8.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Material(
          color: color,
          type: MaterialType.circle,
          child: new Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:viewportinpagecontroller/ensurevisible_with_builder/ensure_visible.dart';


class VisibleFormPageWithBuilder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _VisibleFormPageState();
}

class _VisibleFormPageState extends State<VisibleFormPageWithBuilder> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  FocusNode _focusNodeFirstName = new FocusNode();
  FocusNode _focusNodeLastName = new FocusNode();
  FocusNode _focusNodeDescription = new FocusNode();

  _VisibleFormPageState();

  static final TextEditingController _firstNameController =
      new TextEditingController();
  static final TextEditingController _lastNameController =
      new TextEditingController();
  static final TextEditingController _descriptionController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('My Test Page'),
      ),
      body: new SafeArea(
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
                new EnsureVisible(
                    builder: (context, _focusNode) => new TextFormField(
                          focusNode: _focusNodeFirstName,
                          controller: _firstNameController,
                          decoration: const InputDecoration(
                            filled: true,
                            border: const UnderlineInputBorder(),
                            hintText: 'Enter your first name',
                            icon: const Icon(Icons.person),
                            labelText: 'First name *',
                          ),
                        )),
                const SizedBox(height: 24.0),

//                /* -- Last Name -- */
                new EnsureVisible(
                  builder: (context, _focusNode) => new TextFormField(
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
                new EnsureVisible(
                  builder: (context, _focusNode) => new TextFormField(
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
      ),
    );
  }
}

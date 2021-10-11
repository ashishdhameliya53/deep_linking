import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Uri? _initialUri;

class _HomeScreenState extends State<HomeScreen> {
  Future<void> initUniLinks() async {
    try {
      final uri = await getInitialUri();
      if (uri == null) {
        print('no initial uri');
      } else {
        print('got initial uri: $uri');
        print('data --> ${uri.data}');
        print('host --> ${uri.host}');
        print('parameters --> ${uri.queryParameters}');
        print('parameters all --> ${uri.queryParametersAll}');
        print('authority --> ${uri.authority}');
      }
      if (!mounted) return;
      setState(() => _initialUri = uri);
    } on PlatformException {
      print('falied to get initial uri');
    } on FormatException catch (err) {
      if (!mounted) return;
      print('malformed initial uri : $err');
    }
  }

  @override
  void initState() {
    super.initState();
    initUniLinks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('deep-Linking'),
      ),
      body: Center(
        child: _initialUri != null
            ? Text('got initial uri: $_initialUri')
            : Text('no initial uri'),
      ),
    );
  }
}

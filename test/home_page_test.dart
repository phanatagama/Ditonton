import 'package:about/about.dart';
import 'package:core/utils/ssl_pinning.dart';
import 'package:ditonton/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:movies/movies.dart';
import 'package:search/presentation/pages/search_page.dart';

Future<void> openDrawer(WidgetTester tester) async{
    // Build app and trigger a frame
      await tester.pumpWidget(MyApp());
      
      // open a drawer
      final ScaffoldState state = tester.firstState(find.byType(Scaffold));
      state.openDrawer();
      await tester.pump();
}

void main(){

  
  group("Home page Widget Test", (){
    setUpAll(() async {
      await SSLPinning.init();
      di.init();
    },);
    
    testWidgets("Testing if movie page shows up", (WidgetTester tester) async {
      // Build app and trigger a frame
      await tester.pumpWidget(MyApp());

      // verify thas movie page show
      expect(find.byType(HomeMoviePage), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text("Ditonton"), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets("Testing open drawer", (WidgetTester tester) async {
      await openDrawer(tester);

      // verify widget in drawer
      expect(find.byType(Drawer), findsOneWidget);
      expect(find.byType(UserAccountsDrawerHeader), findsOneWidget);
      expect(find.byType(ListTile), findsNWidgets(5));
      expect(find.byType(Text), findsNWidgets(16));
      expect(find.text("Movies"), findsOneWidget);
      expect(find.text("TV Series"), findsOneWidget);
      expect(find.text("Watchlist M"), findsOneWidget);
      expect(find.text("Watchlist TV"), findsOneWidget);
      expect(find.text("About"), findsOneWidget);
    });

    testWidgets("Testing open search page", (WidgetTester tester) async {
      // Build app and trigger a frame
      await tester.pumpWidget(MyApp());

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      expect(find.byType(SearchPage), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(3));
      expect(find.text("Search Movie"), findsOneWidget);
      expect(find.byType(MovieSearch), findsOneWidget);
      expect(find.text("Search title"), findsOneWidget);
      expect(find.byType(SizedBox), findsWidgets);
      expect(find.text("Search Result"), findsOneWidget);
      expect(find.byType(Expanded), findsOneWidget);
    });
  });


}

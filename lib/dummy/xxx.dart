import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../widgets/searchBar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    void performSearch() {
      String searchTerm = searchController.text;
      // Perform the search operation based on the searchTerm
      // Update the filtered records list or trigger the search logic here
    }

    void clearSearch() {
      searchController.clear();
      // Reset the search operation, show all records, or update the filtered records list accordingly
    }
    return MaterialApp(
      title: 'Slidable Example',
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Container

              (
              width: 200,
              height: 200,
              child: Center(
                child: ListView(
                  children: [
                    Slidable(
                      // Specify a key if the Slidable is dismissible.
                      key: const ValueKey(0),

                      // The start action pane is the one at the left or the top side.
                      startActionPane: ActionPane(
                        // A motion is a widget used to control how the pane animates.
                        motion: const ScrollMotion(),

                        // A pane can dismiss the Slidable.
                        dismissible: DismissiblePane(onDismissed: () {}),

                        // All actions are defined in the children parameter.
                        children: const [
                          // A SlidableAction can have an icon and/or a label.
                          SlidableAction(
                            onPressed: doNothing,
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                          SlidableAction(
                            onPressed: doNothing,
                            backgroundColor: Color(0xFF21B7CA),
                            foregroundColor: Colors.white,
                            icon: Icons.share,
                            label: 'Share',
                          ),
                        ],
                      ),

                      // The end action pane is the one at the right or the bottom side.
                      endActionPane: const ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            // An action can be bigger than the others.
                            flex: 2,
                            onPressed: doNothing,
                            backgroundColor: Color(0xFF7BC043),
                            foregroundColor: Colors.white,
                            icon: Icons.archive,
                            label: 'Archive',
                          ),
                          SlidableAction(
                            onPressed: doNothing,
                            backgroundColor: Color(0xFF0392CF),
                            foregroundColor: Colors.white,
                            icon: Icons.save,
                            label: 'Save',
                          ),
                        ],
                      ),

                      // The child of the Slidable is what the user sees when the
                      // component is not dragged.
                      child: const ListTile(title: Text('Slide me')),
                    ),
                    Slidable(
                      // Specify a key if the Slidable is dismissible.
                      key: const ValueKey(1),

                      // The start action pane is the one at the left or the top side.
                      startActionPane: const ActionPane(
                        // A motion is a widget used to control how the pane animates.
                        motion: ScrollMotion(),

                        // All actions are defined in the children parameter.
                        children: [
                          // A SlidableAction can have an icon and/or a label.
                          SlidableAction(
                            onPressed: doNothing,
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                          SlidableAction(
                            onPressed: doNothing,
                            backgroundColor: Color(0xFF21B7CA),
                            foregroundColor: Colors.white,
                            icon: Icons.share,
                            label: 'Share',
                          ),
                        ],
                      ),

                      // The end action pane is the one at the right or the bottom side.
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        dismissible: DismissiblePane(onDismissed: () {}),
                        children: const [
                          SlidableAction(
                            // An action can be bigger than the others.
                            flex: 2,
                            onPressed: doNothing,
                            backgroundColor: Color(0xFF7BC043),
                            foregroundColor: Colors.white,
                            icon: Icons.archive,
                            label: 'Archive',
                          ),
                          SlidableAction(
                            onPressed: doNothing,
                            backgroundColor: Color(0xFF0392CF),
                            foregroundColor: Colors.white,
                            icon: Icons.save,
                            label: 'Save',
                          ),
                        ],
                      ),

                      // The child of the Slidable is what the user sees when the
                      // component is not dragged.
                      child: const ListTile(title: Text('Slide me')),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 200,
              height: 200,
              child: SearchBar(
                searchController: searchController,
                onSearch: performSearch,
                onClear: clearSearch,
              ),
            )
          ],
        ),
      ),
    );
  }
}

void doNothing(BuildContext context) {}

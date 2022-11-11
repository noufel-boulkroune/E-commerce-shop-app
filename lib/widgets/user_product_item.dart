import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '/providers/products_provider.dart';
import '/screens/edit_product_screen.dart';

class UserProductItems extends StatelessWidget {
  const UserProductItems(
      {super.key, required this.title, required this.imgUrl, required this.id});
  final String id;
  final String title;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    bool _wantToRemove = true;
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imgUrl),
      ),
      title: Text(title),
      trailing: Container(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditProductScreen.roteName, arguments: id);
                },
                icon: const Icon(Icons.edit)),
            IconButton(
                onPressed: () async {
                  await showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text('Removing items!'),
                            content:
                                Text('Do you realy want to remove this item?'),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                    _wantToRemove = false;
                                    return;
                                  },
                                  child: const Text("No")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                    _wantToRemove = true;
                                  },
                                  child: const Text("Yes"))
                            ]);
                      }).then((value) {
                    try {
                      if (_wantToRemove == true) {
                        Provider.of<ProductsProvider>(context, listen: false)
                            .removeProduct(id);
                      }
                    } catch (error) {
                      scaffold.showSnackBar(
                        const SnackBar(
                          content: Text("Deleting filed"),
                        ),
                      );
                    }
                  });
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ))
          ],
        ),
      ),
    );
  }
}

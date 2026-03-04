import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_9/itemState.dart';


class Item {
  final String title ;
  final String description ;
  bool isFavorite;

  Item ({
    required this.title,
    required this.description,
    required this.isFavorite,
  });
}
class CatalogScreen extends StatelessWidget {
  final List<Item>items=List.generate(8, (index)=>Item(
    title: "Item ${index +1}",
     description: "oписание элемента ${index + 1}",
      isFavorite: false,
      ));
      
        @override
       Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Каталог'), centerTitle: true),
      body: ListView.builder(
        
        padding: EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              leading: Icon(Icons.article),
              title: Text(items[index].title),
              subtitle: Text(items[index].description),
              onTap: () {
                
                print('Переход к: ${items[index].title}');  
          
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemState(item: items[index]),
                    
                    
                  ),
                  
                );
                
              },
            ),
          
          );
        },
      ),
      
    );
   
  }
}
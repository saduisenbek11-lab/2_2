import 'package:flutter/material.dart';
import 'Item.dart';

class ItemState extends StatefulWidget {
  final Item item;
  ItemState({required this.item});

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.item.title)),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.item.title, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(widget.item.description, style: TextStyle(fontSize: 18, color: Colors.grey[700])),
            SizedBox(height: 30),
            
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.item.isFavorite ? Colors.red : Colors.blue, 
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                icon: Icon(widget.item.isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.white),
                label: Text(
                  widget.item.isFavorite ? 'В избранном' : 'Добавить в избранное',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    widget.item.isFavorite = !widget.item.isFavorite;
                  });
                  print('Статус избранного для ${widget.item.title}: ${widget.item.isFavorite}');
                },
              ),
            ),
            SizedBox(height: 15),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Назад', style: TextStyle(color: Colors.indigo)),
            ),
          ],
        ),
      ),
    );
  }
}
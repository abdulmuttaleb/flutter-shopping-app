import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/products_grid.dart';

enum FilterOptions{
  Favorites,
  All
}

class ProductsOverviewScreen extends StatefulWidget {

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {

  var _showFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MyShop'),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (FilterOptions selectedValue)=>{
                setState((){
                  if(selectedValue == FilterOptions.Favorites){
                    _showFavorites = true;
                  }else if(selectedValue == FilterOptions.All){
                    _showFavorites = false;
                  }
                })
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                PopupMenuItem(child: Text('Only Favorites'), value: FilterOptions.Favorites,),
                PopupMenuItem(child: Text('Show All'), value: FilterOptions.All,)
              ],
            ),
            Consumer<Cart>(
              builder: (_, cartData, ch) =>
                  Badge(
                    child: ch,
                    value: cartData.itemCount.toString(),
                  ),
              child: IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },),
            )
          ],
        ),
        body: ProductsGrid(_showFavorites),
      drawer: AppDrawer(),
    );
  }
}


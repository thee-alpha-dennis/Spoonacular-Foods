import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:food_buddy/api/api_services.dart';
import 'package:food_buddy/constants/api_constants.dart';
import 'package:food_buddy/constants/app_colors.dart';
import 'package:food_buddy/database/collections/food_collection.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../../database/services/isar_db_service.dart';
import '../../state/cart.dart';
import '../../models/cart_item.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final ApiService _apiService = ApiService();
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    await _apiService.fetchFoodItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColor.primaryColor,
            floating: true,
            pinned: true,
            snap: false,
            elevation: 2,
            iconTheme: const IconThemeData(color: Colors.black),
            automaticallyImplyLeading: false,
            title: Container(
              padding: const EdgeInsets.only(
                  left: 15, right: 10, top: 10, bottom: 10),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(FlutterIcons.restaurant_mdi,
                              size: 35, color: AppColor.whiteColor)
                          .p(8),
                      Text(appName,
                          style: TextStyle(
                            color: AppColor.whiteColor,
                            fontSize: 18,
                            fontFamily: 'bold',
                          )),
                    ],
                  ),
                ],
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(54),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColor.whiteColor,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(0, 1),
                                blurRadius: 3)
                          ],
                        ),
                        child: const Row(children: [
                          Icon(Icons.search),
                          SizedBox(width: 5),
                          Text('Search food items')
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          FutureBuilder<List<dynamic>>(
            future: _apiService.fetchFoodItems(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return SliverFillRemaining(
                  child: Center(child: Text('Error: ${snapshot.error}')),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(child: Text('No food items found')),
                );
              } else {
                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return _buildFoodCard(snapshot.data![index]);
                    },
                    childCount: snapshot.data!.length,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFoodCard(Food foodItem) {
    final cartStore = Provider.of<CartStore>(context);
    final itemId = foodItem.id;
    final cartItem = CartItem(
      id: itemId,
      name: foodItem.title,
      photo: foodItem.image,
      price: foodItem.price,
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 1),
              blurRadius: 3)
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: FadeInImage(
              height: 120,
              width: double.infinity,
              image: NetworkImage(foodItem.image),
              placeholder: const AssetImage("assets/images/error.png"),
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                    height: 120,
                    width: double.infinity,
                    'assets/images/error.png',
                    fit: BoxFit.fitWidth);
              },
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(top: 15, bottom: 0, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    foodItem.title.toString(),
                    softWrap: false,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontFamily: 'bold', fontSize: 12),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      "$currencySymbol. "
                          .text
                          .base
                          .bold
                          .size(8)
                          .color(AppColor.greenColor)
                          .make(),
                      foodItem.price
                          .toString()
                          .text
                          .base
                          .bold
                          .size(15)
                          .color(AppColor.greenColor)
                          .make(),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Center(
                  child: Observer(
                    builder: (_) {
                      if (cartStore.cartItems.containsKey(itemId)) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => cartStore.decrementItem(itemId),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    color: AppColor.primaryColor,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Icon(Icons.remove,
                                    size: 13, color: AppColor.whiteColor),
                              ),
                            ),
                            Text(cartStore.cartItems[itemId]!.selectedQty
                                    .toString())
                                .p(5),
                            GestureDetector(
                              onTap: () => cartStore.incrementItem(itemId),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(30)),
                                child: const Icon(Icons.add,
                                    size: 13, color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Center(
                          child: GestureDetector(
                            onTap: () => cartStore.addItem(cartItem),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  color: AppColor.primaryColor,
                                  borderRadius: BorderRadius.circular(30)),
                              child:  Text('Add To Cart',
                                  style: TextStyle(
                                      color: AppColor.whiteColor,
                                      fontFamily: 'regular',
                                      fontSize: 13)),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

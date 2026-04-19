// model/Product.dart
class Product {
  int? productId;
  String? productName;
  String? categoryName;
  String? brandName;
  int? cost;
  int? price;
  String? made;
  String? description;
  String? warranty;
  String? rating;
  String? imageUrl;
  String? tagName;

  Product({
    this.productId,
    this.productName,
    this.categoryName,
    this.brandName,
    this.cost,
    this.price,
    this.made,
    this.description,
    this.warranty,
    this.rating,
    this.imageUrl,
    this.tagName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json["product_id"] as int?,
      productName: json["product_name"]?.toString(),
      categoryName: json["category_name"]?.toString(),
      brandName: json["brand_name"]?.toString(),
      cost: json["cost"] as int?,
      price: json["price"] as int?,
      made: json["made"]?.toString(),
      description: json["description"]?.toString(),
      warranty: json["warranty"]?.toString(),
      rating: json["rating"]?.toString(),
      imageUrl: json["image_url"]?.toString(),
      tagName: json["tag_name"]?.toString(),
    );
  }
}

// Model for the API response wrapper
class ProductResponse {
  String? status;
  List<Product>? result;

  ProductResponse({this.status, this.result});

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      status: json["status"]?.toString(),
      result: json["result"] != null
          ? (json["result"] as List)
              .map((item) => Product.fromJson(item))
              .toList()
          : [],
    );
  }
}
/* 
{
    "status": "success",
    "message": "Category shown successfully",
    "data": [
        {
            "name": "Boxing",
            "image_url": "https://res.cloudinary.com/drehgbauv/image/upload/v1775359160/category_images/hgxicvgapojuq7airtjp.png"
        },
        {
            "name": "Boxin",
            "image_url": "https://res.cloudinary.com/drehgbauv/image/upload/v1775402407/category_images/rhe9brpgqolx31yrlm9f.png"
        },
        {
            "name": "Badminton ",
            "image_url": "https://res.cloudinary.com/drehgbauv/image/upload/v1775403232/category_images/s5n3ah7sita8wqc5ntlu.jpg"
        },
        {
            "name": "Box",
            "image_url": "https://res.cloudinary.com/drehgbauv/image/upload/v1775403272/category_images/mnskfwzp1znrfogoszkf.png"
        },
        {
            "name": "Badminton",
            "image_url": "https://res.cloudinary.com/drehgbauv/image/upload/v1775403698/category_images/quqj4qxorqcc2xng8nms.jpg"
        },
        {
            "name": "This is testing",
            "image_url": "https://res.cloudinary.com/drehgbauv/image/upload/v1775404138/category_images/iydohsmsv3btrgawiw7z.jpg"
        },
        {
            "name": "Martial Art",
            "image_url": "https://res.cloudinary.com/drehgbauv/image/upload/v1775405111/category_images/e9jocbiob589f8i9vplg.jpg"
        },
        {
            "name": " Testing1234",
            "image_url": "https://res.cloudinary.com/drehgbauv/image/upload/v1775407677/category_images/tkukcnjgszls3iziux8u.jpg"
        },
        {
            "name": "Testing123",
            "image_url": "https://res.cloudinary.com/drehgbauv/image/upload/v1775407735/category_images/uditpkyacdd5zo6xqwgw.jpg"
        },
        {
            "name": "tsdsdfsdafdsfsdfdsf",
            "image_url": "https://res.cloudinary.com/drehgbauv/image/upload/v1775408021/category_images/cg5dup2s7jwhublstkhk.jpg"
        },
        {
            "name": "manual testing",
            "image_url": "https://res.cloudinary.com/drehgbauv/image/upload/v1775408081/category_images/xyt17rrvjqjolraywxxh.jpg"
        },
        {
            "name": "sdalkfjsdafsddsafsda",
            "image_url": "https://res.cloudinary.com/drehgbauv/image/upload/v1775454489/category_images/liyi8v7o9ew4o6h5yzfr.jpg"
        },
        {
            "name": "testyu",
            "image_url": "https://res.cloudinary.com/drehgbauv/image/upload/v1775454565/category_images/jvymtj6kkj9pdwxkntew.jpg"
        },
        {
            "name": "fdasfdsafdsa",
            "image_url": "https://res.cloudinary.com/drehgbauv/image/upload/v1775476256/category_images/l4ku8w7llxflvwbaxo3c.jpg"
        },
        {
            "name": "Tesing",
            "image_url": "https://res.cloudinary.com/drehgbauv/image/upload/v1775476472/category_images/xiuunpw3kjasn9jkoejt.png"
        },
        {
            "name": "Tennis",
            "image_url": "https://res.cloudinary.com/drehgbauv/image/upload/v1775491872/category_images/wlq1zuzm0lbsvr9evxal.png"
        },
        {
            "name": "Hello worlddd",
            "image_url": "https://res.cloudinary.com/drehgbauv/image/upload/v1775575741/category_images/eqokgcvi1r5arms6lefu.jpg"
        },
        {
            "name": "SSSSSSSSSSS",
            "image_url": "https://res.cloudinary.com/drehgbauv/image/upload/v1775617602/category_images/f7pmluegsah53ivdfxus.jpg"
        },
        {
            "name": "IIIIIIIIIIIIvvvvvv",
            "image_url": "https://res.cloudinary.com/drehgbauv/image/upload/v1775617668/category_images/wpcfa63tadmbud5ftqng.jpg"
        },
        {
            "name": "BARNar",
            "image_url": "https://res.cloudinary.com/drehgbauv/image/upload/v1775618136/category_images/qczwbylbxoo0yb0w7ldf.jpg"
        },
        {
            "name": "Kammmaieazaae",
            "image_url": "https://res.cloudinary.com/drehgbauv/image/upload/v1775627711/category_images/uqkkefvsvvopjfatoer0.jpg"
        },
        {
            "name": "Tesing 3333",
            "image_url": "https://res.cloudinary.com/drehgbauv/image/upload/v1775627933/category_images/eqcea9kuphqtwp8c1si3.jpg"
        },
        {
            "name": "Testing 4",
            "image_url": "https://res.cloudinary.com/drehgbauv/image/upload/v1775628182/category_images/unbmvy8qdhnoifcdn5zh.jpg"
        },
        {
            "name": "tfsdfsdafsdafdsfd c",
            "image_url": "https://res.cloudinary.com/drehgbauv/image/upload/v1775655805/category_images/rwyqtstmflo4cx42ilsx.jpg"
        }
    ]
}*/
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lomaysowdamuckup/provider/categories_provider.dart';
import 'package:lomaysowdamuckup/provider/products_by_category_provider.dart';
import 'package:lomaysowdamuckup/provider/provider.dart';
import 'package:lomaysowdamuckup/provider/session.dart';
import 'package:lomaysowdamuckup/screens/category/category_screen.dart';
import 'package:lomaysowdamuckup/screens/category_result/category_result.dart';
import 'package:lomaysowdamuckup/screens/home/home_screen.dart';
import 'package:lomaysowdamuckup/screens/login/login_screen.dart';
import 'package:lomaysowdamuckup/screens/product_detail/productDetail.dart';
import 'package:lomaysowdamuckup/screens/profile/profile.dart';
import 'package:lomaysowdamuckup/screens/profile/profile_pages/anketam/anketam.dart';
import 'package:lomaysowdamuckup/screens/profile/profile_pages/my_brands/add_brand.dart';
import 'package:lomaysowdamuckup/screens/profile/profile_pages/my_brands/brands.dart';
import 'package:lomaysowdamuckup/screens/profile/profile_pages/my_brands/edit_brand.dart';
import 'package:lomaysowdamuckup/screens/profile/profile_pages/my_orders/orders.dart';
import 'package:lomaysowdamuckup/screens/profile/profile_pages/my_products/my_product.dart';
import 'package:lomaysowdamuckup/screens/profile/profile_pages/my_products/my_product_edit.dart';
import 'package:lomaysowdamuckup/screens/profile/profile_pages/my_products/products.dart';
import 'package:lomaysowdamuckup/screens/provider/provider.dart';
import 'package:lomaysowdamuckup/screens/register/register.dart';
import 'package:lomaysowdamuckup/theme.dart';
import 'package:lomaysowdamuckup/utils.dart';
import 'package:provider/provider.dart';
import 'functions/provider.dart';
import 'generated/l10n.dart';
import 'screens/add_product/add_product_screen.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:lomaysowdamuckup/model/product.dart';
import 'package:lomaysowdamuckup/model/user.dart';
import 'package:lomaysowdamuckup/networking/app_exception.dart';
import 'package:lomaysowdamuckup/networking/app_url.dart';
import 'package:lomaysowdamuckup/model/brand.dart';
import 'package:path/path.dart';
import 'package:lomaysowdamuckup/model/order.dart';
import 'package:dio/dio.dart' as dioChina;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterSecureStorage _storage = FlutterSecureStorage();
  UserPreferences userPreferences = UserPreferences();
  String token;
  User _user;
  try {
    await _storage.read(key: "token").then((value) => token = value);
  } catch (e) {
    debugPrint(e.toString());
  }
  try {
    await userPreferences.getUser(token).then((value) => _user = value);
  } catch (e) {
    debugPrint(e.toString());
  }
  final Session session = Session(
      token: token,
      // user
      user: _user,
      // sign in
      signIn: ({
        @required final String email,
        @required final String password,
      }) async {
        assert(email != null);
        assert(password != null);
        // Contact the server to validate credentials and get token.
        final Map<String, dynamic> loginData = {
          'email': email,
          'password': password,
        };
        http.Response response = await http.post(
            "http://95.85.122.49/api/auth/login",
            body: loginData,
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
              'Accept': 'application/json',
            });
        switch (response.statusCode) {
          case 200:
            DateTime tokenTime = DateTime.now();
            final Map<String, dynamic> responseData =
                json.decode(response.body);
            // save token to storage
            String token = responseData['access_token'];
            await _storage.write(key: 'email', value: email);
            await _storage.write(key: 'password', value: password);
            await _storage.write(key: 'token', value: token);
            return [token, tokenTime];
          case 400:
            throw BadRequestException(response.body.toString());
          case 401:
          case 403:
            throw UnauthorisedException(response.body.toString());
          case 500:
          default:
            throw FetchDataException(
                'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
        }
      },
      // sign out
      signOut: () async {
        await Future.delayed(Duration(microseconds: 100));
        // Update the local storage.
        await _storage.write(key: "token", value: null);
        await userPreferences.removeUser();
      },
      // authenticated user
      authenticatedUser: ({
        @required final String token,
      }) async {
        // get authenticated user
        http.Response response = await http.post(
            "http://95.85.122.49/api/auth" + '/me',
            headers: <String, String>{
              // 'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': "Bearer $token"
            });
        switch (response.statusCode) {
          case 200:
            final Map<String, dynamic> responseData =
                json.decode(response.body);
            Map<String, dynamic> data = responseData['data'];
            User user = User.fromJson(data);
            userPreferences.saveUser(user);
            return user;
          case 400:
            throw BadRequestException(response.body.toString());
          case 401:
          case 403:
            throw UnauthorisedException(response.body.toString());
          case 500:

          default:
            throw FetchDataException(
                'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
        }
      },
      register: ({
        @required String url,
        @required Map<String, dynamic> data,
        @required Map<String, File> files,
      }) async {
        Map<String, dioChina.MultipartFile> fileMap = {};
        for (MapEntry fileEntry in files.entries) {
          File file = fileEntry.value;
          String filename = basename(file.path);
          fileMap[fileEntry.key] = dioChina.MultipartFile(
              file.openRead(), await file.length(),
              filename: filename);
        }
        data.addAll(fileMap);
        var formData = dioChina.FormData.fromMap(data);
        dioChina.Dio dio = new dioChina.Dio();
        dioChina.Response response = await dio.post(
          url,
          data: formData,
          options: dioChina.Options(
              contentType: 'multipart/form-data',
              followRedirects: false,
              validateStatus: (status) {
                return status < 500;
              }),
        );
        switch (response.statusCode) {
          case 200:
          case 201:
            print(response.statusCode);
            print(response);
            print('uploaded, registered');
            return true;
          case 400:
            print(response.statusCode);
            print(response);
            print('uploaded, registered');
            return true;
          case 401:
          case 403:
            print(response.statusCode);
            print(response);
            print('uploaded, registered');
            return true;
          case 500:
          default:
            throw FetchDataException(
                'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
        }
      },
      updateMe: ({
        @required int id,
        @required Map<String, String> data,
        Map<String, File> files,
      }) async {
        String kToken;
        await _storage.read(key: "token").then((value) => kToken = value);

        var request = http.MultipartRequest(
          'POST',
          Uri.parse(AppUrl.baseURL + "provider/$id/update"),
        );
        request.headers.addAll({
          'Authorization': 'Bearer $kToken',
          "Content-Type": "multipart/form-data",
          "Accept": "application/json",
        });
        request.fields.addAll(data);
        if (files != null) {
          String filename = files['image'].path.split('/').last;
          request.files.add(
            await http.MultipartFile.fromPath(
              'photo',
              filename,
            ),
          );
        }
        var response = await request.send();
        //
        print(data);
        print(response.reasonPhrase + ' errorrrrrr');
        print(response.headers["location"]);
        //
        switch (response.statusCode) {
          case 302:
          case 301:
            final getResponse = await http.get(response.headers["location"]);
            print('getResponse.statusCode:' + getResponse.body);
            return true;
          case 200:
          case 201:
          case 400:
          case 401:
          case 403:
            print(response.statusCode);
            print(response);
            print('uploaded, registered');
            return true;
          case 500:
          default:
            throw FetchDataException(
                'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
        }
      },
      getUserProducts: () async {
        String kToken;
        await _storage.read(key: "token").then((value) => kToken = value);
        http.Response response = await http
            .get(AppUrl.baseURL + 'my-products', headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept': 'application/json',
          'Authorization': "Bearer $kToken",
        });
        switch (response.statusCode) {
          case 200:
            final responseData = json.decode(response.body)['data'];
            if (responseData != null) {
              List<Product> myProducts = Product.listFromJson(responseData);
              return myProducts;
            }
            return null;
          case 400:
            throw BadRequestException(response.body.toString());
          case 401:
          case 403:
            throw UnauthorisedException(response.body.toString());
          case 500:
          default:
            throw FetchDataException(
                'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
        }
      },
      getUserBrands: () async {
        String kToken;
        await _storage.read(key: "token").then((value) => kToken = value);
        http.Response response = await http
            .get(AppUrl.baseURL + 'my-brands', headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept': 'application/json',
          'Authorization': "Bearer $kToken",
        });
        switch (response.statusCode) {
          case 200:
            final responseData = json.decode(response.body)['data'];
            if (responseData != null) {
              List<Brand> myBrands = Brand.listFromJson(responseData);
              return myBrands;
            }
            return null;
          case 400:
            throw BadRequestException(response.body.toString());
          case 401:
          case 403:
            throw UnauthorisedException(response.body.toString());
          case 500:
          default:
            throw FetchDataException(
                'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
        }
      },
      getUserOrders: () async {
        String kToken;
        await _storage.read(key: "token").then((value) => kToken = value);
        http.Response response = await http
            .get(AppUrl.baseURL + 'my-orders', headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept': 'application/json',
          'Authorization': "Bearer $kToken",
        });
        switch (response.statusCode) {
          case 200:
            final responseData = json.decode(response.body)['data'];
            if (responseData != null) {
              List<Order> myOrders = Order.listFromJson(responseData);
              return myOrders;
            }
            return null;
          case 400:
            throw BadRequestException(response.body.toString());
          case 401:
          case 403:
            throw UnauthorisedException(response.body.toString());
          case 500:

          default:
            throw FetchDataException(
                'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
        }
      },
      addProduct: ({
        @required Map<String, dynamic> data,
        @required Map<String, List<File>> files,
      }) async {
        // ... token ...
        String kToken;
        await _storage.read(key: "token").then((value) => kToken = value);
        print(kToken);
        // ....
        Map<String, List<dioChina.MultipartFile>> fileMap = {"images": []};
        List<File> list = files['images'];
        print(list);
        for (File file in list) {
          String filename = basename(file.path);
          print(file);
          fileMap['images'].add(dioChina.MultipartFile(
              file.openRead(), await file.length(),
              filename: filename));
        }
        print(fileMap);
        data.addAll(fileMap);
        print(data);
        var formData = dioChina.FormData.fromMap(data);
        dioChina.Dio dio = new dioChina.Dio();
        dioChina.Response response = await dio.post(
          AppUrl.baseURL + 'store/product',
          data: formData,
          options: dioChina.Options(
              headers: {
                'Authorization': "Bearer $kToken",
              },
              contentType: 'multipart/form-data',
              followRedirects: false,
              validateStatus: (status) {
                return status < 500;
              }),
        );
        switch (response.statusCode) {
          case 200:
          case 201:
            print(response.statusCode);
            print(response);
            print('uploaded, registered');
            return true;
          case 401:
          case 403:
          case 400:
            print(response.statusCode);
            print(response);
            throw Exception("${response.statusCode}");
          case 500:
          default:
            throw FetchDataException(
                'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
        }
      },
      updateProduct: ({
        @required int id,
        @required Map<String, dynamic> data,
      }) async {
        assert(data != null);
        String kToken;
        await _storage.read(key: "token").then((value) => kToken = value);
        var formData = dioChina.FormData.fromMap(data);
        dioChina.Dio dio = new dioChina.Dio();
        dioChina.Response response = await dio.post(
          AppUrl.baseURL + 'product/$id/update',
          data: formData,
          options: dioChina.Options(
              headers: {
                'Authorization': 'Bearer $kToken',
              },
              contentType: 'multipart/form-data',
              followRedirects: false,
              validateStatus: (status) {
                return status < 500;
              }),
        );
        switch (response.statusCode) {
          case 200:
          case 201:
            print(response.statusCode);
            print(response);
            print('uploaded, registered');
            return true;
          case 400:
            print(response.statusCode);
            print(response);
            print('uploaded, registered');
            return true;
          case 401:
          case 403:
            print(response.statusCode);
            print(response);
            print('uploaded, registered');
            return true;
          case 500:
          default:
            throw FetchDataException(
                'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
        }
      },
      updateProductAddImage: ({
        @required int id,
        @required Map<String, File> file,
      }) async {
        assert(file != null);
        String kToken;
        await _storage.read(key: "token").then((value) => kToken = value);
        Map<String, dioChina.MultipartFile> fileMap = {};
        File fayl = file[file.keys.first];
        String filename = basename(fayl.path);
        fileMap[file.keys.first] = dioChina.MultipartFile(
            fayl.openRead(), await fayl.length(),
            filename: filename);
        var formData = dioChina.FormData.fromMap(fileMap);
        dioChina.Dio dio = new dioChina.Dio();
        dioChina.Response response = await dio.post(
          AppUrl.baseURL + 'product/$id/add/image',
          data: formData,
          options: dioChina.Options(
              headers: {
                'Authorization': 'Bearer $kToken',
              },
              contentType: 'multipart/form-data',
              followRedirects: false,
              validateStatus: (status) {
                return status < 500;
              }),
        );
        switch (response.statusCode) {
          case 200:
          case 201:
            print(response.statusCode);
            print(response);
            print('uploaded, registered');
            return true;
          case 400:
            print(response.statusCode);
            print(response);
            print('uploaded, registered');
            return true;
          case 401:
          case 403:
            print(response.statusCode);
            print(response);
            print('uploaded, registered');
            return true;
          case 500:
          default:
            throw FetchDataException(
                'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
        }
      },
      updateProductDeleteImage: ({
        @required int id,
        @required int imgId,
      }) async {
        assert(id != null);
        assert(imgId != null);
      },
      deleteProduct: ({@required int id}) async {
        assert(id != null);
        String kToken;
        await _storage.read(key: "token").then((value) => kToken = value);
        print(id);
        http.Response response = await http.post(
          AppUrl.baseURL + 'product/$id/delete',
          headers: <String, String>{
            'Accept': 'application/json',
            'Authorization': "Bearer $kToken",
          },
        );
        switch (response.statusCode) {
          case 200:
          case 201:
          case 400:
          case 401:
          case 403:
            print(response.statusCode);
            print(response);
            print('uploaded, registered');
            return true;
          case 500:
          default:
            throw FetchDataException(
                'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
        }
      },
      addBrand: ({
        @required Map<String, dynamic> data,
        @required Map<String, File> files,
      }) async {
        // ... token ...
        String kToken;
        await _storage.read(key: "token").then((value) => kToken = value);
        print(kToken);
        Map<String, dioChina.MultipartFile> fileMap = {};
        for (MapEntry fileEntry in files.entries) {
          File file = fileEntry.value;
          String filename = basename(file.path);
          fileMap[fileEntry.key] = dioChina.MultipartFile(
              file.openRead(), await file.length(),
              filename: filename);
        }
        data.addAll(fileMap);
        var formData = dioChina.FormData.fromMap(data);
        dioChina.Dio dio = new dioChina.Dio();
        dioChina.Response response = await dio.post(
          AppUrl.baseURL + 'store/brand',
          data: formData,
          options: dioChina.Options(
              headers: {
                'Authorization': 'Bearer $kToken',
              },
              contentType: 'multipart/form-data',
              followRedirects: false,
              validateStatus: (status) {
                return status < 500;
              }),
        );
        switch (response.statusCode) {
          case 200:
          case 201:
            print(response.statusCode);
            print(response);
            print('uploaded, registered');
            return true;
          case 400:
            print(response.statusCode);
            print(response);
            print('uploaded, registered');
            return true;
          case 401:
          case 403:
            print(response.statusCode);
            print(response);
            print('uploaded, registered');
            return true;
          case 500:
          default:
            throw FetchDataException(
                'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
        }
      },
      editBrand: ({
        @required int id,
        @required Map<String, dynamic> data,
        Map<String, File> files,
      }) async {
        String kToken;
        await _storage.read(key: "token").then((value) => kToken = value);
        Map<String, dioChina.MultipartFile> fileMap = {};
        if (files != null) {
          for (MapEntry fileEntry in files.entries) {
            File file = fileEntry.value;
            String filename = basename(file.path);
            fileMap[fileEntry.key] = dioChina.MultipartFile(
                file.openRead(), await file.length(),
                filename: filename);
          }
          data.addAll(fileMap);
        }
        var formData = dioChina.FormData.fromMap(data);
        dioChina.Dio dio = new dioChina.Dio();
        dioChina.Response response = await dio.post(
          AppUrl.baseURL + 'update/brand/$id',
          data: formData,
          options: dioChina.Options(
              headers: {
                'Authorization': 'Bearer $kToken',
              },
              contentType: 'multipart/form-data',
              followRedirects: false,
              validateStatus: (status) {
                return status < 500;
              }),
        );
        switch (response.statusCode) {
          case 200:
          case 201:
            print(response.statusCode);
            print(response);
            print('uploaded, registered');
            return true;
          case 400:
            print(response.statusCode);
            print(response);
            print('uploaded, registered');
            return true;
          case 401:
          case 403:
            print(response.statusCode);
            print(response);
            print('uploaded, registered');
            return true;
          case 500:
          default:
            throw FetchDataException(
                'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
        }
      },
      deleteBrand: ({@required int id}) async {
        assert(id != null);
        String kToken;
        await _storage.read(key: "token").then((value) => kToken = value);
        http.Response response = await http.post(
            AppUrl.baseURL + 'delete/brand/$id',
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': "Bearer $kToken",
            });
        switch (response.statusCode) {
          case 200:
          case 201:
            print(response.statusCode);
            print(response);
            print('uploaded, registered');
            return true;
          case 400:
            print(response.statusCode);
            print(response);
            print('uploaded, registered');
            return true;
          case 401:
          case 403:
            print(response.statusCode);
            print(response);
            print('uploaded, registered');
            return true;
          case 500:
          default:
            throw FetchDataException(
                'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
        }
      });

  Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
  print(decodedToken);
  bool isTokenExpired = JwtDecoder.isExpired(token);
  print(isTokenExpired);
  if (isTokenExpired) {
    String email, password;
    try {
      await _storage.read(key: "email").then((value) => email = value);
      await _storage.read(key: "password").then((value) => password = value);
      session.signIn(email: email, password: password);
    } catch (e) {
      debugPrint(e);
    }
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CategoriesProvider()),
      ChangeNotifierProvider(create: (_) => CategoryProductsProvider()),
      ChangeNotifierProvider<Session>.value(value: session),
      ChangeNotifierProvider<MyProvider>.value(value: myProvider),
    ],
    child: LomaySowda(),
  ));
}

class LomaySowda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        initialRoute: '/',
        theme: theme(),
        routes: {
          '/': (_) => HomeScreen(),
          '/login': (_) => LoginScreen(),
          '/register': (_) => RegisterScreen(),
          '/product_detail': (_) => ProductDetailsScreen(),
          '/provider_products': (_) => ProviderGet(),
          '/categories': (_) => CategoryScreen(),
          '/category_result': (_) => CategoryResult(),
          '/profile': (_) => Profile(),
          '/anketam': (_) => Antekam(),
          // brand
          '/my_brands': (_) => UserBrands(),
          '/add_brand': (_) => AddBrandPage(),
          '/edit_brand': (_) => EditBrandPage(),
          // product
          '/my_products': (_) => UserProducts(),
          '/add_product': (_) => AddProductPage(),
          '/my_product': (_) => MyProductPage(),
          '/my_product_edit': (_) => MyProductEdit(),
          // orders
          '/my_orders': (_) => UserOrders(),
        });
  }
}

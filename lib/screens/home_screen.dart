import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:recipe_assistant/providers/app_provider.dart';
import 'package:recipe_assistant/screens/result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1; // 初期値を「ホーム」（中央）に設定

  // 画像選択ダイアログを表示するメソッド
  Future<void> _pickImage(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('カメラで撮影'),
                onTap: () async {
                  Navigator.pop(context);
                  final picker = ImagePicker();
                  final pickedFile = await picker.pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    await Provider.of<AppProvider>(context, listen: false)
                        .analyzeImage(pickedFile.path);
                    if (!context.mounted) return; // mounted チェック
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ResultScreen()),
                    );
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('ギャラリーから選択'),
                onTap: () async {
                  Navigator.pop(context);
                  final picker = ImagePicker();
                  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    await Provider.of<AppProvider>(context, listen: false)
                        .analyzeImage(pickedFile.path);
                    if (!context.mounted) return; // mounted チェック
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ResultScreen()),
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // _screens を遅延初期化しないよう、ボタンのロジックを分離
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      // あなたタブ（仮のプレースホルダー）
      Container(
        color: Colors.white, // 背景を白に統一
        child: Center(
          child: Text('あなた画面', style: TextStyle(fontSize: 24)),
        ),
      ),
      // ホームタブ（画像アップロード画面）
      LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            color: Colors.white, // 背景を白に統一
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: constraints.maxHeight * 0.05,
                    horizontal: constraints.maxWidth * 0.1,
                  ),
                  child: Text(
                    '食材を撮影してレシピを検索',
                    style: TextStyle(
                      fontSize: constraints.maxWidth > 600 ? 28 : 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: constraints.maxWidth > 600 ? 250 : 200,
                  height: constraints.maxWidth > 600 ? 250 : 200,
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.camera_alt, size: constraints.maxWidth > 600 ? 120 : 100, color: Colors.white),
                ),
                SizedBox(height: constraints.maxHeight * 0.03),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.1),
                  child: ElevatedButton(
                    onPressed: () => _pickImage(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth * 0.1,
                        vertical: constraints.maxHeight * 0.02,
                      ),
                    ),
                    child: Text(
                      '撮影・アップロード',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: constraints.maxWidth > 600 ? 18 : 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: constraints.maxHeight * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.1),
                  child: Text(
                    '食材を撮影すると自動的に認識し、レシピを検索できます。',
                    style: TextStyle(
                      fontSize: constraints.maxWidth > 600 ? 16 : 14,
                      color: Colors.blue[900],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      // メニュータブ（仮のプレースホルダー）
      Container(
        color: Colors.white, // 背景を白に統一
        child: Center(
          child: Text('メニュー画面', style: TextStyle(fontSize: 24)),
        ),
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // タブ切り替え時に状態を更新
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('レシピアシスタント'),
        backgroundColor: Colors.white, // AppBar の背景を白に変更
        elevation: 0, // 影をなくす（オプション）
        titleTextStyle: TextStyle(
          color: Colors.black, // タイトル文字を黒に変更
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: _screens[_selectedIndex],
      backgroundColor: Colors.white, // Scaffold の背景を白に統一
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'あなた',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'メニュー',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white, // BottomNavigationBar の背景を白に変更
      ),
    );
  }
}
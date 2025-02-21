import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1; // 初期値を「ホーム」（中央）に設定

  // タブごとのコンテンツ（通常の List として定義）
  final List<Widget> _screens = [
    // あなたタブ（仮のプレースホルダー）
    Center(
      child: Text('あなた画面', style: TextStyle(fontSize: 24)),
    ),
    // ホームタブ（画像アップロード画面）
    LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          color: Colors.lightBlue[100], // 背景を薄い青に設定
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // テキスト（上部に固定、レスポンシブ対応）
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: constraints.maxHeight * 0.05, // 画面高さの5%
                  horizontal: constraints.maxWidth * 0.1, // 画面幅の10%
                ),
                child: Text(
                  '食材を撮影してレシピを検索',
                  style: TextStyle(
                    fontSize: constraints.maxWidth > 600 ? 28 : 20, // 幅に応じてフォントサイズ調整
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              // イラストのプレースホルダー（レスポンシブ対応）
              Container(
                width: constraints.maxWidth > 600 ? 250 : 200, // 幅に応じてサイズ調整
                height: constraints.maxWidth > 600 ? 250 : 200,
                decoration: BoxDecoration(
                  color: Colors.blue[200], // 仮の青い円
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.camera_alt, size: constraints.maxWidth > 600 ? 120 : 100, color: Colors.white), // カメラアイコン
              ),
              SizedBox(height: constraints.maxHeight * 0.03), // レスポンシブな間隔
              // ボタン（レスポンシブ対応）
              Padding(
                padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.1),
                child: ElevatedButton(
                  onPressed: () async {
                    final picker = ImagePicker();
                    final pickedFile = await picker.pickImage(source: ImageSource.camera); // カメラをデフォルトに
                    if (pickedFile != null) {
                      // 画像が選択された後の処理（AppProvider を使用して分析）
                      // 必要に応じて AppProvider を呼び出す
                      // 例: Navigator.push などの遷移
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // ボタンを青色に
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // 角丸
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.1, // 幅の10%
                      vertical: constraints.maxHeight * 0.02, // 高さの2%
                    ),
                  ),
                  child: Text(
                    '撮影・アップロード',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: constraints.maxWidth > 600 ? 18 : 16, // 幅に応じてフォントサイズ調整
                    ),
                  ),
                ),
              ),
              SizedBox(height: constraints.maxHeight * 0.02), // レスポンシブな間隔
              // 説明テキスト（レスポンシブ対応）
              Padding(
                padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.1),
                child: Text(
                  '食材を撮影すると自動的に認識し\nプラン・レシピを確認して利用できます 安心です。',
                  style: TextStyle(
                    fontSize: constraints.maxWidth > 600 ? 16 : 14, // 幅に応じてフォントサイズ調整
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
    Center(
      child: Text('メニュー画面', style: TextStyle(fontSize: 24)),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // タブ切り替え時に状態を更新
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('レシピアシスタント')),
      body: _screens[_selectedIndex], // 選択されたタブの内容を表示
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person), // あなたアイコン（人物）
            label: 'あなた',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home), // ホームアイコン
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu), // メニューアイコン
            label: 'メニュー',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // タップ時に呼び出されるコールバック
        selectedItemColor: Colors.blue, // 選択時の色を青に
        unselectedItemColor: Colors.grey, // 未選択時の色をグレーに
      ),
    );
  }
}
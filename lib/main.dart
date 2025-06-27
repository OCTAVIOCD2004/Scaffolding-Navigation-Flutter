import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minecraft Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5A7D5A), // grass green
          primary: const Color(0xFF3B5323), // darker grass
          secondary: const Color(0xFF8D734D), // dirt brown
        ),
        scaffoldBackgroundColor: const Color(0xFF8DBF67),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontFamily: 'Minecraftia', // Add your pixel font asset
            fontSize: 16,
            color: Color(0xFF3B5323),
          ),
          headlineMedium: TextStyle(
            fontFamily: 'Minecraftia',
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3B5323),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 92, 95, 85),
          foregroundColor: Color(0xFFEDEDED),
          centerTitle: true,
          elevation: 2,
          toolbarTextStyle: TextStyle(
            fontFamily: 'Minecraftia',
            fontSize: 20,
          ),
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _views = [HomePage(), ListPage(), CardPage(), GridPage()];

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Actividad')),
      drawer: Drawer(
        child: Container(
          color: Theme.of(context).colorScheme.primary,
          child: ListView(
            children: [
              DrawerHeader(
                child: Center(
                  child: Text('Menú', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: const Color.fromARGB(255, 158, 156, 156))),
                ),
              ),
              _buildDrawerItem(Icons.home, 'Inicio', 0),
              _buildDrawerItem(Icons.settings, 'Configuración', 1),
            ],
          ),
        ),
      ),
      body: _views[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: const Color.fromARGB(179, 124, 120, 120),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grass), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Lista'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'Cards'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_on), label: 'Grid'),
        ],
      ),
    );
  }

  ListTile _buildDrawerItem(IconData icon, String text, int idx) {
    return ListTile(
      leading: Icon(icon, color: const Color.fromARGB(255, 137, 132, 132)),
      title: Text(text, style: const TextStyle(color: Color.fromARGB(255, 124, 119, 119))),
      onTap: () {
        Navigator.pop(context);
        _onItemTapped(idx);
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: const TextStyle(fontFamily: 'Minecraftia')),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }

  void _incrementCounter() {
    if (_counter < 20) setState(() => _counter++);
    else _showSnackBar('¡Máximo alcanzado!');
  }

  void _decrementCounter() {
    if (_counter > 0) setState(() => _counter--);
    else _showSnackBar('No puede ser menor a 0');
  }

  void _resetCounter() => setState(() => _counter = 0);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Octavio Castelán Díaz', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 10),
          Text('$_counter', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _minecraftButton(Icons.add, _incrementCounter),
              const SizedBox(width: 12),
              _minecraftButton(Icons.replay, _resetCounter),
              const SizedBox(width: 12),
              _minecraftButton(Icons.remove, _decrementCounter),
            ],
          ),
        ],
      ),
    );
  }

  Widget _minecraftButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
      child: IconButton(
        icon: Icon(icon, size: 32),
        onPressed: onPressed,
      ),
    );
  }
}



// ListPage with ListView.separated
class ListPage extends StatelessWidget {
  const ListPage({super.key});

  // Datos de ejemplo, ajusta o amplía a tu gusto
  static const List<Map<String, String>> places = [
    {
      'type': 'movie',
      'name': 'CineArts at the Empire',
      'address': '85 W Portal Ave',
    },
    {
      'type': 'movie',
      'name': 'The Castro Theater',
      'address': '429 Castro St',
    },
    {
      'type': 'movie',
      'name': 'Alamo Drafthouse Cinema',
      'address': '2550 Mission St',
    },
    {
      'type': 'movie',
      'name': 'Roxie Theater',
      'address': '3117 16th St',
    },
    {
      'type': 'movie',
      'name': 'United Artists Stonestown Twin',
      'address': '501 Buckingham Way',
    },
    {
      'type': 'movie',
      'name': 'AMC Metreon 16',
      'address': '135 4th St #3000',
    },
    {
      'type': 'restaurant',
      'name': 'K\'s Kitchen',
      'address': '757 Monterey Blvd',
    },
    {
      'type': 'restaurant',
      'name': 'Emmy\'s Restaurant',
      'address': '1923 Ocean Ave',
    },
    {
      'type': 'restaurant',
      'name': 'Chaiya Thai Restaurant',
      'address': '272 Claremont Blvd',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: places.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final place = places[index];
        final isMovie = place['type'] == 'movie';
        return ListTile(
          leading: Icon(
            isMovie ? Icons.movie_outlined : Icons.restaurant_outlined,
            color: isMovie ? Colors.blueAccent : const Color.fromARGB(255, 158, 76, 175),
          ),
          title: Text(
            place['name']!,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(place['address']!),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          onTap: () {
          },
        );
      },
    );
  }
}


// CardPage with Card widgets
class CardPage extends StatelessWidget {
  const CardPage({super.key});

  final List<Map<String, dynamic>> recipes = const [
    {
      'title': 'Bake',
      'image': 'img/bake.jpg',
      'description':
          'Bake is a cooking method that uses dry heat, typically in an oven, to cook food. It is commonly used for bread, pastries, and casseroles.',
      'rating': 5,
      'reviews': 170,
      'prep': '25 min',
      'cook': '1 hr',
      'feeds': '4-6',
    },
    {
      'title': 'Macarons',
      'image': 'img/macarons.jpg',
      'description':
          'Macarons are sweet meringue-based confections made with egg white, icing sugar, granulated sugar, almond meal, and food coloring.',
      'rating': 4,
      'reviews': 777,
      'prep': '25 min',
      'cook': '1 hr',
      'feeds': '4-6',
    },
    {
      'title': 'Ice Cream',
      'image': 'img/ice-cream.jpg',
      'description':
          'Ice cream is a sweetened frozen food typically eaten as a snack or dessert. It is made from dairy products, such as milk and cream, and often combined with fruits or other ingredients.',
      'rating': 5,
      'reviews': 800,
      'prep': '30 min',
      'cook': '1 hr',
      'feeds': '4-6',
    },
    
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: recipes.length,
      itemBuilder: (context, i) {
        final r = recipes[i];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 24),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Row(
              children: [
                // —— IZQUIERDA: contenido —— //
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Título
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            r['title'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Descripción
                        Text(
                          r['description'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Rating + reviews
                        Row(
                          children: [
                            Row(
                              children: List.generate(
                                r['rating'],
                                (i) => const Icon(Icons.star, size: 16, color: Colors.amber),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text('${r['reviews']} Reviews'),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Iconos de prep / cook / feeds
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _IconInfo(icon: Icons.book, label: 'PREP', value: r['prep']),
                            _IconInfo(icon: Icons.timer, label: 'COOK', value: r['cook']),
                            _IconInfo(icon: Icons.restaurant, label: 'FEEDS', value: r['feeds']),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // —— DERECHA: imagen —— //
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 200,
                    width: double.infinity,       
                    child: Image.asset(
                      r['image'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Widget auxiliar para los iconos + texto
class _IconInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _IconInfo({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 20, color: const Color.fromARGB(255, 0, 255, 72)),
        const SizedBox(height: 4),
        Text(
          '$label: $value',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

// GridPage with GridView.builder
class GridPage extends StatelessWidget {
  const GridPage({super.key});

  // Tus imágenes locales 
  static const List<Map<String, String>> animals = [
    {'asset': 'img/pug.jpg', 'name': 'Cachorro Pug'},
    {'asset': 'img/black-cat.jpg', 'name': 'Gato Negro'},
    {'asset': 'img/kittens.jpg', 'name': 'Gatitos Tiernos'},
    {'asset': 'img/baby-snow-leopard.jpg', 'name': 'Leopardo de Nieve'},
    {'asset': 'img/cat.jpg', 'name': 'Gato Curioso'},
    {'asset': 'img/ice-cream.jpg', 'name': 'Helado Felino'},
    {'asset': 'img/macarons.jpg', 'name': 'Macarons Gatunos'},
    {'asset': 'img/baby-snow-leopard.jpg', 'name': 'Leopardo de Nieve'},
    {'asset': 'img/black-panter.png', 'name': 'Pantera Negra'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        itemCount: animals.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,       // 3 columnas
          crossAxisSpacing: 12,    // espacio horizontal
          mainAxisSpacing: 12,     // espacio vertical
          childAspectRatio: 3/4,   // ancho:alto aproximado
        ),
        itemBuilder: (context, idx) {
          final item = animals[idx];
          return GestureDetector(
            onTap: () => _showDetail(context, item),
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Stack(
                children: [
                  // Imagen de fondo
                  Positioned.fill(
                    child: Image.asset(
                      item['asset']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Degradado + texto abajo
                  Positioned(
                    left: 0, right: 0, bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 6),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black54,
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Text(
                        item['name']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showDetail(BuildContext context, Map<String, String> item) {
  final maxH = MediaQuery.of(context).size.height * 0.6;
  showDialog(
    context: context,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: maxH,               
        child: Column(
          children: [
            // Imagen “flexible”
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(item['asset']!, fit: BoxFit.cover),
              ),
            ),
            // Texto con padding
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  item['name']!,
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
  }
}
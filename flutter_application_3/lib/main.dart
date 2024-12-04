import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liste des artistes',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: ArtistListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ArtistListScreen extends StatelessWidget {
  ArtistListScreen({super.key});

  final List<Map<String, dynamic>> artistData = [
    {
      'name': 'The Rolling Stones',
      'album': 'Let It Bleed',
      'imageUrl':
          'https://m.media-amazon.com/images/I/81Ut0SKKVhL._UF1000,1000_QL80_.jpg',
      'year': 1969,
    },
    {
      'name': 'Pink Floyd',
      'album': 'Dark Side of the Moon',
      'imageUrl':
          'https://static1.squarespace.com/static/56858337cbced60d3b293aef/568d70177086d7180fc3bbe5/63fb8f939bac5336e37962c9/1707303857996/Albumism_PinkFloyd_TheDarkSideOfTheMoon_MainImage_2x1.jpg?format=1500w',
      'year': 1973,
    },
    {
      'name': 'James Brown',
      'album': 'Star Time',
      'imageUrl':
          'https://upload.wikimedia.org/wikipedia/en/b/b5/James_Brown_Star_Time.jpg',
      'year': 1968,
    },
    {
      'name': 'Bob Marley',
      'album': 'Exodus',
      'imageUrl':
          'https://m.media-amazon.com/images/I/71-MT-BR2uL._UF1000,1000_QL80_.jpg',
      'year': 1978,
    },
    {
      'name': 'The Beatles',
      'album': 'Abbey Road',
      'imageUrl':
          'https://imgs.search.brave.com/4MjZwVpFprqbSpzJWuQ-zmjkGPcqYEbH_njLk5p2F4I/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly93d3cu/cm9sbGluZ3N0b25l/LmZyL3dwLWNvbnRl/bnQvdXBsb2Fkcy8y/MDE4LzA4L2FiYmV5/LXJvYWQuanBn',
      'year': 1969,
    },
    {
      'name': 'The Doors',
      'album': 'The Doors',
      'imageUrl':
          'https://imgs.search.brave.com/XnViteok4u9nRvQ7qEWntNateaU9hDBVs2g821c0aW0/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5zZW5zY3JpdGlx/dWUuY29tL21lZGlh/LzAwMDAyMDEwMDY3/My8zMDAvYnJlYWtf/b25fdGhyb3VnaF90/b190aGVfb3RoZXJf/c2lkZS5qcGc',
      'year': 1967,
    },
    {
      'name': 'The Who',
      'album': 'Who\'s Next',
      'imageUrl':
          'https://imgs.search.brave.com/leWB3cmSCQHE9iQ-8pt45lgzZMH1c1rdQEqeEwWU8uQ/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZXMtbmEuc3NsLWlt/YWdlcy1hbWF6b24u/Y29tL2ltYWdlcy9J/LzgxUmQrMW1sUFpM/LmpwZw',
      'year': 1971,
    },
    {
      'name': 'The Clash',
      'album': 'London Calling',
      'imageUrl':
          'https://imgs.search.brave.com/vJ05A4Ta0zYsMRZtldqTZ8-JUbUedDp88zbAW4NzhVU/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9jZG4u/bW9zLmNtcy5mdXR1/cmVjZG4ubmV0L0xk/Sktad3ZpekR4ZjVY/U3I2RXFrclEtMzIw/LTgwLmpwZw',
      'year': 1979,
    },
    {
      'name': 'The Velvet Underground',
      'album': 'The Velvet Underground & Nico',
      'imageUrl':
          'https://imgs.search.brave.com/jkft-GJldeplg_fXRnTXX-Xo0ypY0CrNCi0_wrbBU4w/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly91cGxv/YWQud2lraW1lZGlh/Lm9yZy93aWtpcGVk/aWEvY29tbW9ucy9k/L2Q4L1ZlbHZldF9V/bmRlcmdyb3VuZF8m/X05pY29fcHVibGlj/aXR5X3Bob3RvXyhy/ZXRvdWNoZWQpLmpw/Zw',
      'year': 1967,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playlist'),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: artistData.length,
        itemBuilder: (context, index) {
          final artist = artistData[index];
          return Card(
            margin:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 5,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color.fromARGB(255, 179, 218, 181),
                    const Color.fromARGB(255, 0, 195, 49),
                  ],
                ),
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(color: Colors.black),
              ),
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(artist['name']),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.network(
                              artist['imageUrl'],
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Album: ${artist['album']}',
                            ),
                            Text('Année: ${artist['year']}'),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Fermer'),
                          ),
                        ],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 158, 210, 160),
                      );
                    },
                  );
                },
                child: ListTile(
                  leading: Image.network(
                    artist['imageUrl'],
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  title: Text(artist['name']),
                  subtitle: Text('Album: ${artist['album']}'),
                  textColor: Colors.black,
                  trailing: Text('Année: ${artist['year']}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

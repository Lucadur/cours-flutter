import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/data_provider.dart';
import '../services/user_provider.dart';
import 'auth_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    dataProvider.fetchAlbums();
    dataProvider.fetchArtists();
    dataProvider.fetchTrendingSongs();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Accueil'),
        backgroundColor: Colors.orangeAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              userProvider.isAuthenticated
                  ? Icons.logout
                  : Icons.account_circle,
              color: Colors.white,
            ),
            onPressed: () {
              if (userProvider.isAuthenticated) {
                userProvider.logout();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Déconnexion réussie')),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AuthPage()),
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Albums',
                style: TextStyle(color: Colors.orangeAccent, fontSize: 24),
              ),
            ),
            SizedBox(
              height: 250,
              child: dataProvider.albums.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dataProvider.albums.length,
                      itemBuilder: (context, index) {
                        final album = dataProvider.albums[index];
                        return Container(
                          width: 150,
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            image: album['cover']?.isNotEmpty == true
                                ? DecorationImage(
                                    image: MemoryImage(
                                      base64Decode(album['cover_image_base64']
                                          .split(',')
                                          .last),
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4.0,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(16.0),
                                  bottomRight: Radius.circular(16.0),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    album['title'] ?? 'Unknown Album',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    album['artist']?['name'] ??
                                        'Unknown Artist',
                                    style:
                                        const TextStyle(color: Colors.white70),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Artistes',
                style: TextStyle(color: Colors.orangeAccent, fontSize: 24),
              ),
            ),
            SizedBox(
              height: 120,
              child: dataProvider.artists.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dataProvider.artists.length,
                      itemBuilder: (context, index) {
                        final artist = dataProvider.artists[index];
                        return Card(
                          color: Colors.black,
                          child: Column(
                            children: [
                              if (artist['image_base64'] != null)
                                CircleAvatar(
                                  backgroundImage: MemoryImage(
                                    base64Decode(
                                        artist['image_base64'].split(',').last),
                                  ),
                                  radius: 40,
                                ),
                              const SizedBox(height: 8),
                              Text(
                                artist['name'] ?? 'Unknown Artist',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Tendances',
                style: TextStyle(color: Colors.orangeAccent, fontSize: 24),
              ),
            ),
            SizedBox(
              height: 600,
              child: dataProvider.trendingSongs.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 2.5,
                      ),
                      itemCount: dataProvider.trendingSongs.length,
                      itemBuilder: (context, index) {
                        final song = dataProvider.trendingSongs[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4.0,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading:
                                song['album']?['cover_image_base64'] != null
                                    ? Image.memory(
                                        base64Decode(song['album']
                                                ['cover_image_base64']
                                            .split(',')
                                            .last),
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      )
                                    : const Icon(Icons.music_note,
                                        color: Colors.white),
                            title: Text(
                              song['title'] ?? 'Unknown Song',
                              style: const TextStyle(color: Colors.white),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              '${song['listenCount'] ?? 0} vues',
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

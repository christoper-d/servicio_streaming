import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:servicio_streaming/models/movie.dart';
import 'package:servicio_streaming/views/videoplayerscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _codigoController = TextEditingController();
  bool _isLoading = false;
  Set<String> selectedGenres = {};
  bool _isShowingMovies = false;
  List<Movie> movies = [
    // Movie(
    //   title: 'Título de la Película 1',
    //   imagePath: 'assets/img/tal.jpg',
    //   movieLink: 'https://link_to_movie_1.com',
    //   genres: ['Estreno', 'Terror', 'Comedia','adultos'],
    // ),
    Movie(
      title: 'Concierto 1',
      imagePath: 'assets/img/concierto1.png',
      movieLink: 'https://drive.google.com/uc?export=download&id=1MzMTPENJYVEIOexhxMoFFQEcoDHPaJwu',
      genres: ['Estreno', 'concierto 1'],
    ),
    Movie(
      title: 'Concierto 2',
      imagePath: 'assets/img/concierto1.png',
      movieLink: 'https://drive.google.com/uc?export=download&id=1MzMTPENJYVEIOexhxMoFFQEcoDHPaJwu',
      genres: ['Concierto 2' ],
    ),
    Movie(
      title: 'Someday',
      imagePath: 'assets/img/concierto1.png',
      movieLink: 'https://drive.google.com/uc?export=download&id=1upe4XtJbZjcZ8y4liQq_uTc9eSc3suQN',
      genres: ['The strokes' ],
    ),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color primaryColor = isDarkMode ? const Color(0xFF262626) : Colors.green;
    Color secondaryColor = isDarkMode ? Colors.white : Colors.lightGreen;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color:isDarkMode ?  Colors.white12 :  Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Image.asset(
                  'assets/img/logo.png',
                  height: 35,
                ),
              ),
            ),
            _isShowingMovies == true
                ? IconButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white12),
                padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                ),
              ),
              icon: _isLoading
                  ? const SizedBox(
                width: 23,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
                  : const Icon(
                Icons.logout_outlined,
                color: Colors.white,
              ),
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                await Future.delayed(const Duration(seconds: 3));
                setState(() {
                  _isLoading = false;
                  _isShowingMovies = false;
                });
              },
            )
                : Container(),
          ],
        ),

        backgroundColor: primaryColor,
      ),
      body: _isShowingMovies ? _buildMoviePage() : _buildSearchPage(primaryColor, secondaryColor, isDarkMode),
    );
  }

  Widget _buildSearchPage(Color primaryColor, Color secondaryColor , bool isDarkMode ) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 1,
      color:isDarkMode ? const Color(0xFF2c2c2c) : null,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 1,
              child: Card(
                color: isDarkMode ?  Colors.grey[800] : null,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _codigoController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                hintText: 'CODIGO',
                                hintStyle: TextStyle(
                                  color: primaryColor,
                                ),
                                prefixIcon: Icon(Icons.lock, color: secondaryColor),
                                filled: true,
                                fillColor: isDarkMode ? Colors.grey[700] : null,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: primaryColor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(primaryColor),
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                              ),
                            ),
                            icon: _isLoading
                                ? const SizedBox(
                              width: 23,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                                : const Icon(Icons.arrow_forward, color: Colors.white),
                            onPressed: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              await Future.delayed(const Duration(seconds: 3));
                              setState(() {
                                _isLoading = false;
                                _isShowingMovies = true; // Mostrar la página de películas
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoviePage() {
    List<Movie> filteredMovies = movies.where((movie) => movie.genres.contains('Estreno')).toList();


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(margin: const EdgeInsets.only(left: 10,top: 10),child: const Text('Estrenos',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),)),
        SizedBox(
          height:200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: filteredMovies.map((movie) {
              return GestureDetector(
                onTap: () {
                  print('link ${movie.movieLink}');
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  VideoPlayerScreen( urlvideo: movie.movieLink, )));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width *0.5,
                  child: Card(
                    child: Column(
                      children: [
                        Expanded(child: Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                movie.imagePath,
                              ),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(movie.title),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _buildCategories(),
          ),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            children: _buildMovieCards(),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildCategories() {
    Set<String> uniqueGenres = {};

    for (var movie in movies) {
      uniqueGenres.addAll(movie.genres.where((genre) => genre != 'Estreno'));
    }

    return uniqueGenres.map((genre) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: FilterChip(
          label: Text(genre),
          selected: selectedGenres.contains(genre),
          onSelected: (isSelected) {
            setState(() {
              if (isSelected) {
                selectedGenres.add(genre);
              } else {
                selectedGenres.remove(genre);
              }
            });
          },
        ),
      );
    }).toList();
  }

  List<Widget> _buildMovieCards() {
    List<Movie> filteredMovies = selectedGenres.isEmpty
        ? movies
        : movies.where((movie) => movie.genres.any((genre) => selectedGenres.contains(genre))).toList();

    return filteredMovies.map((movie) {
      return GestureDetector(
        onTap: () {
          print('link ${movie.movieLink}');

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => VideoPlayerScreen( urlvideo: movie.movieLink, )));
        },
        child: Card(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover, // Ajuste para que cubra toda el área
                      image: AssetImage(movie.imagePath), // Cambia a AssetImage
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(movie.title),
              )
            ],
          ),
        ),
      );
    }).toList();
  }
}

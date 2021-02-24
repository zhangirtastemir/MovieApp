# MovieApp
An iOS application that shows popular films in several categories 

Pods in project:
 - AlamofireImage
 - Snapkit
 - Moya

Models:
 - Movie
 - MovieResponse
 - Genre
 - GenreResponse
 - GenreManager
 - Video
 - VideoResponse
 - ListItem
 - SectionItem
 - MovieItem

ViewControllers:
	FeaturedViewController - Main view controller of app containing list of movies divided by sections(Now playing, top rated, popular, incoming). Every section has button that opens MoviesViewController which shows movies related to that section. By tapping movie in list opens MovieDescriptionViewController which shows information about that movie.
	MoviesViewController - view controller that shows movies related to one section
	MovieDescriptionViewController - shows detailed Information about movie(image, release date, overview, videos about that movie, similar movies)
	SearchViewController - searching movie by name. After search shows list of movies with searched name

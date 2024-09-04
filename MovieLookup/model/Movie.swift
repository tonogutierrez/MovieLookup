import Foundation

struct Movie: Identifiable, Decodable {
    let adult: Bool
    let id: Int
    let poster_path: String?
    let title: String
    let overview: String
    let vote_average: Float
    let backdrop_path: String?
    let genres: [Genre]?
    let runtime: Int? // En minutos
    let release_date: String? // Fecha de lanzamiento

    var backdropURL: URL? {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w500")
        return baseURL?.appending(path: backdrop_path ?? "")
    }

    var posterThumbnail: URL? {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w100")
        return baseURL?.appending(path: poster_path ?? "")
    }

    var poster: URL? {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w500")
        return baseURL?.appending(path: poster_path ?? "")
    }

    static var preview: Movie {
        return Movie(
            adult: false,
            id: 23834,
            poster_path: "https://image.tmdb.org/t/p/w300",
            title: "Free Guy",
            overview: "prueba de texto",
            vote_average: 5.5,
            backdrop_path: "https://image.tmdb.org/t/p/w300",
            genres: [Genre(id: 28, name: "Action")],
            runtime: 115,
            release_date: "2023-05-20"
        )
    }
}

struct Genre: Identifiable, Decodable {
    let id: Int
    let name: String
}

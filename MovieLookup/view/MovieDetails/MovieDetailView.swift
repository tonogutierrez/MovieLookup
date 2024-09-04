//
//  MovieDetailView.swift
//  MovieLookup
//
//  Created by Antonio Gutierrez on 03/09/24.
//

import Foundation
import SwiftUI

struct MovieDetailView: View {

    @Environment(\.dismiss) var dismiss
    @StateObject var model = MovieDetailsViewModel()
    let movie: Movie
    let headerHeight: CGFloat = 400

    var body: some View {
        ZStack {
            Color(red:39/255,green:40/255,blue:59/255).ignoresSafeArea()

            GeometryReader { geo in
                VStack {
                    AsyncImage(url: movie.backdropURL) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: geo.size.width, maxHeight: headerHeight)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    } placeholder: {
                        ProgressView()
                    }
                    Spacer()
                }
            }

            ScrollView {
                VStack(spacing: 12) {
                    Spacer()
                        .frame(height: headerHeight)
                    HStack {
                        Text(movie.title)
                            .font(.title)
                            .fontWeight(.heavy)
                        Spacer()
                        // ratings here
                        Image(systemName: "star.fill")
                                                   .foregroundColor(.yellow)
                                               Text(String(format: "%.1f", movie.vote_average))
                                                   .foregroundColor(.white)
                    }

                    HStack {
                        // Mostrar los géneros de la película
                        if let genres = movie.genres, !genres.isEmpty {
                            ForEach(genres, id: \.id) { genre in
                                Text(genre.name)
                                    .font(.caption)
                                    .padding(8)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        } else {
                            Text("Géneros no disponibles")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        // Mostrar la duración de la película si está disponible
                        if let runtime = movie.runtime {
                            Text("\(runtime) min")
                                .font(.caption)
                                .foregroundColor(.white)
                        } else {
                            Text("Duración no disponible")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }


                    HStack {
                        Text("About film")
                            .font(.title3)
                            .fontWeight(.bold)
                        Spacer()
                        // see all button
                    }

                    Text(movie.overview)
                        .lineLimit(2)
                        .foregroundColor(.white)

                    HStack {
                        Text("Cast & Crew")
                            .font(.title3)
                            .fontWeight(.bold)
                        Spacer()
                        // see all button
                    }

                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(model.castProfiles) { cast in
                                CastView(cast: cast)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .ignoresSafeArea()
        .overlay(alignment: .topLeading) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .fontWeight(.bold)
            }
            .padding(.leading)
        }
        .toolbar(.hidden, for: .navigationBar)
        .task {
            await model.movieCredits(for: movie.id)
            await model.loadCastProfiles()
        }
    }

}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: .preview)
    }
}


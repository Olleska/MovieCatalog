//
//  MainViewModel.swift
//  Movie
//
//  Created by Олеся Лыжина on 31.10.2025.
//

import Foundation
import Alamofire

final class MainViewModel {
    struct MainFilmsModel {
        let headerId: String
        let headerImage: String
        let movies: [MovieModel]
        let favorite: [FavoriteModel]
    }
    struct FavoriteModel {
        let id: String
        let poster: String
    }
    struct MovieModel {
        let id: String
        let title: String
        let poster: String
        let year: Int
        let country: String
        let genre: [String]
        let rating: [Double]
    }
    var onDidLoadMovies: ((MainFilmsModel) -> Void)?
    
    private var currentPage = 1
    private var isPageLoading = false
    private var canLoadMore = true
    private var allMovies: [MovieModel] = []
    private var currentHeaderData: (id: String, poster: String)?
        
    private var token: String {
        UserDefaults.standard.string(forKey: "userToken") ?? ""
    }

    func getMovies() {
            currentPage = 1
            allMovies = []
            canLoadMore = true
            loadData()
    }
    func loadNextPage() {
            guard !isPageLoading, canLoadMore else { return }
            loadData()
    }
    private func loadData() {
            isPageLoading = true
            Task {
                await _getMovies(page: currentPage)
            }
    }
    private func _getMovies(page: Int) async {
        let url = "https://react-midterm.kreosoft.space/api/movies/\(page)"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
            
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: MoviesPagesListModel.self) { [weak self] response in
                defer { self?.isPageLoading = false }
                    
                switch response.result {
                case .success(let model):
                    Task { @MainActor in
                        await self?.handleSuccessRequest(model)
                    }
                case .failure(let error):
                    print("Ошибка загрузки страницы \(page): \(error)")
                }
            }
        }
    @MainActor
    private func handleSuccessRequest(_ result: MoviesPagesListModel) async {
        canLoadMore = result.pageInfo.currentPage < result.pageInfo.pageCount
        if canLoadMore {
            currentPage += 1
        }
        var newMoviesRaw = result.movies
        if result.pageInfo.currentPage == 1 {
            if !newMoviesRaw.isEmpty {
                let headerFilm = newMoviesRaw.remove(at: 0)
                currentHeaderData = (headerFilm.id, headerFilm.poster)
            }
        }
        let newMoviesProcessed = newMoviesRaw.map { movie in
            return MovieModel(
                id: movie.id,
                title: movie.name,
                poster: movie.poster,
                year: movie.year,
                country: movie.country,
                genre: movie.genres.map { $0.name },
                rating: movie.reviews.map{ Double($0.rating)}
            )
        }
        self.allMovies.append(contentsOf: newMoviesProcessed)
            
        let resultModel = MainFilmsModel(
            headerId: currentHeaderData?.id ?? "",
            headerImage: currentHeaderData?.poster ?? "",
            movies: self.allMovies,
            favorite: []
        )
        onDidLoadMovies?(resultModel)
    }
}

struct MoviesPagesListModel: Codable {
    let movies: [MovieElementModel]
    let pageInfo: PageInfo
}

struct MovieElementModel: Codable {
    let id: String
    let name: String
    let poster: String
    let year: Int
    let country: String
    let genres: [GenreModel]
    let reviews: [ReviewShortModel]
}

struct GenreModel: Codable {
    let id: String
    let name: String
}

struct ReviewShortModel: Codable {
    let id: String
    let rating: Int
}

struct PageInfo: Codable {
    let pageSize: Int
    let pageCount: Int
    let currentPage: Int
}

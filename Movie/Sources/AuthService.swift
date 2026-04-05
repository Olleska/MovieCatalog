//
//  AuthService.swift
//  Movie
//
//  Created by Олеся Лыжина on 07.11.2025.
//

import Foundation
import Alamofire

final class AuthService {
    static let shared = AuthService()
    private init() {}

    func login(username: String, password: String, completion: @escaping (Result<String, AFError>) -> Void) {
        let url = "https://react-midterm.kreosoft.space/api/account/login"
        
        let parameters: [String: String] = [
            "username": username,
            "password": password
        ]

        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: LoginResponse.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data.token))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func registration(userName: String, name: String, password: String, email: String, birthDate: String, gender: Int, completion: @escaping (Result<String, AFError>) -> Void){
        let url = "https://react-midterm.kreosoft.space/api/account/register"
        
        let parameters: [String: Any] = [
            "userName": userName,
            "name": name,
            "password": password,
            "email": email,
            "birthDate": birthDate,
            "gender": gender
        ]
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: [String: String].self) { response in
                        switch response.result {
                        case .success(let value):
                            if let token = value["token"] {
                                completion(.success(token))
                            } else {
                                completion(.success("победа"))
                            }
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
    }
    func getProfile() async throws -> UserProfile {
        let url = "https://react-midterm.kreosoft.space/api/account/profile"
        let token = UserDefaults.standard.string(forKey: "userToken") ?? ""
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        return try await NetworkService.shared.request(url: url, method: .get, headers: headers)
    }
    func logout() async throws {
        let url = "https://react-midterm.kreosoft.space/api/account/logout"
        let token = UserDefaults.standard.string(forKey: "userToken") ?? ""
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        try await NetworkService.shared.requestWithoutResponse(url: url, method: .post, headers: headers)
    }
}

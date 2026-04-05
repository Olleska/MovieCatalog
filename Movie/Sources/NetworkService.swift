//
//  NetworkService.swift
//  Movie
//
//  Created by Олеся Лыжина on 07.11.2025.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case decodingError
    case serverError(statusCode: Int)
    case noData
    case unknown(Error)

    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Неверный URL"
        case .decodingError:
            return "Ошибка декодирования данных"
        case .serverError(let statusCode):
            return "Ошибка сервера: \(statusCode)"
        case .noData:
            return "Нет данных"
        case .unknown(let error):
            return "Неизвестная ошибка: \(error.localizedDescription)"
        }
    }
}

final class NetworkService {

    static let shared = NetworkService()

    private init() {
    }

    func request<T: Decodable>(
        url: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil
    ) async throws -> T {
        guard let url = URL(string: url) else {
            throw NetworkError.invalidURL
        }

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                url,
                method: method,
                parameters: parameters,
                encoding: encoding,
                headers: headers
            )
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(let error):
                    if let statusCode = response.response?.statusCode {
                        continuation.resume(throwing: NetworkError.serverError(statusCode: statusCode))
                    } else if error.isResponseSerializationError {
                        continuation.resume(throwing: NetworkError.decodingError)
                    } else {
                        continuation.resume(throwing: NetworkError.unknown(error))
                    }
                }
            }
        }
    }

    func request<T: Decodable>(
        url: String,
        method: HTTPMethod = .post,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil
    ) async throws -> T {
        return try await request(
            url: url,
            method: method,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers
        )
    }

    func request<T: Decodable, E: Encodable>(
        url: String,
        method: HTTPMethod = .post,
        body: E,
        headers: HTTPHeaders? = nil
    ) async throws -> T {
        guard let url = URL(string: url) else {
            throw NetworkError.invalidURL
        }

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                url,
                method: method,
                parameters: body,
                encoder: JSONParameterEncoder.default,
                headers: headers
            )
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(let error):
                    if let statusCode = response.response?.statusCode {
                        continuation.resume(throwing: NetworkError.serverError(statusCode: statusCode))
                    } else if error.isResponseSerializationError {
                        continuation.resume(throwing: NetworkError.decodingError)
                    } else {
                        continuation.resume(throwing: NetworkError.unknown(error))
                    }
                }
            }
        }
    }

    func requestWithoutResponse(
        url: String,
        method: HTTPMethod = .post,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = JSONEncoding.default,
        headers: HTTPHeaders? = nil
    ) async throws {
        guard let url = URL(string: url) else {
            throw NetworkError.invalidURL
        }

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                url,
                method: method,
                parameters: parameters,
                encoding: encoding,
                headers: headers
            )
            .validate()
            .response { response in
                if let error = response.error {
                    if let statusCode = response.response?.statusCode {
                        continuation.resume(throwing: NetworkError.serverError(statusCode: statusCode))
                    } else {
                        continuation.resume(throwing: NetworkError.unknown(error))
                    }
                } else {
                    continuation.resume()
                }
            }
        }
    }
}

extension NetworkService {
    func register(_ request: RegisterRequest) async throws -> AuthResponse {
        return try await self.request(
            url: "https://react-midterm.kreosoft.space/api/account/register",
            method: .post,
            body: request
        )
    }
    func login(_ request: LoginRequest) async throws -> AuthResponse {
        return try await self.request(
            url: "https://react-midterm.kreosoft.space/api/account/login",
            method: .post,
            body: request
        )
    }
}

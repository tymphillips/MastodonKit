//
//  Client.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 4/22/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

public struct Client: ClientType {
    let baseURL: String
    let session: URLSession
    public var accessToken: String?

    public init(baseURL: String, accessToken: String? = nil, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
        self.accessToken = accessToken
    }

    @discardableResult
    public func run<Model>(_ request: Request<Model>,
                           resumeImmediatelly: Bool,
                           completion: @escaping (Result<Model>) -> Void) -> URLSessionDataTask? where Model : Decodable, Model : Encodable
    {
        guard
            let components = URLComponents(baseURL: baseURL, request: request),
            let url = components.url
            else {
                completion(.failure(ClientError.malformedURL))
                return nil
        }

        var urlRequest = URLRequest(url: url, request: request, accessToken: accessToken)

        if let timeout = request.timeout {
            urlRequest.timeoutInterval = timeout
        }

        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(ClientError.malformedJSON))
                return
            }

            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
                else {
                    let mastodonError = try? MastodonError.decode(data: data)
                    let error: ClientError = mastodonError.map { .mastodonError($0.description) } ?? .genericError
                    completion(.failure(error))
                    return
            }

            do
            {
                completion(.success(try Model.decode(data: data), httpResponse.pagination))
            }
            catch let parseError
            {
                #if DEBUG
                NSLog("Parse error: \(parseError)")
                #endif
                completion(.failure(ClientError.invalidModel))
            }
        }

        if resumeImmediatelly {
            task.resume()
        }

        return task
    }
}

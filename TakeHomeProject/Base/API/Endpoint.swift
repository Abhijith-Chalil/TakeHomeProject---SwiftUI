//
//  Endpoint.swift
//  TakeHomeProject
//
//  Created by Abhijith Chalil on 26/03/25.
//

import Foundation

enum Endpoint {
    case people(page: Int)
    case detail(id: Int)
    case create(submissionData: Data?)
}

extension Endpoint {
    enum MethodType {
        case GET
        case POST(data: Data?)
    }
}


extension Endpoint {
    var host: String { "reqres.in" }
    var path: String {
        switch self {
        case .people,
                .create:
            "/api/users"
        case .detail(id: let id):
            "/api/users/\(id)"
        }
    }
    
    var methodType: MethodType {
        switch self {
        case .people,
             .detail:
            return .GET
            
        case .create(let data):
            return .POST(data: data)
            
            
        }
    }
    
    var queryItems: [String: String]? {
        switch self {
        case .people(let page):
            return ["page": "\(page)"]
        default:
            return nil
        }
    }
}

extension Endpoint {
    var url: URL? {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = host
        urlComponent.path = path
        var requestQueryItems = queryItems?.compactMap{ item in
            URLQueryItem(name: item.key, value: item.value)
        }
        
#if DEBUG
        requestQueryItems?.append(URLQueryItem(name: "delay", value: "1"))
#endif
        urlComponent.queryItems = requestQueryItems
        return urlComponent.url
    }
}

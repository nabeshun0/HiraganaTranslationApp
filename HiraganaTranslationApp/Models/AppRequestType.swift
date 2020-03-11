import APIKit

public enum APPErrorCode: Int, Error {
    case error400 = 400
    case error401 = 401
    case error403 = 403
    case error404 = 404
    case error500 = 500
}

final class DecodableDataParser: DataParser {
    public var contentType: String? {
        return "application/json"
    }

    public func parse(data: Data) throws -> Any {
        return data
    }
}

public protocol AppRequestType: Request {}

extension AppRequestType {

    public var baseURL: URL {
        return URL(string: "https://labs.goo.ne.jp/api")!
    }

    public var headerFields: [String: String] {
        return  ["Content-Type": "application/json",
                 "charset": "utf-8"]
    }
}

extension AppRequestType where Response: Decodable {
    public var dataParser: DataParser {
        return DecodableDataParser()
    }

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            throw ResponseError.unexpectedObject(object)
        }
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return try jsonDecoder.decode(Response.self, from: data)
    }
}

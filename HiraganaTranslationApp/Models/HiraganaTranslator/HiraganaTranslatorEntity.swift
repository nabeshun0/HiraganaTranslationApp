import Foundation

public struct HiraganaTranslatorEntity: Decodable {
    public var converted: String
    public var outputType: String
    public var requestId: String
}

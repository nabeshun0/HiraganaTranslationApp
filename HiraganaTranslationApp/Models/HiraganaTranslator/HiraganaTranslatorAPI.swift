import APIKit
import Foundation
import Rswift

final class HiraganaTranslatorAPI {

    struct Request: AppRequestType {
        typealias Response = HiraganaTranslatorEntity

        private let appId = "9a12d3620f719a654936a3180d90758d52ffdaf9b400cf6cd15ce14173a6cbb4"
        private let sentence: String
        private let outputType = R.string.localizable.hiragana()

        init(sentence: String) {
            self.sentence = sentence
        }

        var method: HTTPMethod {
            return APIRoutes.fetchHiragana.configurePath().method
        }

        var path: String {
            return APIRoutes.fetchHiragana.configurePath().path
        }

        var parameters: Any? {
            return ["app_id": appId,
                    "sentence": sentence,
                    "output_type": outputType]
        }
    }
}

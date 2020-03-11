import APIKit
import Foundation

final class HiraganaTranslatorAPI {

    private struct Const {
        static let appId = "9a12d3620f719a654936a3180d90758d52ffdaf9b400cf6cd15ce14173a6cbb4"
        struct Param {
            static let appId = "app_id"
            static let sentence = "sentence"
            static let outputType = "output_type"
        }
    }

    struct Request: AppRequestType {

        typealias Response = HiraganaTranslatorEntity

        private let appId = Const.appId
        private let sentence: String
        private let outputType = AppConst.hiragana

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
            return [Const.Param.appId: appId,
                    Const.Param.sentence: sentence,
                    Const.Param.outputType: outputType]
        }
    }
}

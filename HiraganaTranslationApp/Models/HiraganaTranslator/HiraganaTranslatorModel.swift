import APIKit
import Foundation

protocol HiraganaTranslatorDelegate: AnyObject {
    func hiraganaTranslatorModel(_ hiraganaTranslatorModel: HiraganaTranslatorModel, didRecieve errorMessage: ErrorMessage)
    func hiraganaTranslatorModel(_ hiraganaTranslatorModel: HiraganaTranslatorModel, didChange hiraganaText: String)
}

struct ErrorMessage {
    let title: String
    let message: String
}

final class HiraganaTranslatorModel {

    weak var delegate: HiraganaTranslatorDelegate?
    private(set) var sentence: String = ""

    private(set) var hiraganaText: String = "" {
        didSet {
            delegate?.hiraganaTranslatorModel(self, didChange: hiraganaText)
        }
    }

    private let debounce: (_ action: @escaping () -> Void) -> Void = {
        var lastFireTime: DispatchTime = .now()
        let delay: DispatchTimeInterval = .milliseconds(500)
        return { [delay] action in
            let deadline: DispatchTime = .now() + delay
            lastFireTime = .now()
            DispatchQueue.global().asyncAfter(deadline: deadline) { [delay] in
                let now: DispatchTime = .now()
                let when: DispatchTime = lastFireTime + delay
                if now < when { return }
                lastFireTime = .now()
                DispatchQueue.main.async {
                    action()
                }
            }
        }
    }()

    func fetchHiragana() {
        if sentence.isEmpty { return }

        Session.send(HiraganaTranslatorAPI.Request(sentence: sentence), callbackQueue: nil) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                print(response)
                self.hiraganaText = response.converted
            case .failure(let error):
                print(error.localizedDescription)
                let errorMessage = ErrorMessage(title: AppConst.error, message: error.localizedDescription)
                self.delegate?.hiraganaTranslatorModel(self, didRecieve: errorMessage)
            }
        }
    }

    func fetchHiragana(withSentence sentence: String) {
        debounce { [weak self] in
            guard let self = self else { return }
            self.sentence = sentence
            self.fetchHiragana()
        }
    }
}

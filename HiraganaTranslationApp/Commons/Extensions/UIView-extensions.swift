import UIKit

@IBDesignable extension UIView {
    /// UIViewの場合、Interface Builderでの描画はされません。ビルド後の動作には適用されます。
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    /// UIViewの場合、Interface Builderでの描画はされません。ビルド後の動作には適用されます。
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    /// UIViewの場合、Interface Builderでの描画はされません。ビルド後の動作には適用されます。
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let clr = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: clr)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

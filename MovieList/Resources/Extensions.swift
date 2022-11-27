//
//  Extensions.swift
//  MovieList
//
//  Created by Ditha Nurcahya Avianty on 25/11/22.
//

import UIKit

extension UIView {
    func setTopAnchorConstraint(equalTo: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) {
        topAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    func setBottomAnchorConstraint(equalTo: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) {
        bottomAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    func setLeftAnchorConstraint(equalTo: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) {
        leftAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    func setRightAnchorConstraint(equalTo: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) {
        rightAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    func setLeadingAnchorConstraint(equalTo: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) {
        leadingAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    func setTrailingAnchorConstraint(equalTo: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) {
        trailingAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    func setCenterXAnchorConstraint(equalTo: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) {
        centerXAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    func setCenterYAnchorConstraint(equalTo: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) {
        centerYAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    func setHeightAnchorConstraint(equalToConstant: CGFloat) {
        heightAnchor.constraint(equalToConstant: equalToConstant).isActive = true
    }
    func setWidthAnchorConstraint(equalToConstant: CGFloat) {
        widthAnchor.constraint(equalToConstant: equalToConstant).isActive = true
    }
    func setWidthAnchorConstraint(equalTo: NSLayoutAnchor<NSLayoutDimension>) {
        widthAnchor.constraint(equalTo: equalTo).isActive = true
    }
}

extension UIImage {
    func resizeTo(size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { _ in
            self.draw(in: CGRect.init(origin: CGPoint.zero, size: size))
        }

        return image.withRenderingMode(self.renderingMode)
    }
}

extension String {
    func capitalizingFirstLetter() -> Self {
        return prefix(1).capitalized + self.lowercased().dropFirst()
    }

    func capitalizeWords() -> Self {
        self.split(separator: " ")
            .map({ String($0).capitalizingFirstLetter() })
            .joined(separator: " ")
    }

    func stringToYearDate() -> Self {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date!)
    }

    func formatTodMMMyyy() -> Self {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "d MMM yyyy"
        return dateFormatter.string(from: date!)
    }
}

extension UILabel{

    func addTrailing(with trailingText: String, moreText: String, moreTextFont: UIFont, moreTextColor: UIColor) {

        let readMoreText: String = trailingText + moreText

        if self.text?.count ?? 0 < 150 { return }

        let lengthForVisibleString: Int = 150

        if let myText = self.text {

            let mutableString: String = myText

            let trimmedString: String? = (mutableString as NSString).replacingCharacters(in: NSRange(location: lengthForVisibleString, length: myText.count - lengthForVisibleString), with: "")

            let readMoreLength: Int = (readMoreText.count)

            guard let safeTrimmedString = trimmedString else { return }

            if safeTrimmedString.count <= readMoreLength { return }
            let trimmedForReadMore: String = (safeTrimmedString as NSString).replacingCharacters(in: NSRange(location: safeTrimmedString.count - readMoreLength, length: readMoreLength), with: "") + trailingText

            let answerAttributed = NSMutableAttributedString(string: trimmedForReadMore, attributes: [NSAttributedString.Key.font: self.font ?? "Helvetica-Oblique"])
            let readMoreAttributed = NSMutableAttributedString(string: moreText, attributes: [NSAttributedString.Key.font: moreTextFont, NSAttributedString.Key.foregroundColor: moreTextColor])
            answerAttributed.append(readMoreAttributed)
            self.attributedText = answerAttributed
        }
    }
}

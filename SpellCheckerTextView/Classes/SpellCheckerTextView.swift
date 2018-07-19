
//  MIT License
//
//Copyright (c) 2018 Md Ibrahim Hassan
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

import UIKit

public protocol SpellCheckerTextViewDataSource: class {
    func textHightlightingColor () -> UIColor
}

public class SpellCheckerTextView : UITextView {
    
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(
            frame: frame,
            textContainer: textContainer
        )
        commonInit()
        check()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        check()
    }
    
    private let textChecker = UITextChecker()
    private let tagger = NSLinguisticTagger.init(
        tagSchemes: [.tokenType],
        options: 0
    )
    private let options: NSLinguisticTagger.Options = [
        .omitPunctuation,
        .omitWhitespace,
        .joinNames
    ]
    private var languageCode : String?
    private var misspelledWords = Set<String>()
    private var highLightColor = UIColor.red
    
    public weak var dataSource : SpellCheckerTextViewDataSource? {
        didSet {
            guard let highLColor = dataSource?.textHightlightingColor() else {
                return
            }
            highLightColor = highLColor
            check()
        }
    }
}

extension SpellCheckerTextView {
    
    private func commonInit() {
        self.delegate = self
        guard let lc = Locale.current.languageCode,
            let reigonCode = Locale.current.regionCode
            else {
                return
        }
        languageCode = lc + "_" + reigonCode
    }
    
    private func check() {
        guard let language = languageCode
            else {
                return
        }
        let range = NSMakeRange(0, text.count)
        tagger.string = text
        tagger.enumerateTags(in: range, unit: .word, scheme: .tokenType, options: options) { tag, tokenRange, stop in
            let word = (text as NSString).substring(with: tokenRange)
            let misspelledRange = textChecker.rangeOfMisspelledWord(
                in: word, range: NSRange(0..<word.utf16.count),
                startingAt: 0, wrap: false, language: language)
            if misspelledRange.location != NSNotFound
            {
                misspelledWords.insert(word)
            }
        }
        
        let mutableAttributedString = NSMutableAttributedString.init(
            string: text
        )
        for i in misspelledWords {
            let components = text.components(separatedBy: .whitespacesAndNewlines)
            let words = components.filter { !$0.isEmpty }
            if !words.contains(i) {
                misspelledWords.remove(i)
            } else {
                let wrongRange = mutableAttributedString.mutableString.range(of:i)
                mutableAttributedString.setAttributes([NSAttributedStringKey.foregroundColor: highLightColor
                    ], range: wrongRange)
            }
        }
        
        self.attributedText = mutableAttributedString
    }
}

extension SpellCheckerTextView : UITextViewDelegate {
    
    public func textViewDidChange(_ textView: UITextView) {
        self.check()
    }
    
}

// Helper to convert Range to NSRange

extension StringProtocol where Index == String.Index {
    func nsRange(from range: Range<Index>) -> NSRange {
        return NSRange(range, in: self)
    }
}

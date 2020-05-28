//
//  Recognizer.swift
//  Plugin
//
//  Created by NOWJOBS on 4/6/20.
//  Copyright © 2020 Max Lynch. All rights reserved.
//

import Microblink

extension Array where Element == MBRecognizer {
    static func make(from data: [[String: Any]]) -> Self {
        data.compactMap { recognizer in
            guard
                let rawDocument = recognizer["document"] as? Int,
                let document = Document(rawValue: rawDocument),
                let returnFullDocumentImage = recognizer["returnFullDocumentImage"] as? Bool,
                let returnFaceImage = recognizer["returnFaceImage"] as? Bool,
                let allowUnverifiedResults = recognizer["allowUnverifiedResults"] as? Bool,
                let allowUnparsedResults = recognizer["allowUnparsedResults"] as? Bool else {
                    return nil
            }
            switch document {
            case .id:
                let recognizer = MBBlinkIdCombinedRecognizer()
                recognizer.returnFullDocumentImage = returnFullDocumentImage
                recognizer.returnFaceImage = returnFaceImage
                recognizer.allowUnverifiedMrzResults = allowUnverifiedResults
                recognizer.allowUnparsedMrzResults = allowUnparsedResults
                return recognizer
            case .passport:
                let recognizer = MBPassportRecognizer()
                recognizer.returnFullDocumentImage = returnFullDocumentImage
                recognizer.returnFaceImage = returnFaceImage
                return recognizer
            case .combined:
                let recognizer = MBMrtdCombinedRecognizer()
                recognizer.returnFullDocumentImage = returnFullDocumentImage
                recognizer.returnFaceImage = returnFaceImage
                return recognizer
            }
        }
    }
}

private enum Document: Int {
    case id
    case passport
    case combined
}

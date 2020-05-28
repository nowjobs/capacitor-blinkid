//
//  Mocking.swift
//  Plugin
//
//  Created by NOWJOBS on 4/6/20.
//  Copyright © 2020 Max Lynch. All rights reserved.
//

import Microblink

struct MockRecognizerResult: RecognizerResult {
    var additionalAddressInformation: String?
    var additionalNameInformation: String?
    var address: String?
    var conditions: String?
    let dateOfBirth: MBDateResult? = .init(day: 24, month: 1,year: 1984)
    let dateOfExpiry: MBDateResult? = .init(day: 12, month: 1, year: 2022)
    let dateOfExpiryPermanent = false
    let dateOfIssue: MBDateResult? = .init(day: 12, month: 1, year: 2016)
    var documentAdditionalNumber: String?
    let documentNumber: String? = "592280642506"
    var employer: String?
    let firstName: String? = "John"
    var fullName: String?
    let issuingAuthority: String? = "Ieper"
    let lastName: String? = "Doe"
    var localizedName: String?
    var maritalStatus: String?
    let mrzResult = MockMRZResult()
    let nationality: String? = "BELG"
    var personalIdNumber: String?
    let placeOfBirth: String? = "Kortrijk"
    var profession: String?
    var race: String?
    var religion: String?
    var residentialStatus: String?
    var sex: String?
    let fullDocumentFrontImage = MBImage(named: "demoDocumentFrontImage.jpg")
    let fullDocumentBackImage = MBImage(named: "demoDocumentBackImage.jpg")
    let faceImage = MBImage(named: "demoFaceImage.jpeg")
}

struct MockMRZResult: MRZResult {
    let documentType: MBMrtdDocumentType = .typeIdentityCard
    let primaryID = "DOE"
    let secondaryID = "JOHN"
    let issuer = "BEL"
    let issuerName = "BELGIUM"
    let dateOfBirth = MBDateResult(day: 24, month: 1, year: 1984)
    let documentNumber = "592280642506"
    let nationality = "BEL"
    let gender = "M"
    let documentCode = "ID"
    let dateOfExpiry = MBDateResult(day: 1, month: 12, year: 2022)
    let opt1 = "<<<<<<<<<<"
    let opt2 = "99012432572"
    let alienNumber = ""
    let applicationReceiptNumber = ""
    let immigrantCaseNumber = ""
    let mrzText = "IDBEL592280656<5058<<<<<<<<<<<\n9901247M2201122BEL990124325715\nDOE<<JOHN<<<<<<<\n"
    let isParsed = true
    let isVerified = true
    let sanitizedOpt1 = ""
    let sanitizedOpt2 = "99012432571"
    let sanitizedNationality = "BEL"
    let sanitizedIssuer = "BEL"
    let sanitizedDocumentCode = "ID"
    let sanitizedDocumentNumber = "592280642507"
    let nationalityName = "BELGIAN"
}

private extension MBDateResult {
    convenience init(day: Int, month: Int, year: Int) {
        self.init(day: day, month: month, year: year, originalDateString: nil)
    }
}

private extension MBImage {
    convenience init?(named name: String) {
        let bundle = Bundle(for: BlinkIDPlugin.self)
        guard #available(iOS 13.0, *), let image = UIImage(named: name, in: bundle, with: nil) else {
            return nil
        }
        self.init(uiImage: image)
    }
}

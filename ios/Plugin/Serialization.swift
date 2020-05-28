//
//  Serialization.swift
//  Plugin
//
//  Created by NOWJOBS on 4/6/20.
//  Copyright © 2020 Max Lynch. All rights reserved.
//

import Microblink

extension MBDateResult {
    var serialized: [String : Any] {
        [
            "day": day,
            "month": month,
            "year": year
        ]
    }
}

extension MBImage {
    var serialized: String? {
        image?.jpegData(compressionQuality: 90/100)?.base64EncodedString()
    }
}

extension RecognizerResult {
    var serialized: [String : Any?] {
        [
            "additionalAddressInformation": additionalAddressInformation,
            "additionalNameInformation": additionalNameInformation,
            "address": address,
            "conditions": conditions,
            "dateOfBirth": dateOfBirth?.serialized,
            "dateOfExpiry": dateOfExpiry?.serialized,
            "dateOfExpiryPermanent": dateOfExpiryPermanent,
            "dateOfIssue": dateOfIssue?.serialized,
            "documentAdditionalNumber": documentAdditionalNumber,
            "documentNumber": documentNumber,
            "employer": employer,
            "firstName": firstName,
            "fullDocumentFrontImage": fullDocumentFrontImage?.serialized,
            "fullDocumentBackImage": fullDocumentBackImage?.serialized,
            "faceImage": faceImage?.serialized,
            "fullName": fullName,
            "issuingAuthority": issuingAuthority,
            "lastName": lastName,
            "localizedName": localizedName,
            "maritalStatus": maritalStatus,
            "mrzResult": mrzResult.serialized,
            "nationality": nationality,
            "personalIdNumber": personalIdNumber,
            "placeOfBirth": placeOfBirth,
            "profession": profession,
            "race": race,
            "religion": religion,
            "residentialStatus": residentialStatus,
            "sex": sex
        ]
    }
}

extension MRZResult {
    var serialized: [String: Any] {
        [
            "documentType": documentType.rawValue + 1,
            "primaryId": primaryID,
            "secondaryId": secondaryID,
            "issuer": issuer,
            "issuerName": issuerName,
            "dateOfBirth": dateOfBirth.serialized,
            "documentNumber": documentNumber,
            "nationality": nationality,
            "gender": gender,
            "documentCode": documentCode,
            "dateOfExpiry": dateOfExpiry.serialized,
            "opt1": opt1,
            "opt2": opt2,
            "alienNumber": alienNumber,
            "applicationReceiptNumber": applicationReceiptNumber,
            "immigrantCaseNumber": immigrantCaseNumber,
            "mrzText": mrzText,
            "isParsed": isParsed,
            "isVerified": isVerified,
            "sanitizedOpt1": sanitizedOpt1,
            "sanitizedOpt2": sanitizedOpt2,
            "sanitizedNationality": sanitizedNationality,
            "sanitizedIssuer": sanitizedIssuer,
            "sanitizedDocumentCode": sanitizedDocumentCode,
            "sanitizedDocumentNumber": sanitizedDocumentNumber,
            "nationalityName": nationalityName
        ]
    }
}

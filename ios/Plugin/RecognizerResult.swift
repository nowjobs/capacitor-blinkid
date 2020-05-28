//
//  RecognizerResult.swift
//  Plugin
//
//  Created by NOWJOBS on 4/6/20.
//  Copyright © 2020 Max Lynch. All rights reserved.
//

import Microblink

extension MBBlinkIdRecognizerResult: RecognizerResult {
    var fullDocumentFrontImage: MBImage? { nil }
    var fullDocumentBackImage: MBImage? { nil }
}
extension MBBlinkIdCombinedRecognizerResult: RecognizerResult { }

protocol RecognizerResult {
    associatedtype Result where Result: MRZResult
    
    var additionalAddressInformation: String? { get }
    /// The additional name information of the document owner.
    var additionalNameInformation: String? { get }
    /// The address of the document owner.
    var address: String? { get }
    /// The driver license conditions.
    var conditions: String? { get }
    /// The date of birth of the document owner.
    var dateOfBirth: MBDateResult? { get }
    /// The date of expiry of the document.
    var dateOfExpiry: MBDateResult? { get }
    /// Determines if date of expiry is permanent.
    var dateOfExpiryPermanent: Bool { get }
    /// The date of issue of the document.
    var dateOfIssue: MBDateResult? { get }
    /// The additional number of the document.
    var documentAdditionalNumber: String? { get }
    /// The document number.
    var documentNumber: String? { get }
    /// The driver license detailed info.
    //                "driverLicenseDetailedInfo": self.driverLicenseDetailedInfo? as Any,
    /// The employer of the document owner.
    var employer: String? { get }
    /// face image from the document if enabled with returnFaceImage property.
    //                "faceImage": self.faceImage? as Any,
    /// The first name of the document owner.
    var firstName: String? { get }
    /// front side image of the document if enabled with `MBFullDocumentImage returnFullDocumentImage` property.
    var fullDocumentFrontImage: MBImage? { get }
    /// back side image of the document if enabled with `MBFullDocumentImage returnFullDocumentImage` property.
    var fullDocumentBackImage: MBImage? { get }
    /// face image from the document if enabled with `MBFaceImage returnFaceImage` property.
    var faceImage: MBImage? { get }
    /// The full name of the document owner.
    var fullName: String? { get }
    /// The issuing authority of the document.
    var issuingAuthority: String? { get }
    /// The last name of the document owner.
    var lastName: String? { get }
    /// The localized name of the document owner.
    var localizedName: String? { get }
    /// The marital status of the document owner.
    var maritalStatus: String? { get }
    /// The data extracted from the machine readable zone
    var mrzResult: Result { get }
    /// The nationality of the documet owner.
    var nationality: String? { get }
    /// The personal identification number.
    var personalIdNumber: String? { get }
    /// The place of birth of the document owner.
    var placeOfBirth: String? { get }
    /// The profession of the document owner.
    var profession: String? { get }
    /// The race of the document owner.
    var race: String? { get }
    /// The religion of the document owner.
    var religion: String? { get }
    /// The residential stauts of the document owner.
    var residentialStatus: String? { get }
    /// The sex of the document owner.
    var sex: String? { get }
}

extension MBRecognizerResultState {
    var isValid: Bool { self == .valid }
}

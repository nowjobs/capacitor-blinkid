//
//  MRZResult.swift
//  Plugin
//
//  Created by NOWJOBS on 4/6/20.
//  Copyright © 2020 Max Lynch. All rights reserved.
//

import Microblink

extension MBMrzResult: MRZResult { }

protocol MRZResult {
    /// Returns the MRTD document type of recognized document.
    var documentType: MBMrtdDocumentType { get }
    /// Returns the primary indentifier. If there is more than one component, they are separated with space.
    var primaryID: String { get }
    /// Returns the secondary identifier. If there is more than one component, they are separated with space.
    var secondaryID: String { get }
    /**
     * Returns three-letter or two-letter code which indicate the issuing State. Three-letter codes are based
     * on Aplha-3 codes for entities specified in ISO 3166-1, with extensions for certain States. Two-letter
     * codes are based on Aplha-2 codes for entities specified in ISO 3166-1, with extensions for certain States.
     */
    var issuer: String { get }
    /// Returns issuer name
    var issuerName: String { get }
    /// Returns holder's date of birth
    var dateOfBirth: MBDateResult { get }
    /**
     * Returns document number. Document number contains up to 9 characters.
     * Element does not exist on US Green Card. To see which document was scanned use documentType.
     */
    var documentNumber: String { get }
    /**
     * Returns nationality of the holder represented by a three-letter or two-letter code. Three-letter
     * codes are based on Alpha-3 codes for entities specified in ISO 3166-1, with extensions for certain
     * States. Two-letter codes are based on Aplha-2 codes for entities specified in ISO 3166-1, with
     * extensions for certain States.
     */
    var nationality: String { get }
    /**
     * Returns gender of the card holder. Gender is specified by use of the single initial, capital letter F for female,
     * M for male or ; for unspecified.
     */
    var gender: String { get }
    /**
     * Returns document code. Document code contains two characters. For MRTD the first character shall
     * be A, C or I. The second character shall be discretion of the issuing State or organization except
     * that V shall not be used, and `C` shall not be used after `A` except in the crew member certificate.
     * On machine-readable passports (MRP) first character shall be `P` to designate an MRP. One additional
     * letter may be used, at the discretion of the issuing State or organization, to designate a particular
     * MRP. If the second character position is not used for this purpose, it shall be filled by the filter
     * character ;.
     */
    var documentCode: String { get }
    /// Returns date of expiry
    var dateOfExpiry: MBDateResult { get }
    /**
     * Returns first optional data. Returns empty string if not available.
     * Element does not exist on US Green Card. To see which document was scanned use documentType.
     */
    var opt1: String { get }
    /**
     * Returns second optional data. Returns empty string if not available.
     * Element does not exist on US Green Card. To see which document was scanned use documentType.
     */
    var opt2: String { get }
    /**
     * Returns alien number. Returns empty string if not available.
     * Exists only on US Green Cards. To see which document was scanned use documentType.
     */
    var alienNumber: String { get }
    /**
     * Returns application receipt number. Returns empty string if not available.
     * Exists only on US Green Cards. To see which document was scanned use documentType.
     */
    var applicationReceiptNumber: String { get }
    /**
     * Returns immigrant case number. Returns empty string if not available.
     * Exists only on US Green Cards. To see which document was scanned use documentType.
     */
    var immigrantCaseNumber: String { get }
    /**
     * Returns the entire Machine Readable Zone text from ID. This text is usually used for parsing
     * other elements.
     * NOTE: This string is available only if OCR result was parsed successfully.
     */
    var mrzText: String { get }
    /// Returns true if Machine Readable Zone has been parsed, false otherwise.
    var isParsed: Bool { get }
    /// Returns true if all check digits inside MRZ are correct, false otherwise.
    var isVerified: Bool { get }
    /// Sanitized field opt1
    var sanitizedOpt1: String { get }
    /// Sanitized field opt2
    var sanitizedOpt2: String { get }
    /// Sanitized field nationality
    var sanitizedNationality: String { get }
    /// Sanitized field issuer
    var sanitizedIssuer: String { get }
    /// Sanitized document code
    var sanitizedDocumentCode: String { get }
    /// Sanitized document number
    var sanitizedDocumentNumber: String { get }
    /// Returns name of nationality
    var nationalityName: String { get }
}

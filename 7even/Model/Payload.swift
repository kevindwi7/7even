//
//  Payload.swift
//  7even
//
//  Created by Inez Amanda on 15/07/22.
//

import Foundation
import JWTKit

// JWT payload structure.
struct Payload: JWTPayload, Equatable {
    // Maps the longer Swift property names to the
    // shortened keys used in the JWT payload.
    enum CodingKeys: String, CodingKey {
//        case subject = "sub"
        case userID = "user_id"
        case expiration = "exp"
    }

    // The "sub" (subject) claim identifies the principal that is the
    // subject of the JWT.
//    var subject: SubjectClaim

    // Custom data.
    // If true, the user is an admin.
    var userID: String

    // The "exp" (expiration time) claim identifies the expiration time on
    // or after which the JWT MUST NOT be accepted for processing.
    var expiration: ExpirationClaim
    
    // Run any additional verification logic beyond
    // signature verification here.
    // Since we have an ExpirationClaim, we will
    // call its verify method.
    func verify(using signer: JWTSigner) throws {
        try self.expiration.verifyNotExpired()
    }
}

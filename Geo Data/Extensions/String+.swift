//
//  String+.swift
//  Geo Data
//
//  Created by Денис Павлов on 26.03.2023.
//

import Foundation

extension String {
    func base64UrlDecode() -> Data? {
      var base64 = self
        .replacingOccurrences(of: "-", with: "+")
        .replacingOccurrences(of: "_", with: "/")

      let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
      let requiredLength = 4 * ceil(length / 4.0)
      let paddingLength = requiredLength - length
      if paddingLength > 0 {
          let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
          base64 = base64 + padding
      }
      return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
    }
}

//
//  AddressDoc.swift
//  address search
//
//  Created by Stephen G Keable on 22/01/2016.
//  Copyright © 2016 Stephen Keable. All rights reserved.
//

import Foundation
import AppKit

class AddressDoc: NSObject {
    
    var data: AddressData
    
    override init() {
        self.data = AddressData()
    }

    init(
        summaryline: String,
        addressline1: String,
        addressline2: String,
        posttown: String,
        county: String,
        postcode: String
    ) {
        self.data = AddressData(
            summaryline: summaryline,
            addressline1: addressline1,
            addressline2: addressline2,
            posttown: posttown,
            county: county,
            postcode: postcode
        )
    }

}

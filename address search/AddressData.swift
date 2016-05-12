//
//  AddressData.swift
//  address search
//
//  Created by Stephen G Keable on 22/01/2016.
//  Copyright © 2016 Stephen Keable. All rights reserved.
//

import Foundation

class AddressData: NSObject {
    var summaryline: String
    var addressline1: String
    var addressline2: String
    var posttown: String
    var county: String
    var postcode: String
    
    override init() {
        self.summaryline = String()
        self.addressline1 = String()
        self.addressline2 = String()
        self.posttown = String()
        self.county = String()
        self.postcode = String()
    }
    
    init(
        summaryline: String,
        addressline1: String,
        addressline2: String,
        posttown: String,
        county: String,
        postcode: String
    ) {
        self.summaryline = summaryline
        self.addressline1 = addressline1
        self.addressline2 = addressline2
        self.posttown = posttown
        self.county = county
        self.postcode = postcode
    }
    
}

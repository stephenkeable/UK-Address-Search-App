//
//  MasterViewController.swift
//  address search
//
//  Created by Stephen Keable on 23/12/2015.
//  Copyright © 2015 Stephen Keable. All rights reserved.
//

import Cocoa

class MasterViewController: NSViewController {

    @IBOutlet weak var searchInput: NSTextField!
    @IBOutlet weak var searchOutput: NSTableView!
    @IBOutlet weak var labelOutput: NSTextField!
    
    @IBOutlet weak var searchButton: NSButton!
    
    var addresses = [AddressDoc]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func setupAddressData() {
        
        addresses = []
        searchOutput.reloadData()
        
        // TODO: grab search key from a prefs panel of some sort (save this across sessions)
        
        // This API key is a test one which only works for "NR14 7PZ" you can get one by signing up here - www.alliescomputing.com
        
        let postcoderApiKey = "PCW45-12345-12345-1234X"
        
        let searchString = searchInput.stringValue
        
        let searchStringEscaped = searchString.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())! as String
        
        // TODO: Add a dropdown with country codes, to enable non UK too. Use local JSON dump of country endpoint
        
        let postcoderUrl = "https://ws.postcoder.com/pcw/" + postcoderApiKey + "/address/uk/" + searchStringEscaped + "?lines=2&identifier=SK_swift_app_test"
        
        do {
            let data = NSData(contentsOfURL: NSURL(string: postcoderUrl)!)
            
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
            
            for addressItem in jsonResult as! [Dictionary<String, AnyObject>] {
                
                // TODO: Make more flexible so that any field can be used easily
                
                var summaryline = ""
                var addressline1 = ""
                var addressline2 = ""
                var posttown = ""
                var county = ""
                var postcode = ""
                
                if let summaryline_json = addressItem["summaryline"] {
                    summaryline = summaryline_json as! String
                }
                if let addressline1_json = addressItem["addressline1"] {
                    addressline1 = addressline1_json as! String
                }
                if let addressline2_json = addressItem["addressline2"] {
                    addressline2 = addressline2_json as! String
                }
                if let posttown_json = addressItem["posttown"] {
                    posttown = posttown_json as! String
                }
                if let county_json = addressItem["county"] {
                    county = county_json as! String
                }
                if let postcode_json = addressItem["postcode"] {
                    postcode = postcode_json as! String
                }
                
                let address = AddressDoc(
                    summaryline: summaryline,
                    addressline1: addressline1,
                    addressline2: addressline2,
                    posttown: posttown,
                    county: county,
                    postcode: postcode
                )
                
                addresses.append(address)
            }
            
        } catch _ {
            print("json failed")
        }
        
    }
    
    func selectedAddressDoc() -> AddressDoc? {
        let selectedRow = self.searchOutput.selectedRow;
        if selectedRow >= 0 && selectedRow < self.addresses.count {
            return self.addresses[selectedRow]
        }
        return nil
    }
    
    func updateDetailInfo(doc: AddressDoc?) {
        
       // TODO: Make this into a function that can parse a template. Input of Array of field names (in order) and String of seperator (\n etc). Output string
        
        var addressline1 = ""
        var addressline2 = ""
        var posttown = ""
        var county = ""
        var postcode = ""
        
        if let addressDoc = doc {
            addressline1 = addressDoc.data.addressline1;
            addressline2 = addressDoc.data.addressline2;
            posttown = addressDoc.data.posttown;
            county = addressDoc.data.county;
            postcode = addressDoc.data.postcode;
        }
        
        var addressOuput = "" as String
        
        if (addressline1 != "") {
            addressOuput += addressline1 + "\n"
        }
        if (addressline2 != "") {
            addressOuput += addressline2 + "\n"
        }
        if (posttown != "") {
            addressOuput += posttown + "\n"
        }
        if (county != "") {
            addressOuput += county + "\n"
        }
        if (postcode != "") {
            addressOuput += postcode
        }
        
        self.labelOutput.stringValue = addressOuput
        
    }
    
}

extension MasterViewController {
    
    @IBAction func performSearch(sender: AnyObject) {
        
        setupAddressData()
        updateDetailInfo(nil)
        searchOutput.reloadData()
        
    }
    
    @IBAction func searchInputEnter(sender: AnyObject) {
        
        setupAddressData()
        updateDetailInfo(nil)
        searchOutput.reloadData()
        
    }
    
}

// MARK: - NSTableViewDataSource
extension MasterViewController: NSTableViewDataSource {
    func numberOfRowsInTableView(aTableView: NSTableView) -> Int {
        return self.addresses.count
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        // 1
        let cellView: NSTableCellView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as! NSTableCellView
        
        // 2
        if tableColumn!.identifier == "SummaryColumn" {
            // 3
            let addressDoc = self.addresses[row]
            cellView.textField!.stringValue = addressDoc.data.summaryline
            return cellView
        }
        
        return cellView
    }
}

// MARK: - NSTableViewDelegate
extension MasterViewController: NSTableViewDelegate {
    func tableViewSelectionDidChange(notification: NSNotification) {
        let selectedDoc = selectedAddressDoc()
        updateDetailInfo(selectedDoc)
        
        // Enable/disable buttons based on the selection
        // let buttonsEnabled = (selectedDoc != nil)
        
    }
}


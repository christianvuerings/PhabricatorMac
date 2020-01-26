//
//  ViewController.swift
//  PhabricatorMac
//
//  Created by Christian Vuerings on 1/25/20.
//  Copyright © 2020 Christian Vuerings. All rights reserved.
//

import Cocoa

public struct Editor {
    public let editor: String
}

public struct Host: Codable {
    public let token: String
}

public struct Arcrc: Codable {
    public let hosts : [String:[Host]]
    //    public let config: Editor
}

class ViewController: NSViewController {
    @IBOutlet weak var output: NSTextField!
    //    private let currentDirectory: NSString = "~/cvuerings"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        output.value(forKey: "Hello World")
        
//        output.stringValue = "  result.sum"
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
}


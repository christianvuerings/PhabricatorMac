//
//  ViewController.swift
//  PhabricatorMac
//
//  Created by Christian Vuerings on 1/25/20.
//  Copyright © 2020 Christian Vuerings. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var output: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        output.value(forKey: "Hello World")
        
        output.stringValue = "  result.sum"
        

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}


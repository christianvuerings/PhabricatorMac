//
//  AppDelegate.swift
//  PhabricatorMac
//
//  Created by Christian Vuerings on 1/25/20.
//  Copyright © 2020 Christian Vuerings. All rights reserved.
//

import Cocoa
import SwiftyJSON
import Alamofire

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    let popoverView = NSPopover()
    
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.button?.title = "⚙️"
        statusItem.button?.target = self
        statusItem.button?.action = #selector(showSettings)
        
        let host = arcrcHost()
        let token = arcrcApiToken()
        print(host ?? "no host")
        print(token ?? "no token")
        whoAmI();
    }
    
    func parseArcrc() -> JSON? {
        let fileManager = FileManager.default
        let home = fileManager.homeDirectoryForCurrentUser
        let arcrcURL = home.appendingPathComponent(".arcrc")
        
        guard let contents = fileManager.contents(atPath: arcrcURL.path) else { return nil }
        guard let json = try? JSON(data: contents) else {return nil}
        return json
    }
    
    func arcrcHost() -> String? {
        let host:String? = Array(parseArcrc()?["hosts"].dictionaryValue.keys ?? nil!).first
        return host ?? nil
    }
    
    func arcrcApiToken() -> String? {
        if let hosts:[String: JSON] = parseArcrc()?["hosts"].dictionaryValue {

            for item in hosts {
                return item.1["token"].stringValue
            }
        }
        return nil
    }
    
    func request(method: String, parameters: Parameters? = nil, completion: @escaping (JSON) -> Void) -> Void {
        let host = arcrcHost() ?? ""
        let token = arcrcApiToken() ?? ""
        
        let _parameters: Parameters = [
            "api.token":token
        ].merging(parameters ?? [:]) { (_, new) in new }
        
        
        AF.request("\(host)/\(method)", parameters: _parameters).validate().responseJSON { response in
            
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(json)
                return
            case .failure(let error):
                print(error)
                return
            }
        }
    }
    
    func whoAmI() {
        request(method: "user.whoami", parameters: [
             "client": "arc",
             "clientVersion": 1000
        ]) { response in
            print("Returned String Data is: \(response["result"])")
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        popoverView.close()
    }
    
    @objc func showSettings() {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateController(withIdentifier: "ViewController")
            as? ViewController else {
                fatalError("Unable to find ViewController in the storyboard.")
        }
        
        
        popoverView.behavior = .transient
        popoverView.appearance = NSAppearance(named: .darkAqua)
        popoverView.animates = false
        popoverView.contentViewController = vc
        popoverView.show(relativeTo: statusItem.button!.bounds, of: statusItem.button!, preferredEdge: .maxY)
        
        NSApp.activate(ignoringOtherApps: true)
    }
    
    func applicationWillResignActive(_ notification: Notification) {
        popoverView.close()
    }
    
    
}


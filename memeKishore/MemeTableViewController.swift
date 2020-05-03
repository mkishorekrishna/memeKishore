//
//  MemeTableViewController.swift
//  memeKishore
//
//  Created by Kishore Krishna M on 21/04/20.
//  Copyright © 2020 Kishore Krishna M. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    var memes : [MemeModel]! {
        let object = UIApplication.shared.delegate
        let appdelegate = object as! AppDelegate
        return appdelegate.memes
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusablecell", for: indexPath)
        let dataRow = memes[(indexPath as NSIndexPath).row]
        cell.textLabel!.text = "Meme1"
        cell.imageView?.image = UIImage(named: "")
        return cell
        
        
        
    }
    

    
    
    
}

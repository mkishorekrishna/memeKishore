//
//  MemeTableViewController.swift
//  memeKishore
//
//  Created by Kishore Krishna M on 21/04/20.
//  Copyright © 2020 Kishore Krishna M. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController : UITableViewController {
    var memes : [MemeModel]! {
        let object = UIApplication.shared.delegate
        let appdelegate = object as! AppDelegate
        return appdelegate.memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView!.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusablecell", for: indexPath)
        let dataRow = memes[(indexPath as NSIndexPath).row]
        cell.textLabel!.text = dataRow.toptextF1 + dataRow.bottomtextF2
        cell.imageView?.image = dataRow.finalmeme

        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = storyboard?.instantiateViewController(withIdentifier: "memedetailview") as! MemeDetailVC
        detailController.memes = memes[indexPath.item]
        self.navigationController?.pushViewController(detailController, animated: true)
    }


    
}

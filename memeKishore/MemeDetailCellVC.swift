//
//  MemeDetailCellVC.swift
//  memeKishore
//
//  Created by Kishore Krishna M on 05/05/20.
//  Copyright © 2020 Kishore Krishna M. All rights reserved.
//

import Foundation
import UIKit


class MemeDetailCellVC : UIViewController {
    
    @IBOutlet weak var memeDetailedImage: UIImageView!
    
    var memes : [MemeModel]! {
           let object = UIApplication.shared.delegate
           let appdelegate = object as! AppDelegate
           return appdelegate.memes
       }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      //  self.memeDetailedImage = 
    }
    
    
}

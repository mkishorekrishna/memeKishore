//
//  MemeDetailCellVC.swift
//  memeKishore
//
//  Created by Kishore Krishna M on 05/05/20.
//  Copyright © 2020 Kishore Krishna M. All rights reserved.
//

import Foundation
import UIKit


class MemeDetailVC : UIViewController {
    
    @IBOutlet weak var memeDetailedImage: UIImageView?
    
    var memes: MemeModel!
    
    override func viewWillAppear(_ animated: Bool) {
        if let meme = memes{
            memeDetailedImage?.image = meme.finalmeme
        }
    }
}

//
//  MemeCollectionViewController.swift
//  memeKishore
//
//  Created by Kishore Krishna M on 21/04/20.
//  Copyright © 2020 Kishore Krishna M. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewController : UICollectionViewController {
    
    var memes : [MemeModel]! {
        let object = UIApplication.shared.delegate
        let appdelegate = object as! AppDelegate
        return appdelegate.memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView!.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reusablecollectioncell", for: indexPath)
        let dataRow = memes[(indexPath as NSIndexPath).row]
        cell.accessibilityLabel = "collectioncelllabel"
        return cell
        
        
    }
    

    
    
}


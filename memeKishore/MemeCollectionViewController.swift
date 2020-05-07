//
//  MemeCollectionViewController.swift
//  memeKishore
//
//  Created by Kishore Krishna M on 21/04/20.
//  Copyright © 2020 Kishore Krishna M. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let spacing:CGFloat = 16.0
    
    @IBOutlet weak var flowLayout : UICollectionViewFlowLayout!
    
    var memes : [MemeModel]! {
        let object = UIApplication.shared.delegate
        let appdelegate = object as! AppDelegate
        return appdelegate.memes
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        self.collectionView?.collectionViewLayout = layout
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView!.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reusablecollectioncell", for: indexPath) as! MemeCollectionViewCell
        
        cell.collectioncellImage.image = memes[indexPath.item].finalmeme
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = self.storyboard?.instantiateViewController(identifier: "memedetailview") as! MemeDetailVC
        detailController.memes = memes[indexPath.item]
        self.navigationController?.pushViewController(detailController, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 4
        let spacingBetweenCells:CGFloat = 16
        
        let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
        
        if let collection = self.collectionView{
            let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: width)
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
}


//
//  ViewController.swift
//  Image-slider
//
//  Created by World Plus on 5/28/21.
//  Copyright © 2021 World Plus. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

var imageUrl : String!
var imageTitle : String!
var imageDetail : String!

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    var userSlider : Array! = []
    var list = [NSDictionary]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var ListCollectionView: UICollectionView!
    
    var currentIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
//        pageControl.numberOfPages = userSlider.count
        collectionView.dataSource = self
        collectionView.delegate = self
        ListCollectionView.dataSource = self
        ListCollectionView.delegate = self
        
        
        let fileURL = Bundle.main.url(forResource: "input", withExtension: "json")
        AF.request(fileURL!).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                if let val = value as? NSDictionary {
                    if let sliders = val["sliders"] as? [String] {
                        self.userSlider = sliders
                    }
                    if let items = val["items"] as? [NSDictionary] {
                        self.list = items
                    }
                }
                self.collectionView.reloadData()
                self.ListCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
             return userSlider.count
        }
        return list.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath) as! SliderCell
            let str : String = self.userSlider[indexPath.item] as! String
            let url = URL(string: str)
            cell.imageView.sd_setImage(with: url, placeholderImage: nil)
            return cell
        }
        else {
            let cellList = ListCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
            let dictionary = list[indexPath.row]
            let url  = URL(string: dictionary["img"] as! String)
            cellList.imageView.sd_setImage(with: url, completed: nil)
            cellList.detailLabel.text = dictionary["brand"] as? String ?? ""
            cellList.productNameLabel.text = dictionary["title"] as? String ?? ""
            return cellList
        }
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if( collectionView != self.collectionView){
            let dictionary = list[indexPath.row]
            imageUrl =  dictionary["img"] as? String
            imageTitle = dictionary["title"] as? String
            imageDetail = dictionary["desc"] as? String
            
            // class iin gadna tald zarlawal global
            // class iin dotor tald aa zarwal private
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x / collectionView.frame.size.width)
        pageControl.currentPage = currentIndex
    }
}

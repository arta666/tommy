//
//  CollectionViewController.swift
//  Tommy
//
//  Created by Arman on 25/06/2020.
//  Copyright © 2020 Arman. All rights reserved.
//

import Foundation
import UIKit
import Moya

class GalleryViewController : UICollectionViewController {
    
    var dataController : DataController!
    
    let networkManager = NetworkManager()
    
    var photos : [Photo] = []
    
    var page = 0
    
    var selectedIndex = 0
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var catsCollection: UICollectionView!
    
  
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Tommy"
        
        setUpUI()
        
        setUIEnabled(false)
        
       fetchImages()
       
    }
    
    
    func fetchImages(){
        networkManager.search(page: page,
                                     completion:self.handleSearchRequest(cats:error:))
    }
    
    fileprivate func setUpUI() {
          let space:CGFloat = 3.0
          let dimension = (view.frame.size.width - (2 * space)) / 3.0
          
          flowLayout.minimumInteritemSpacing = 0
          flowLayout.minimumLineSpacing = 0
          flowLayout.itemSize = CGSize(width: dimension, height: dimension)
      }
    
    func handleSearchRequest(cats :[Cats]?, error:Error?){
        self.setUIEnabled(true)
        if let error = error {
            showAlertDialog(title: "Failur!", message: error.localizedDescription )
            return
        }
        page+=1
        
        if let cats = cats {
            
            for cat in cats {
                
                let imageUrl:String? = cat.url
                
                guard let imageUrlString = imageUrl  else {
                    return
                }
                // if an image exists at the url, set the image if not silently skipp!
                guard let imageURL = URL(string: imageUrlString) else{
                    return
                }
                
                ImageService.request(url: imageURL) { data, error in
                    if let data = data {
                        let photo: Photo = Photo(context: self.dataController.viewContext)
                        photo.id = UUID().uuidString // I dont want use id of fetched photo
                        photo.url = URL(string: cat.url)
                        photo.data = data
                        try? self.dataController.viewContext.save()
                        self.photos.append(photo)
                    } else {
                        print(error?.localizedDescription ?? "Something Wrong!")
                    }
                    self.refreshView()
                }

                self.refreshView()
            }
        }
    }
    
    
    func refreshView(){
        DispatchQueue.main.async {
            self.catsCollection.reloadData()
        }
    }
    
    func setUIEnabled(_ enabled: Bool) {
         
         DispatchQueue.main.async {
             if enabled {
                 self.activityIndicator.alpha = 0.0
                 self.activityIndicator.stopAnimating()
             } else {
                 
                 self.activityIndicator.alpha = 1.0
                 self.activityIndicator.startAnimating()
             }
         }
         
     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let detailVC = segue.destination as! DetaileViewContrtoller
            detailVC.photo = photos[selectedIndex]
            detailVC.dataController = dataController
        }
    }
    
    @IBAction func refresh(_ sender: Any) {
        
        photos.removeAll()
        fetchImages()
        
    }
}

extension GalleryViewController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! GalleryViewCell
        if let data = photos[indexPath.row].data{
            cell.photo.image = UIImage(data: data)
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "showDetail", sender: nil)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

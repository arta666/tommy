//
//  DetaileViewController.swift
//  Tommy
//
//  Created by Arman on 25/06/2020.
//  Copyright © 2020 Arman. All rights reserved.
//

import UIKit
import CoreData
class DetaileViewContrtoller : UIViewController {
    
    var photo : Photo!
    
    var dataController : DataController!
    
    @IBOutlet weak var favButton: UIBarButtonItem!
    

    @IBOutlet weak var photoView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = photo.data{
            photoView.image = UIImage(data: data)
            toggleBarButton(favButton, enabled: photo.isfavorite)
        }
    }

    @IBAction func favoriteButton(_ sender: Any) {
        
        if let  photo = photo {
            if photo.isfavorite{
                removeFavorite()
            }else{
                 presentNewNotebookAlert()
            }
           
        }
        
    }
 
    
    func toggleBarButton(_ button: UIBarButtonItem, enabled: Bool) {
        if enabled {
            button.tintColor = UIColor.red
        } else {
            button.tintColor = UIColor.gray
        }
    }
    
    
    func presentNewNotebookAlert() {
        let alert = UIAlertController(title: "Add To Favorite", message: "Enter Title For This Cat", preferredStyle: .alert)
        
        // Create actions
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] action in
            if let title = alert.textFields?.first?.text {
                self?.addFavorite(title: title)
            }
        }
        saveAction.isEnabled = false
        
        // Add a text field
        alert.addTextField { textField in
            textField.placeholder = "Title"
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: .main) { notif in
                if let text = textField.text, !text.isEmpty {
                    saveAction.isEnabled = true
                } else {
                    saveAction.isEnabled = false
                }
            }
        }
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        present(alert, animated: true, completion: nil)
    }
    

    func addFavorite(title: String) {
        photo.title = title
        photo.isfavorite = true
        try? dataController.viewContext.save()
        
        toggleBarButton(favButton, enabled: true)
    }
    
    func removeFavorite() {
        photo.isfavorite = false
        try? dataController.viewContext.save()
        toggleBarButton(favButton, enabled: false)
    }
    
    
}


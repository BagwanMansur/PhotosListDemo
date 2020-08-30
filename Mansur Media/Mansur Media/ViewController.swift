//
//  ViewController.swift
//  Mansur Media
//
//  Created by Mansur on 30/08/20.
//  Copyright © 2020 MansurBagwan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var arrPhotosList: [PhotosListModel] = []
    let spinner = UIActivityIndicatorView(style:.large)
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.collectionView.register(UINib(nibName: "PhotosCollectionCell", bundle: nil), forCellWithReuseIdentifier: "PhotosCollectionCell")
        // setup spinner
        spinner.backgroundColor = UIColor(white: 0, alpha: 0.2)
        self.view.addSubview(spinner)
        
        self.callPhotosListAPI()
    }

    func callPhotosListAPI() {
        
        if CommonUtility().isConnectedToNetwork()
        {
            self.showSpinner()
            WebserviceManager().getPhotsList(onCompletion: { ( arrayResponse, sucess, errorMessage) in
                self.hideSpineer()
                if sucess
                {
                    if let arrayPhotosList = arrayResponse
                    {
                        self.arrPhotosList = arrayPhotosList
                    }
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
                else{
                    self.showAlertWithMessageWithTitle(title: "Photos", message: "Photos List coulld not fetched at this moment. Please try agin later.")
                }
                
            })
        }
        else{
            self.showAlertWithMessageWithTitle(title: "Internet Connection", message: "Internet connection seems to be offline. Please check your internet connection.")
        }
    }
   //MARK:- CollectionView Methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrPhotosList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionCell", for: indexPath) as! PhotosCollectionCell
        
        let photosData: PhotosListModel = arrPhotosList[indexPath.item]
        
        if let strAuthorName = photosData.author
        {
            cell.lblAuthor.text = strAuthorName
        }
        
        if let id = photosData.id
        {
            let strURL = "https://picsum.photos/300/300?image=​" + "\(id)"
            
           // cell.imgPhotos.imageFromServerURL(urlString: strURL, PlaceHolderImage: UIImage(named: "Placeholder")!)
            cell.imgPhotos.downloadFrom(link: strURL, contentMode: .scaleAspectFit)
        }
        
        
        
        return cell
    }
    
   //MARK:- Supporting Methods
    
    func showAlertWithMessageWithTitle(title:String, message:String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func showSpinner() {
        spinner.frame = self.view.frame
        spinner.startAnimating()
    }
    func hideSpineer() {
        
        self.spinner.stopAnimating()
    }
}


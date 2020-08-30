//
//  PhotosCollectionCell.swift
//  Mansur Media
//
//  Created by Mansur on 30/08/20.
//  Copyright © 2020 MansurBagwan. All rights reserved.
//

import UIKit

class PhotosCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imgPhotos: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblAuthor: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblAuthor.textColor = .black
    }
    
    func setImageFromUrl(ImageURL :String) {
       URLSession.shared.dataTask( with: NSURL(string:ImageURL)! as URL, completionHandler: {
          (data, response, error) -> Void in
          DispatchQueue.main.async {
             if let data = data {
                self.imgPhotos.image = UIImage(data: data)
             }
          }
       }).resume()
    }
}

extension UIImageView {

//    public func imageFromServerURL(urlString: String, PlaceHolderImage:UIImage) {
//
//        if self.image == nil{
//            self.image = PlaceHolderImage
//        }
//        guard let url = URL(string: urlString) else{
//            return
//        }
//
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//
//            if error != nil {
//                print(error ?? "No Error")
//                return
//            }
//            guard let data = data else {
//                return
//            }
//
//
//            DispatchQueue.main.async(execute: { () -> Void in
//                let image = UIImage(data: data)
//                self.image = image
//            })
//
//        }.resume()
//
//    }
    
    func downloadFrom(link:String?, contentMode mode: UIView.ContentMode) {
        contentMode = mode
        image = UIImage(named: "Placeholder")
        //"https://i.picsum.photos/id/2/300/300.jpg?hmac=18v9hYebAqcHuhqDo_PgGIHxZ5Ay-8Di7TqUUS5ZvXY"
        if link != nil, let url = NSURL(string: link!) {
            URLSession.shared.dataTask(with: url as URL) { data, response, error in
                guard let data = data, error == nil else {
                    print("\nerror on download \(String(describing: error))")
                    return
                }
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                    print("statusCode != 200; \(httpResponse.statusCode)")
                    return
                }
                DispatchQueue.main.async {
                    print("\ndownload completed \(url.lastPathComponent!)")
                    self.image = UIImage(data: data)
                    self.layoutSubviews()
                }
                }.resume()
        } else {
            self.image = UIImage(named: "Placeholder")
            self.layoutSubviews()

        }
    }
    
}

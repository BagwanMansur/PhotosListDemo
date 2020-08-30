//
//  WebserviceManager.swift
//  Mansur Media
//
//  Created by Mansur on 30/08/20.
//  Copyright © 2020 MansurBagwan. All rights reserved.
//

import UIKit

class WebserviceManager: NSObject {
    
typealias photosListCallBack = ([PhotosListModel]?, Bool, String) -> Void
    
    func getPhotsList(onCompletion:@escaping photosListCallBack){
        
        let url = "https://picsum.photos/list"
        ServiceFactory().callGetWithURL(strURL: url, parameters: nil) { (responseDetails,error,successStatus) in
            
            if (successStatus)
            {
                if responseDetails is [[String: AnyObject]]?
                {
                    let dataPreference = responseDetails as! [[String: AnyObject]]
                    
                    var arrPhotosListModel: [PhotosListModel] = [PhotosListModel]()
                    for dicPhots in dataPreference
                    {
                        let photosModel = PhotosListModel(fromDictinory: dicPhots as [String: Any])
                        arrPhotosListModel.append(photosModel)
                    }
                    
                    onCompletion(arrPhotosListModel, true, "")
                }
                else {
                    
                    onCompletion(nil, false, "Something Went wrong")
                }
            }
            else{
                
                onCompletion(nil, false, "Something Went wrong")
            }
            
            
        }
    }
}

//
//  MovieDataController.swift
//  IRDb_KyleLemons
//
//  Created by Kyle Lemons on 3/25/19.
//  Copyright © 2019 Kyle Lemons. All rights reserved.
//

import UIKit

class MovieDataController: NSObject {
    
    let MYJSONURL = "https://api.myjson.com/bins/1e5uji"
    var myModel: Any?

    
    func getData(completion: @escaping (_ myModel: DataModel) ->())
    {
        let jsonURL = URL(string:MYJSONURL)
        
        let dataTask = URLSession.shared.dataTask(with: jsonURL!) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let mediaData = try
                    decoder.decode(DataModel.self, from:data)
                
                self.myModel = mediaData
            } catch let err {
                print("Err", err)
            }
            
            DispatchQueue.main.sync {
                completion(self.myModel as! DataModel)
            }
            
        }
        dataTask.resume()
    }
    
    
    
    
}

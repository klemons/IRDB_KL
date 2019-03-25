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

    
    func getData(completion: @escaping (_ success: Bool) ->())
    {
        let urlObj = URL(string:MYJSONURL)
        
        URLSession.shared.dataTask(with: urlObj!){(data, response, error) in
            
            do {
                let decoder = JSONDecoder()
                var blog = try decoder.decode(MovieDataModel.self, from: data!)
                
                
                self.myModel = blog
            } catch {
                print(error)
            }
            
            DispatchQueue.main.async {
                completion((self.myModel != nil))
            }
            
            }.resume()
    }
    
    
    
    
}

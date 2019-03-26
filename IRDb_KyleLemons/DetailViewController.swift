//
//  DetailViewController.swift
//  IRDb_KyleLemons
//
//  Created by Kyle Lemons on 3/18/19.
//  Copyright © 2019 Kyle Lemons. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var formatLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var studioLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            self.navigationItem.title = detailItem?.name
            if let label = descriptionLabel {
                label.text = detail.description
            }
            if let labelS = summaryLabel {
                labelS.text = detail.summary
            }
            
            if let labelST = studioLabel {
                labelST.text = detail.network
            }
            
            if let labelY = yearLabel {
                labelY.text = detail.yearStart
            }
            
            if let labelFormat = formatLabel {
                labelFormat.text = detail.format
            }
            
            if let labelTitle = titleLabel {
                labelTitle.text = detail.name
            }
            
            if let episodeNumber = episodeLabel {
                episodeNumber.text = "\(detail.episodes)"
            }
            
            if let ImageMovie = movieImage {
                ImageMovie.image = UIImage(contentsOfFile: detail.imageURL)
            }
            
            getItImage (url: URL(string: detail.imageURL)!) { (image, error) in
                if error != nil { //check for error when retreaving image
                    print(error?.localizedDescription)
                    return
                }
                DispatchQueue.main.async {
                    self.movieImage.image = image
                }
            }
            
        }
    }
    
    func getItImage(url:URL, completion: @escaping (_ image: UIImage?, _ error: Error?) -> Void){
        
        var picture: UIImage?
        let session = URLSession.shared
        let task = session.downloadTask(with: url) { (fileURL, response, error) in
            if error != nil{
                completion(picture,error)
                return
            }
            if let fileURL = fileURL{
                do{
                    let data = try Data(contentsOf: fileURL)
                    picture = UIImage(data: data)
                }catch {
                    completion(picture,error)
                    return
                }
            }
            completion(picture,error)
        }
        task.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.tintColor = UIColor(red:0.96, green:0.77, blue:0.28, alpha:1.0)
        configureView()
    }
    
//    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
//    label.center = CGPoint(x: 160, y: 285)
//    label.textAlignment = .center
//    label.text = "I'm a test label"
//    self.view.addSubview(label)

    var detailItem: Entry? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}


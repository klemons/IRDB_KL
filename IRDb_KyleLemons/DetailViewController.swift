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

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    var detailItem: Entry? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}


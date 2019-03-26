//
//  MasterViewController.swift
//  IRDb_KyleLemons
//
//  Created by Kyle Lemons on 3/18/19.
//  Copyright © 2019 Kyle Lemons. All rights reserved.
//

import UIKit


class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    let dataController = MovieDataController()
    var objects = [Any]()
    var newDataModel: DataModel? {
        didSet {
            tableView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        let titleImage = UIImage(named: "irdb")
        let titleImageView = UIImageView(image: titleImage)
        navigationItem.titleView = titleImageView
        
        dataController.getData(completion: {myModel in
             self.newDataModel = myModel
        })

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        // 1
        let nav = self.navigationController?.navigationBar
        
        // 2
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.yellow
        
        // 3
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        
        // 4
        let image = UIImage(named: "irdb")
        imageView.image = image
        
        // 5
        navigationItem.titleView = imageView
    }

    @objc
    func insertNewObject(_ sender: Any) {
        objects.insert(NSDate(), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = newDataModel!.franchise[indexPath.section].entries[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return (newDataModel?.franchise.count) ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (newDataModel?.franchise[section].franchiseName) ?? "No data yet"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (newDataModel?.franchise[section].entries.count) ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let mediaName = (newDataModel?.franchise[indexPath.section].entries[indexPath.row].name)!
        cell.textLabel!.text = mediaName
        
        let mediaYear = (newDataModel?.franchise[indexPath.section].entries[indexPath.row].yearStart)!
        cell.detailTextLabel?.text = mediaYear
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}


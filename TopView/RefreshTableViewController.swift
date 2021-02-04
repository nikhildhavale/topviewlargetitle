//
//  RefreshTableViewController.swift
//  TopView
//
//  Created by Nikhil d on 02/02/21.
//

import UIKit

class RefreshTableViewController: UITableViewController {
    let largeTitle = UINavigationBar()
    var maxYLargetitle = CGFloat(0)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        let rightBarbuttonItem1 = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(rightBarbuttonClicked))
        let rightBarbuttonItem2 = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(rightBarbuttonClicked))
        let navButton = UINavigationItem()
        navButton.rightBarButtonItems = [rightBarbuttonItem1,rightBarbuttonItem2]
        largeTitle.items = [navButton]
        largeTitle.translatesAutoresizingMaskIntoConstraints = false
        largeTitle.barTintColor = .white
        largeTitle.widthAnchor.constraint(equalToConstant: 200).isActive = true
        largeTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navBar = self.navigationController?.navigationBar , largeTitle.superview == nil
        {
            self.navigationController?.navigationBar.addSubview(largeTitle)
            largeTitle.bottomAnchor.constraint(equalTo: navBar.bottomAnchor,constant: -15).isActive = true
            largeTitle.trailingAnchor.constraint(equalTo: navBar.trailingAnchor).isActive = true
            largeTitle.layoutIfNeeded()
            maxYLargetitle = largeTitle.frame.maxY
        }
        
    }
    @objc func rightBarbuttonClicked()
    {
       
    }
    @objc func refresh()
    {
        self.tableView.refreshControl?.endRefreshing()
    }
    // MARK: - Table view data source
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if let parent = self.parent as? ViewController
        {
            parent.topView.isHidden = true
            parent.heightConstraint.constant = 0
            //parent.topConstraint.constant = difference

        }
    }
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       // let actualPosition = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        if let parent = self.parent as? ViewController
        {
            parent.topView.isHidden = false
            parent.heightConstraint.constant = 30


        }
        //print("will end dragging \(actualPosition.y)")

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 50
    }

    /* */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        cell.backgroundColor = .gray
        // Configure the cell...

        return cell
    }
   

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

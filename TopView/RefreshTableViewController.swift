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
    let refreshControlC = UIRefreshControl()
    var previousOffset = CGFloat(0)
    var currentHeight = CGFloat(30)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        refreshControlC.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.tableView.addSubview(refreshControlC)
        let rightBarbuttonItem1 = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(rightBarbuttonClicked))
        let rightBarbuttonItem2 = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(rightBarbuttonClicked))
        let navButton = UINavigationItem()
        navButton.rightBarButtonItems = [rightBarbuttonItem1,rightBarbuttonItem2]
        largeTitle.items = [navButton]
        largeTitle.translatesAutoresizingMaskIntoConstraints = false
        largeTitle.barTintColor = .white
        largeTitle.widthAnchor.constraint(equalToConstant: 100).isActive = true
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
        refreshControlC.endRefreshing()
    }
    // MARK: - Table view data source
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        if let parent = self.parent as? ViewController
//        {
//            parent.topView.isHidden = true
//            parent.heightConstraint.constant = 0
//            //parent.topConstraint.constant = difference
//
//        }
    }
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       // let actualPosition = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
//        if let parent = self.parent as? ViewController
//        {
//            parent.topView.isHidden = false
//            parent.heightConstraint.constant = 30
//
//
//        }
//        //print("will end dragging \(actualPosition.y)")

    }
    /*
     - (CGFloat)getHeight{
         CGFloat scrollDiff =  _scrollView.contentOffset.y - _previousOffset;
         CGFloat absoluteTop = 0;
         CGFloat absoluteBottom = _scrollView.contentSize.height - _scrollView.frame.size.height;
         BOOL isScrollingDown = scrollDiff > 0 && _scrollView.contentOffset.y > absoluteTop;
         BOOL isScrollingUp = scrollDiff < 0 && _scrollView.contentOffset.y < absoluteBottom;
         CGFloat newHeight = _currentHeight;

         BOOL goingUp = [_scrollView.panGestureRecognizer translationInView:_scrollView].y < 0;
         BOOL goingDown = [_scrollView.panGestureRecognizer translationInView:_scrollView].y > 0;
         if (isScrollingDown && goingUp ) {
             // [self moveViewDown];
             newHeight = MAX(_minViewHeight,_currentHeight - abs(scrollDiff));
     //        NSLog(@"isScrollingDown current ht %f new height %f offset %f",_currentHeight,newHeight,_scrollView.contentOffset.y);
         }
         else if(isScrollingUp && goingDown) {
            // [self moveViewUp];
             newHeight = MIN(_maxViewHeight, _currentHeight + abs(scrollDiff));
     //        NSLog(@"isScrollingUp current ht %f new height %f offset %f",_currentHeight,newHeight,_scrollView.contentOffset.y);
         }
         
         
         return newHeight;
     }
     */
    func getHeight() -> CGFloat
    {
        let scrollDiff = tableView.contentOffset.y - previousOffset
        let absoluteBottom = tableView.contentSize.height - tableView.frame.size.height
        let isScrollingUp = scrollDiff < 0 && tableView.contentOffset.y < absoluteBottom
        let goingDown = tableView.panGestureRecognizer.translation(in: tableView).y > 0
        let absoluteTop = CGFloat(0)
        let isScrollingDown = scrollDiff > 0 && tableView.contentOffset.y > absoluteTop
        let goingUp = tableView.panGestureRecognizer.translation(in: tableView).y < 0
        var newHeight = currentHeight
        if isScrollingDown && goingUp
        {
            newHeight = max(0, currentHeight - abs(scrollDiff))
        }
        else if isScrollingUp && goingDown
        {
            newHeight = min(30, currentHeight + abs(scrollDiff))

        }
        return newHeight
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let parent = self.parent as? ViewController
        {
            currentHeight = parent.heightConstraint.constant
            parent.heightConstraint.constant = getHeight()
        }
        
        if movingUp()
        {
            if scrollView.contentOffset.y > 50
            {
                self.navigationController?.navigationBar.prefersLargeTitles = false

            }
        }
        else if movingDown()
        {
            self.navigationController?.navigationBar.prefersLargeTitles = true

        }
        previousOffset = scrollView.contentOffset.y
    }
    func movingDown() -> Bool
    {
        let scrollDiff = tableView.contentOffset.y - previousOffset
        let absoluteBottom = tableView.contentSize.height - tableView.frame.size.height
        let isScrollingUp = scrollDiff < 0 && tableView.contentOffset.y < absoluteBottom
        let goingDown = tableView.panGestureRecognizer.translation(in: tableView).y > 0
        return isScrollingUp && goingDown
    }
    func movingUp() -> Bool
    {
        let scrollDiff = tableView.contentOffset.y - previousOffset
        let absoluteTop = CGFloat(0)
        let isScrollingDown = scrollDiff > 0 && tableView.contentOffset.y > absoluteTop
        let goingUp = tableView.panGestureRecognizer.translation(in: tableView).y < 0
        return goingUp && isScrollingDown
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

//
//  ViewController.swift
//  TopView
//
//  Created by Nikhil d on 02/02/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      //  self.view.sendSubviewToBack(topView)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let tableController = self.children.first as? RefreshTableViewController
        {
            if tableController.allowRubberBanding
            {
                self.view.bringSubviewToFront(topView)
            }
        }
    }

}


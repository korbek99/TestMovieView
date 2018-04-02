//
//  DetailViewController.swift
//  JOSNSwiftDemo
//
//  Created by Jose David Bustos H on 26-03-18.
//  Copyright © 2018 Jose David Bustos H. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
   
    //current controller IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var overviewDet: UILabel!
    
    //data from previous controller
    var nameString:String!
    var dobString:String!
    var imageString:String!
    var imageStringPost:String!
    var overString:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI() {
                
        self.nameLabel.text = nameString
        self.dobLabel.text = "" //dobString
        self.overviewDet.text = overString
        
        
        let imgURL = URL(string:imageStringPost)
        
        let data = NSData(contentsOf: (imgURL)!)
        self.imageView.image = UIImage(data: data as! Data)
    }
}

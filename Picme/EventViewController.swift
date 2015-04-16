//
//  EventViewController.swift
//  Picme
//
//  Created by John Nguyen on 4/11/15.
//  Copyright (c) 2015 John Nguyen. All rights reserved.
//

import UIKit

class EventViewController: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    
    var eventImages = []
    var eventTitle = " "
    var eventAttendees = 0
    var eventLove = 0
    var eventShares = 0
    var eventID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : ImageCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("eventPictureCell", forIndexPath: indexPath) as! ImageCollectionViewCell
        cell.eventImageTitle.text = "Test"
        return cell
    }

    
  
    
    func loadImages(){
        //Load images related to that event.
    }
    
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

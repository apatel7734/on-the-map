//
//  TableViewController.swift
//  On the Map
//
//  Created by Ashish Patel on 4/29/15.
//  Copyright (c) 2015 Average Techie. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - outlets
    @IBOutlet weak var listTableView: UITableView!
    
    
    //MARK: - global variables
    var pin = UIImage(named: "pin")
    var studentLocations = [StudentLocation]()
    
    //MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        listTableView.delegate = self
        listTableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        studentLocations = appDelegate.studentLocations!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - tableview delegates
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("tableviewcell", forIndexPath: indexPath) as! UITableViewCell
        
        var studentLocation = self.studentLocations[indexPath.row]
        
        cell.textLabel?.text = "\(studentLocation.firstName!) \(studentLocation.lastName!)"
        cell.imageView?.image = pin
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentLocations.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        listTableView.deselectRowAtIndexPath(indexPath, animated: true)
        var stndLocation = studentLocations[indexPath.row]
        UIApplication.sharedApplication().openURL(NSURL(string: stndLocation.mediaUrl!)!)
        
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

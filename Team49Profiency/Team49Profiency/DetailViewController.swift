//
//  DetailViewController.swift
//  Team49Profiency
//
//  Created by Rex Hardamon on 10/26/16.
//  Copyright © 2016 Rex Hardamon. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController,UITextFieldDelegate,UIScrollViewDelegate,NSFetchedResultsControllerDelegate {
    
    
    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var toolbar:UIToolbar!
    @IBOutlet weak var txtUName: UITextField!
    @IBOutlet weak var txtPWord: UITextField!
    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet weak var txtLName: UITextField!
    @IBOutlet weak var txtEMail: UITextField!
    
    

    
    var txtGloble:UITextField!
    var managedObjectContext: NSManagedObjectContext? = nil
    
    var objUser:User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let appDel = UIApplication.shared.delegate as! AppDelegate
        
        self.managedObjectContext = appDel.persistentContainer.viewContext
        
        for subview in scrollView.subviews {
            
            if let txtField = subview as? UITextField {
                txtField.inputAccessoryView = toolbar
            }
        }
        
        if objUser != nil{
            txtUName.text = objUser.uName
            txtPWord.text = objUser.pWord
            txtFName.text = objUser.fName
            txtLName.text = objUser.lName
            txtEMail.text = objUser.eMail
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterKeyboardNotifications()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: ToolBar Methods
    
    
    @IBAction func btnPrev() {
    
    
        if txtEMail.isFirstResponder{
            txtLName.becomeFirstResponder()
        }
        else if txtLName.isFirstResponder{
            txtFName.becomeFirstResponder()
        }
        else if txtFName.isFirstResponder{
            txtPWord.becomeFirstResponder()
        }
        else if txtPWord.isFirstResponder{
            txtUName.becomeFirstResponder()
        }
        else if txtUName.isFirstResponder{
            txtUName.resignFirstResponder()
        }
        
        
    }
    
    @IBAction func btnNext() {
    
    
        
        if txtUName.isFirstResponder{
            txtPWord.becomeFirstResponder()
        }
        else if txtPWord.isFirstResponder{
            txtFName.becomeFirstResponder()
        }
        else if txtFName.isFirstResponder{
            txtLName.becomeFirstResponder()
        }
        else if txtLName.isFirstResponder{
            txtEMail.becomeFirstResponder()
        }
        else if txtEMail.isFirstResponder{
            txtEMail.resignFirstResponder()
        }
        
    }
    
    @IBAction func btnDone()
    {
        if txtGloble.isFirstResponder{
            txtGloble.resignFirstResponder()
        }
    }
    
    @IBAction func btnSaveClicked(){
        
        
        if txtUName.text == "" || txtPWord.text == "" || txtFName.text == "" || txtLName.text == "" || txtEMail.text == ""
        {
            
            let alert = UIAlertController(title: "Alert", message: "Please fill all details.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            showDetailViewController(alert, sender: self)
            
            return
            
        }
        
        
        
        if objUser != nil{
            
            
            
            objUser.uName = txtUName.text!
            objUser.pWord = txtPWord.text!
            objUser.fName = txtUName.text!
            objUser.lName = txtLName.text!
            objUser.eMail = txtEMail.text!
            
            
            
            // Save the context.
            do {
                try managedObjectContext?.save()
                _ = self.navigationController?.popViewController(animated: true)
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
            
        }
        else
        {
            let context = self.fetchedResultsController.managedObjectContext
            let newUser = NSEntityDescription.insertNewObject(forEntityName: "User",
                                                              into: self.managedObjectContext!) as! User
            
            newUser.uName = txtUName.text!
            newUser.pWord = txtPWord.text!
            newUser.fName = txtUName.text!
            newUser.lName = txtLName.text!
            newUser.eMail = txtEMail.text!
            
            
            
            // Save the context.
            do {
                try context.save()
                _ = self.navigationController?.popViewController(animated: true)
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        
    }
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector:#selector(self.keyboardDidShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(self.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardDidShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (userInfo.object(forKey: UIKeyboardFrameBeginUserInfoKey)! as AnyObject).cgRectValue.size
        let contentInsets = UIEdgeInsetsMake(0, 0, keyboardSize.height, 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        var viewRect = view.frame
        viewRect.size.height -= keyboardSize.height
        if viewRect.contains(txtGloble.frame.origin) {
            self.scrollView.setContentOffset(CGPoint(x:scrollView.contentOffset.x, y: 0), animated: true)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    //MARK: Textfield Delegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        
        txtGloble = textField
        
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        
        self.btnNext()
        
        return true
    }
    
    
    // MARK: - Fetched results controller
    
    var fetchedResultsController: NSFetchedResultsController<User> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest() as! NSFetchRequest<User>
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "uName", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
    var _fetchedResultsController: NSFetchedResultsController<User>? = nil
    
}


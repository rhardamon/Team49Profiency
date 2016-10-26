//
//  User.swift
//  TeamProfiency
//
//  Created by Rex Hardamon on 10/21/16.
//  Copyright © 2016 Rex Hardamon. All rights reserved.
//

import Foundation
import CoreData

@objc(User)
class User: NSManagedObject {
    
    @NSManaged var uName:String
    @NSManaged var pWord:String
    @NSManaged var fName:String
    @NSManaged var lName:String
    @NSManaged var eMail:String
    
}



//
//  ViewController.swift
//  DatabaseApp
//
//  Created by Mary Celina Louise S. Esteva on 30/06/2019.
//  Copyright © 2019 Desteva. All rights reserved.
//

import UIKit
import SQLite3


class ViewController: UIViewController {
    
    var db: OpaquePointer?

    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldRank: UITextField!
    
    @IBAction func buttonSave(_ sender: Any) {
        let name = textFieldName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let rank = textFieldRank.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(name?.isEmpty)!
        {
            print("Name is Empty")
            return
        }
        
        if(rank?.isEmpty)!
        {
            print("Rank is Empty")
        }
        
        var stmt: OpaquePointer?
        
        let insertQuery = "INSERT INTO Sample (name, powerrank) VALUES (?, ?)"
        
        if sqlite3_prepare(db, insertQuery, -1, &stmt, nil) != SQLITE_OK
        {
            print("Error binding query")
        }
        
        if sqlite3_bind_text(stmt, 1, name, -1, nil) != SQLITE_OK
        {
            print("Error binding name")
        }
        if sqlite3_bind_int(stmt, 2, (rank! as NSString).intValue) != SQLITE_OK
        {
            print("Error binding rank")
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE
        {
            print("User Saved Successfully")
        }

        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
         let fileUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("SampleDatabase.sqlite")
        
        if sqlite3_open(fileUrl.path, &db) != SQLITE_OK
        {
            print("Error opening database")
        }
        
        let createTableQuery = "Create TABLE IF NOT EXISTS User (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, powerrank INTEGER)"
        
        if sqlite3_exec(db, createTableQuery, nil, nil, nil) != SQLITE_OK
        {
            print("Error Creating Table")
        }
        
        print("Everything is fine")
        
        
        
    }


}


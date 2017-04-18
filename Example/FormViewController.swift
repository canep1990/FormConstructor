//
//  FormViewController.swift
//  FormConstructor
//
//  Created by Alexey Ivankov on 29.03.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation
import UIKit
import FormConstructor

class FormViewController : UIViewController
{
    @IBOutlet var tableView:UITableView!;
    
    fileprivate var tableForm:ITableForm!;
    
        
    //MARK: VC Life cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableForm = TestForm(tableView: self.tableView);
        self.tableForm.configure();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }

    
}

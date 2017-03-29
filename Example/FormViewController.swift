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

class FormViewController : UIViewController, FormConstructorDataSource
{

    @IBOutlet var tableView:UITableView!;
    
    //MARK: VC Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureForm();
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
    
    private func configureForm()
    {
        
    }
    
    
    //MARK:  FormConstructorDataSource
    public func headerBuildInfo(section: Section) -> HeaderBuildInfo? {
        return nil;
    }
    
    public func footerBuildInfo(section: Section) -> FooterBuildInfo? {
        return nil;
    }
    
    public func cellBuildInfo(row: Row, section: Section) -> CellBuildInfo {
        return CellBuildInfo(buildType: BuildType.loadFromNib(nibName: "", reuseId: ""), height: nil)
    }
}

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
    enum TypeSection : String
    {
        case section1
        case section2
        case section3
    }

    @IBOutlet var tableView:UITableView!;
    
    //MARK: VC Life cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.configureTableDataSource();
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
    
    private func configureTableDataSource()
    {
        
    }
    
    
    func buildTableContainer() -> TableContainer
    {
        let tableContainer:TableContainer = TableContainer(threadsafe: false);
        let section1:Section = Section(id: TypeSection.section1.rawValue, sortKey: TypeSection.section1.rawValue);
        
        
        let section2:Section = Section(id: TypeSection.section2.rawValue, sortKey: TypeSection.section2.rawValue);
        let section3:Section = Section(id: TypeSection.section3.rawValue, sortKey: TypeSection.section3.rawValue);
        
    
        
        tableContainer.add(item: section1)
        tableContainer.add(item: section2);
        tableContainer.add(item: section3);
        
        return tableContainer;
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

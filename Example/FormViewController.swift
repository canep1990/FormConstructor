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
    enum TypeSection : Int
    {
        case section1
        case section2
        case section3
    }

    @IBOutlet var tableView:UITableView!;
    
    private lazy var formConstructor:FormConstructor = { return FormConstructor(tableContainer: self.buildTableContainer(), dataSource: self)}()
    
    //MARK: VC Life cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.configureTableDataSource();
        self.tableView.reloadData();
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
    
    private func configureTableDataSource() {
        self.tableView.dataSource = formConstructor;
    }
    
    
    func buildTableContainer() -> TableContainer
    {
        let tableContainer:TableContainer = TableContainer(threadsafe: false);
        
        let section1:Section = Section(id: TypeSection.section1.rawValue);
        section1.add(item: Row());
        section1.add(item: Row());
        section1.add(item: Row());
        section1.add(item: Row());
        section1.add(item: Row());
        
        section1.add(item: Row());
        section1.add(item: Row());
        
        section1.add(item: Row());
        section1.add(item: Row());
        
        
        
        let section2:Section = Section(id: TypeSection.section2.rawValue);
        section2.add(item: Row());
        section2.add(item: Row());
        
        let section3:Section = Section(id: TypeSection.section3.rawValue);
        section3.add(item: Row());
    
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
    
    public func cellBuildInfo(row: Row, section: Section) -> CellBuildInfo
    {
        if section.id == TypeSection.section1.rawValue
        {
            return CellBuildInfo(buildType: BuildType.loadFromNib(nibName: "TestCell1", reuseId: String(section.id)), height: nil)
        }
        else if section.id == TypeSection.section2.rawValue
        {
            return CellBuildInfo(buildType: BuildType.loadFromNib(nibName: "TestCell2", reuseId: String(section.id)), height: nil)
        }
        else if section.id == TypeSection.section3.rawValue
        {
            return CellBuildInfo(buildType: BuildType.loadFromNib(nibName: "TestCell1", reuseId: String(section.id)), height: nil)
        }
        else
        {
            fatalError();
        }
    }
}

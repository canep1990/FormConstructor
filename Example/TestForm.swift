//
//  TestForm.swift
//  FormConstructor
//
//  Created by Alexey Ivankov on 18.04.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation
import FormConstructor
import UIKit

fileprivate enum TypeSection : Int
{
    case section1
    case section2
    case section3
}

class TestForm : ITableForm
{
    let tableView: UITableView
    var dataSource:TableFormDataSource!
    
    public init(tableView:UITableView){
        self.tableView = tableView;
    }
    
    func configure()
    {
        self.dataSource = TableFormDataSource(tableContainer: buildTableContainer(), buildInfo: self)
        self.tableView.delegate = self.dataSource;
        self.tableView.dataSource = self.dataSource;
        self.tableView.reloadData();
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
    
    
    //MARK:  TableFormBuildInfo
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
            return CellBuildInfo(buildType: BuildType.loadFromNib(nibName: "TestCell1", reuseId: String(section.id)), height: 50)
        }
        else if section.id == TypeSection.section2.rawValue
        {
            return CellBuildInfo(buildType: BuildType.loadFromNib(nibName: "TestCell2", reuseId: String(section.id)), height: 50)
        }
        else if section.id == TypeSection.section3.rawValue
        {
            return CellBuildInfo(buildType: BuildType.loadFromNib(nibName: "TestCell1", reuseId: String(section.id)), height: 50)
        }
        else
        {
            fatalError();
        }
    }
    
    //MARK: TableFormConfigure
    public func willDisplay(cell: UITableViewCell, row: Row, section: Section) {
        
    }
}

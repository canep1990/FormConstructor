
//  Created by Alexey Ivankov on 03.12.16.
//  Copyright © 2016 Alexey Ivankov. All rights reserved.
//

import Foundation
import UIKit

public class FormConstructor: NSObject, UITableViewDataSource, UITableViewDelegate
{
    private(set) var dataSource:FormConstructorDataSource!;
    
    private var tableContainer:TableContainer!;
    
    private override init() {
        
    }
    
    public init (tableContainer:TableContainer, dataSource:FormConstructorDataSource)
    {
        super.init();
        
        self.tableContainer = tableContainer;
        self.dataSource = dataSource;
    }
    

    //MARK: UITableViewDataSource
    public func numberOfSections(in tableView: UITableView) -> Int
    {
        let countSections = self.tableContainer.count()
        return countSections;
    }
    

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let currentSection:Section? = self.tableContainer.item(index: section) as? Section;

        if currentSection != nil{
            return currentSection!.count();
        }
        else{
            return 0;
        }
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let section:Section = self.tableContainer.item(index:indexPath.section) as! Section
        let row:Row = section.item(index:indexPath.row) as! Row
        
        let cellBuildInfo = self.dataSource.cellBuildInfo(row: row, section: section);
        
        var tableCell:UITableViewCell? = nil;
        
        tableCell = tableView.dequeAndRegisterCell(type: cellBuildInfo.buildType)!;
        
        //self.uiConfigurator.configureCell(cell: tableCell!, value: row.model);
        
        return tableCell!;
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let section:Section = self.tableContainer.item(index:indexPath.section) as! Section
        let row:Row = section.item(index:indexPath.row) as! Row
        let cellBuildInfo = self.dataSource.cellBuildInfo(row: row, section: section);
        
        let height = cellBuildInfo.height;
        
        if height != nil{
            return CGFloat(height!);
        }
        else{
            return 0;
        }
    }
    
    
    private func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        let currentSection:Section = self.tableContainer.item(index:section) as! Section
        let headerBuildInfo = self.dataSource.headerBuildInfo(section:currentSection);
        
        guard headerBuildInfo != nil else {
            return 0;
        }
        
        let height:CGFloat? = headerBuildInfo!.height;
        
        if height != nil {
            return height!;
        }
        else{
            return 0;
        }
    }
    
    private func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        let currentSection:Section = self.tableContainer.item(index:section) as! Section
        let footerBuildInfo = self.dataSource.footerBuildInfo(section:currentSection);
        
        guard footerBuildInfo != nil else {
            return 0;
        }
        
        let height:CGFloat? = footerBuildInfo!.height;
        
        if height != nil {
            return height!;
        }
        else{
            return 0;
        }
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        let currentSection:Section = self.tableContainer.item(index:section) as! Section
        let headerBuildInfo = self.dataSource.headerBuildInfo(section: currentSection);
        let title:String? = headerBuildInfo?.title;
        
        return title;
    }
    
    //MARK: UITableViewDelegate
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        let currentSection:Section = self.tableContainer.item(index:section) as! Section
        let footerBuildInfo = self.dataSource.footerBuildInfo(section: currentSection);
        
        guard  footerBuildInfo != nil else {
            return nil;
        }
        
        let footer_view:UIView? = tableView.dequeAndRegisterHeaderFooter(type: footerBuildInfo!.buildType);
        
        return footer_view;
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let currentSection:Section = self.tableContainer.item(index:section) as! Section
        let headerBuildInfo = self.dataSource.headerBuildInfo(section: currentSection);
    
        guard headerBuildInfo != nil else {
            return nil;
        }
        
        let header_view:UIView?  = tableView.dequeAndRegisterHeaderFooter(type: headerBuildInfo!.buildType);
        
        return header_view;
    }
}

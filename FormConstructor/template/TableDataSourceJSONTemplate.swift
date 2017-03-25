//
//  DynamicTableDataSourceSettingsList_1.swift
//  WriteMe
//
//  Created by Alexey Ivankov on 20.12.16.
//  Copyright © 2016 Alexey Ivankov. All rights reserved.
//

import Foundation
import UIKit

open class TableDataSourceJSONTemplate : TableDataSourceDynamicTemplate
{
    private let sections:[SectionMetaInfo];
    
    public required  init(sections:[SectionMetaInfo]){
        self.sections = sections;
        
    }
    
    //TableDataSourceBase
 
    public func countSections() -> Int {
        return self.sections.count;
    }
    
    public func countRows(sectionType:String) -> Int
    {
        let section = self.sections.section(type: sectionType);
        return section!.rows.count;
    }
    
    public func sectionType(index:Int) -> String {
        return self.sections[index].type;
    }
    
    public func rowType(index:Int, sectionType:String) -> String
    {
        let section = self.sections.section(type: sectionType);
        return section!.rows[index].type;
    
    }
    
    public func rowValue(index:Int, sectionType:String) -> AnyObject?
    {
        let section = self.sections.section(type: sectionType);
        let row = section!.rows[index];
        return row.value;
    }
    
    //TableDataSourceCellConfigurator

    public func configureCell(cell:UITableViewCell, value:AnyObject?){
    
    }
    
    public func typeCreateCell(rowType: String, sectionType: String) -> CellTableCreateType
    {
        let section = self.sections.section(type: sectionType);
        let row = section!.rows.row(type: rowType);
        return row!.cell.create_type;
    }
    
    public func heightCell(sectionType:String, rowType:String) -> CGFloat
    {
        let section = self.sections.section(type: sectionType);
        let row = section!.rows.row(type: rowType);
        
        if row?.cell.height != nil{
            return row!.cell.height!;
        }
        else{
            return 0;
        }
        
    }
    
    //TableDataSourceHeaderConfigurator
 
    public func heightHeader(sectionType:String) -> CGFloat
    {
        let section = self.sections.section(type: sectionType);
        
        if section?.header != nil{
            return section!.header!.height;
        }
        else{
            return 0;
        }
        
    }
    
    public func titleHeader(sectionType:String) -> String?
    {
        let section = self.sections.section(type: sectionType);
        
        if section?.header != nil{
            return section!.header!.title;
        }
        else{
            return nil;
        }
    }
    
    public func typeCreateHeader(sectionType: String) -> HeaderSectionCreateType?
    {
        let section = self.sections.section(type: sectionType);
        
        if section?.header != nil{
            return section!.header!.create_type;
        }
        else{
            return nil;
        }
    }
    
    //TableDataSourceFooterConfigurator

    public func heightFooter(sectionType:String) -> CGFloat
    {
        let section = self.sections.section(type: sectionType);
        
        if section?.footer != nil{
            return section!.footer!.height;
        }
        else{
            return 0;
        }
    }
    
    public func typeCreateFooter(sectionType: String) -> FooterSectionCreateType?
    {
        let section = self.sections.section(type: sectionType);
        
        if section?.footer != nil{
            return section!.footer!.create_type;
        }
        else{
            return nil;
        }
    }
    
}

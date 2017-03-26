//
//  TableController2.swift
//  WriteMe
//
//  Created by Alexey Ivankov on 03.12.16.
//  Copyright © 2016 Alexey Ivankov. All rights reserved.
//

import Foundation
import UIKit

public class FormConstructor: NSObject,   UITableViewDataSource, UITableViewDelegate
{
    private(set) var dataSource:FormConstructorDataSource!;
    private(set) var uiConfigurator:FormConstructorUIConfigurator!;
    
    private let tableContainer:TableContainer = TableContainer(threadsafe: false);
    
    private override init() {
        
    }
    
    public init(data_source:FormConstructorDataSource, uiConfigurator:FormConstructorUIConfigurator)
    {
      
        super.init();
        
        self.dataSource = data_source;
        self.uiConfigurator = uiConfigurator;
        
        self.configureTableDataSource();
    }
    
    public convenience init(template:TableDataSourceTemplate) {
        self.init(data_source:template, uiConfigurator:template);
    }
    
    
    private func configureTableDataSource()
    {
        for indexSection in 0..<self.dataSource!.countSections()
        {
            let section_type = self.dataSource!.sectionType(index: indexSection);
            let section:Section = self.createSection(type: section_type, sortKey:  String(describing:indexSection));
            
            section.header = self.createHeader(sectionType: section.type);
            section.footer = self.createFooter(sectionType: section.type);
            
            for indexRow in 0..<self.dataSource!.countRows(sectionType: section_type)
            {
                let rowType:String = self.dataSource!.rowType(index: indexRow, sectionType: section_type);
                
                let row:Row = self.createRow(type: rowType, sortKey: String(describing:indexRow), cell:self.createCell(sectionType: section_type, rowType: rowType))
                
                section.add(item: row);
            }
            
            self.tableContainer.add(item: section);
        }
        
    }
    
    func createSection(type:String, sortKey:String) -> Section
    {
        let section:Section = Section(id:String(describing: type), sortKey:sortKey, type:type)
        return section;
    }
  
    func createRow(type:String, sortKey:String, cell:Cell) -> Row
    {
        let row = Row(id:String(describing: type), sortKey:sortKey, type:type, cell:cell)
        return row;
    }
    
    func createHeader( sectionType:String) -> Header?
    {
        var header:Header?;
        
        let create_type:TypeCreate<UITableViewHeaderFooterView.Type>? =  self.uiConfigurator.typeCreateHeader(sectionType: sectionType);
        
        guard create_type != nil else {
            return nil;
        }
        
        header = Header(typeCreate: create_type!);
        header?.height = self.uiConfigurator.heightHeader(sectionType: sectionType);
        
        return header;
    }
    
    func createFooter(sectionType:String) -> Footer?
    {
        var footer:Footer?;
        
        let create_type:TypeCreate<UITableViewHeaderFooterView.Type>? = self.uiConfigurator.typeCreateFooter(sectionType: sectionType);
        
        guard create_type != nil else {
            return nil;
        }
        
        footer = Footer(typeCreate: create_type!);
        footer?.height = self.uiConfigurator.heightFooter(sectionType: sectionType);
        
        return footer;
    }
    
    func createCell(sectionType:String, rowType:String) -> Cell
    {
        let typeCreate = self.uiConfigurator.typeCreateCell(rowType: rowType, sectionType: sectionType);
        let cell:Cell = Cell(typeCreate:typeCreate);
        
        cell.height = self.uiConfigurator.heightCell(sectionType: sectionType, rowType: rowType);
        
        return cell;
    }
    

    //MARK: UITableViewDataSource
    public func numberOfSections(in tableView: UITableView) -> Int
    {
        let countSections = self.tableContainer.count()
        return countSections;
    }
    

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let currentSection:Section? = self.tableContainer.item(index: section);

        if currentSection != nil{
            return currentSection!.count();
        }
        else{
            return 0;
        }
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let section = self.tableContainer.item(index:indexPath.section)
        let row = section!.item(index:indexPath.row)!
        var tableCell:UITableViewCell? = nil;
        
        tableCell = tableView.dequeAndRegisterCell(type: row.cell.typeCreate)!;
        
        self.uiConfigurator.configureCell(cell: tableCell!, value: row.model);
        
        return tableCell!;
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let section = self.tableContainer.item(index:indexPath.section)
        let row = section!.item(index:indexPath.row)!
        
        if row.cell.height != nil{
            return row.cell.height!;
        }
        else{
            return 0;
        }
    }
    
    
    private func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        let currentSection:Section = self.tableContainer.item(index:section)!
        
        if currentSection.header != nil && currentSection.header!.height != nil {
            return currentSection.header!.height!;
        }
        else{
            return 0;
        }
    }
    
    private func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        let currentSection:Section = self.tableContainer.item(index:section)!
        
        if currentSection.footer != nil && currentSection.footer!.height != nil {
            return currentSection.footer!.height!;
        }
        else{
            return 0;
        }
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        let currentSection:Section = self.tableContainer.item(index:section)!
        
        if currentSection.header != nil {
            return currentSection.header!.title;
        }
        else{
            return nil;
        }
    }
    
    //MARK: UITableViewDelegate
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        let current_section:Section = self.tableContainer.item(index:section)!
        let footer = current_section.footer;
        var footer_view:UIView?;
        
        if  footer != nil && footer?.typeCreate != nil{
            footer_view = tableView.dequeAndRegisterHeaderFooter(type: footer!.typeCreate);
        }
        
        return footer_view;
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let current_section:Section = self.tableContainer.item(index:section)!
        let header = current_section.header;
        var header_view:UIView?;
        
        if header != nil && header?.typeCreate != nil{
            header_view = tableView.dequeAndRegisterHeaderFooter(type: header!.typeCreate);
        }
        
        return header_view;
    }
}

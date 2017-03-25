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

    
    private let _table_container:TableContainer = TableContainer(threadsafe: false);
    
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
            
            section.header = self.createHeader(sectionMetaInfo: section.meta_info);
            section.footer = self.createFooter(sectionMetaInfo: section.meta_info);
            
            for indexRow in 0..<self.dataSource!.countRows(sectionType: section_type)
            {
                let rowType:String = self.dataSource!.rowType(index: indexRow, sectionType: section_type);
                
                let row:Row = self.createRow(type: rowType, sortKey: String(describing:indexRow))
                
                section.add(item: row);
            }
            
            self._table_container.add(item: section);
        }
        
    }
    
    func createSection(type:String, sortKey:String) -> Section
    {
        let meta_info_section:MetaInfoItem = MetaInfoItem(id:String(describing: type), sort_key:sortKey, type:type);
        let section:Section = Section(meta_info: meta_info_section, header: nil, footer: nil)
        
        return section;
    }
  
    
    
    func createRow(type:String, sortKey:String) -> Row
    {
        let meta_info_row:MetaInfoItem = MetaInfoItem(id:String(describing: type), sort_key:sortKey, type:type);
        let row = Row(meta_info: meta_info_row)
        
        return row;
    }
    
    func createHeader( sectionMetaInfo:MetaInfoItem) -> Header?
    {
        var header:Header?;
        
        if sectionMetaInfo.type != nil
        {
            let type_create_header:HeaderSectionCreateType? =  self.uiConfigurator.typeCreateHeader(sectionType: sectionMetaInfo.type!);
            
            guard type_create_header != nil else {
                return nil;
            }
            
            switch type_create_header!
            {
            case let .nib(nib_name, reuse_id):
                header = Header(nib_name: nib_name, reuse_id: reuse_id);
                break
                
            case let .code(type, reuse_id):
                header = Header(type: type, reuse_id: reuse_id);
                break;
            }
            
            header?.height = self.uiConfigurator.heightHeader(sectionType: sectionMetaInfo.type!);
        }
        return header;
    }
    
    func createFooter(sectionMetaInfo:MetaInfoItem) -> Footer?
    {
 
        var footer:Footer?;
        
        if sectionMetaInfo.type != nil
        {
            let type_create_footer:FooterSectionCreateType? = self.uiConfigurator.typeCreateFooter(sectionType: sectionMetaInfo.type!);
            
            
            guard type_create_footer != nil else {
                return nil;
            }
            
            switch type_create_footer!
            {
            case let .nib(nib_name, reuse_id):
                footer = Footer(nib_name: nib_name, reuse_id: reuse_id);
                break
                
            case let .code(type, reuse_id):
                footer = Footer(type: type, reuse_id: reuse_id);
                break;
            }
            footer?.height = self.uiConfigurator.heightFooter(sectionType: sectionMetaInfo.type!);
        }
        
        return footer;
    }
    
    func createCellRow(section_type:String, row:inout Row)
    {
        var cell:Cell?;
        
        if row.meta_info.type != nil
        {
            let type_create_cell: CellTableCreateType = self.uiConfigurator.typeCreateCell(rowType: row.meta_info.type!, sectionType: section_type)
            
             switch type_create_cell
            {
                case let .nib(nib_name, reuse_id):
                    cell = Cell(nib_name: nib_name, reuse_id: reuse_id);
                    break
                
                case let .code(type, reuse_id):
                    cell = Cell(type: type, reuse_id: reuse_id);
                    break;
            }
            cell?.height = self.uiConfigurator.heightCell(sectionType: section_type, rowType: row.meta_info.type!);
            row.cell = cell;
        }
    }
    
    
    //MARK: UITableViewDataSource
    public func numberOfSections(in tableView: UITableView) -> Int
    {
        let countSections = self._table_container.count()
        return countSections;
    }
    

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let currentSection:Section? = self._table_container.item(index: section);

        if currentSection != nil{
            return currentSection!.count();
        }
        else{
            return 0;
        }
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let section = self._table_container.item(index:indexPath.section)
        let row = section!.item(index:indexPath.row)!
        var cell_view:UITableViewCell? = nil;
        
        if row.cell != nil && row.cell?.register_info() != nil
        {
            let type:TypeRegistration = (row.cell!.register_info()!.type())
            cell_view = tableView.dequeAndRegisterCell(type: type)!;
        }
        else
        {
            
        }
        
        self.uiConfigurator.configureCell(cell: cell_view!, value: nil);
        
        return cell_view!;
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    
    
    private func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        let currentSection:Section = self._table_container.item(index:section)!
        
        if currentSection.header != nil && currentSection.header!.height != nil {
            return currentSection.header!.height!;
        }
        else{
            return 0;
        }
    }
    
    private func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        let currentSection:Section = self._table_container.item(index:section)!
        
        if currentSection.footer != nil && currentSection.footer!.height != nil {
            return currentSection.footer!.height!;
        }
        else{
            return 0;
        }
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        let currentSection:Section = self._table_container.item(index:section)!
        
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
        let current_section:Section = self._table_container.item(index:section)!
        let footer = current_section.footer;
        var footer_view:UIView?;
        
        if  footer != nil && footer?.register_info() != nil{
            footer_view = tableView.dequeAndRegisterHeaderFooter(type: footer!.register_info()!.type());
        }
        
        return footer_view;
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let current_section:Section = self._table_container.item(index:section)!
        let header = current_section.header;
        var header_view:UIView?;
        
        if header != nil && header?.register_info() != nil{
            header_view = tableView.dequeAndRegisterHeaderFooter(type: (header!.register_info()?.type())!);
        }
        
        return header_view;
    }
}

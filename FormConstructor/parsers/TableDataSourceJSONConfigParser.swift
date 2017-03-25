//
//  DTDSettingsParser.swift
//  WriteMe
//
//  Created by Alexey Ivankov on 20.12.16.
//  Copyright © 2016 Alexey Ivankov. All rights reserved.
//

import Foundation
import UIKit


public class TableDataSourceJSONConfigParser
{

    internal enum ParserKeys : String
    {
        case type
        case rows
        case height
        case nib_name
        case reuse_id
        case sections
        case cell
        case nib
        case code
        case create_type
    }
    
    
    private let _json_path:String;
    
    required public init(json_path:String){
        self._json_path = json_path;
    }

    public func parse() -> [SectionMetaInfo]?
    {
        let serialization_result:(json:[String:Any]?, error:FormConstructorError?) = self.serialization_json_with_dict();
        var sections:[SectionMetaInfo]?
        
        if serialization_result.json != nil && serialization_result.error == nil{
            sections = self.build_sections(json: serialization_result.json!)
        }
        
        return sections;
    }
    
    func serialization_json_with_dict() -> ([String:Any]?, FormConstructorError?)
    {
        var dict:[String:Any]?;
        
        do
        {
            let json_data:Data? = try Data(contentsOf: URL(fileURLWithPath: self._json_path));
            dict = try JSONSerialization.jsonObject(with: json_data! as Data, options: .mutableContainers) as? [String:Any]
        }
        catch{
            dict = nil;
        }

        if dict == nil{
            return (nil, FormConstructorError.serializedjJsonFailed);
        }
        else{
            return (dict, nil);
        }
    }
    
    private func build_sections(json:[String:Any]) -> [SectionMetaInfo]?
    {
        var sections_meta_info:[SectionMetaInfo] = [];
        
        self.parse_dict_sections_apply(json: json, block: {(section_dict, error) in
            
            if section_dict != nil && error == nil
            {
                let type_section:String? = section_dict?[ParserKeys.type.rawValue] as? String;
                
                if type_section != nil
                {
                    var rows_meta_info:[RowMetaInfo] = [];
                    
                    self.parse_dict_rows_apply(section_dict: section_dict!, block: { (row_dict, error) in
                        
                        if row_dict != nil && error == nil
                        {
                            let type_row:String? = row_dict![ParserKeys.type.rawValue] as? String;
                            let cell_dict:[String:Any]? = row_dict![ParserKeys.cell.rawValue] as? [String:Any];
                            
                            if type_row != nil && cell_dict != nil
                            {
                                let cell_meta_info:CellMetaInfo? = self.create_cell_meta_info_with_cell_dict(cell_dict: cell_dict!);
                                
                                if cell_meta_info != nil
                                {
                                    let row_meta_info:RowMetaInfo = RowMetaInfo(type: type_row!, value: nil, cell: cell_meta_info!);
                                    rows_meta_info.append(row_meta_info);
                                }
                            }
                        }
                        
                    })
                
                    
                    let section_meta_info:SectionMetaInfo = SectionMetaInfo(type: type_section!, rows: rows_meta_info, header: nil, footer: nil);
                    sections_meta_info.append(section_meta_info);
                }
            }
            
        })
        
        return sections_meta_info;
    }
    
    
    func parse_dict_sections_apply(json:[String:Any], block:(_ section_dict:[String:Any]?, _ error:FormConstructorError?)->Void)
    {
        let sections:Array<Any>? = json[ParserKeys.sections.rawValue] as? Array<Any>;
        
        guard sections != nil else {
            return block(nil, FormConstructorError.sectionsArrayFailFormat);
        }
        
        for section in sections!
        {
            if let cast_section:[String:AnyObject] = section as? [String:AnyObject]{
                block(cast_section, nil);
            }
            else{
                block(nil, FormConstructorError.sectionFailFormat);
            }
        }
    }
    
    func parse_dict_rows_apply(section_dict:[String:Any], block:(_ row_dict:[String:Any]?, _ error:FormConstructorError?)->Void)
    {
        let rows:Array<Any>?  = section_dict[ParserKeys.rows.rawValue] as? Array<Any>;
        
        guard rows != nil else {
            return block(nil, FormConstructorError.rowsArrayFailFormat)
        }
        
        
        for row in rows!
        {
            if let cast_row:[String:AnyObject] = row as? [String:AnyObject]{
                block(cast_row, nil);
            }
            else{
                block(nil, FormConstructorError.rowFailFormat);
            }
            
        }
    }
    
    func create_cell_meta_info_with_cell_dict(cell_dict:[String:Any]) -> CellMetaInfo?
    {
        var cell_meta_info:CellMetaInfo?;
        
        
        if let create_type_dict:[String:Any] = cell_dict[ParserKeys.create_type.rawValue] as?  [String:Any]
        {
            if let nib_info_dict:[String:Any] = create_type_dict[ParserKeys.nib.rawValue] as?  [String:Any]
            {
                let nib_name_cell:String? = nib_info_dict[ParserKeys.nib_name.rawValue] as? String
                let reuse_id:String? = nib_info_dict[ParserKeys.reuse_id.rawValue] as? String;
                
                let height_cell:CGFloat?  = nib_info_dict[ParserKeys.height.rawValue] as? CGFloat;
                
                if nib_name_cell != nil && reuse_id != nil
                {
                    cell_meta_info = CellMetaInfo(create_type: CellTableCreateType.nib(nib_name: nib_name_cell!, reuse_id: reuse_id!), height:height_cell);
                }
            }
        }
        
        return cell_meta_info;
    }

}




//
//  SectionMetaInfo.swift
//  WriteMe
//
//  Created by Alexey Ivankov on 22.12.16.
//  Copyright © 2016 Alexey Ivankov. All rights reserved.
//

import Foundation

public struct SectionMetaInfo : Hashable
{
    
    public var type:String;
    public let rows:[RowMetaInfo];
    public var header:HeaderMetaInfo?;
    public var footer:FooterMetaInfo?;
    
    //Hashable
    public var hashValue: Int
    
    init(type:String, rows:[RowMetaInfo], header:HeaderMetaInfo?, footer:FooterMetaInfo?)
    {
        self.type = type;
        self.rows = rows;
        self.header = header;
        self.footer = footer;
        self.hashValue = type.hashValue;
    }
    
    
    public static func ==(lhs: SectionMetaInfo, rhs: SectionMetaInfo) -> Bool {
        return lhs.type == rhs.type;
    }
}

extension Array
{
    func section(type:String) -> SectionMetaInfo?
    {
        var search_section:SectionMetaInfo? = nil;
        
        for section in self
        {
            if let cast_section:SectionMetaInfo = section as? SectionMetaInfo
            {
                if cast_section.type == type
                {
                    search_section = cast_section;
                    break;
                }
            }
        }
        
        return search_section;
    }
}

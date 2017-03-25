//
//  RowMetaInfo.swift
//  WriteMe
//
//  Created by Alexey Ivankov on 22.12.16.
//  Copyright © 2016 Alexey Ivankov. All rights reserved.
//

import Foundation

public struct RowMetaInfo : Hashable
{
    public var type:String;
    public var value:AnyObject?;
    public var cell:CellMetaInfo;
    
    //Hashable
    public var hashValue: Int
    
    init(type:String, value:AnyObject? = nil, cell:CellMetaInfo)
    {
        self.type = type;
        self.value = value;
        self.cell = cell;
        self.hashValue = self.type.hashValue;
    }
    
    
    public static func ==(lhs: RowMetaInfo, rhs: RowMetaInfo) -> Bool {
        return lhs.type == rhs.type;
    }
}


extension Array
{
    func row(type:String) -> RowMetaInfo?
    {
        var search_row:RowMetaInfo? = nil;
        
        for row in self
        {
            if let cast_row:RowMetaInfo = row as? RowMetaInfo
            {
                if cast_row.type == type
                {
                    search_row = cast_row;
                    break;
                }
            }
        }
        
        return search_row;
    }
}

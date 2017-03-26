//
//  CellMetaInfo.swift
//  WriteMe
//
//  Created by Alexey Ivankov on 22.12.16.
//  Copyright © 2016 Alexey Ivankov. All rights reserved.
//

import Foundation
import UIKit


public struct CellMetaInfo
{
    public var create_type:TypeCreate<UITableViewCell.Type>
    public var height:CGFloat? = nil;
    
    init (create_type:TypeCreate<UITableViewCell.Type>, height:CGFloat? = nil){
        self.create_type = create_type;
        self.height = height;
    }
}

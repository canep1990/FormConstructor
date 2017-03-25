//
//  TableControllerTypes.swift
//  WriteMe
//
//  Created by Alexey Ivankov on 14.12.16.
//  Copyright © 2016 Alexey Ivankov. All rights reserved.
//

import Foundation
import UIKit


public enum FormConstructorError : Error
{
    case serializedjJsonFailed
    case sectionsArrayFailFormat
    case sectionFailFormat
    case rowsArrayFailFormat
    case rowFailFormat
}


public enum HeaderSectionCreateType
{
    case nib(nib_name:String, reuse_id:String)
    case code(type:UITableViewHeaderFooterView.Type, reuse_id:String)
}

public enum FooterSectionCreateType
{
    case nib(nib_name:String, reuse_id:String)
    case code(type:UITableViewHeaderFooterView.Type, reuse_id:String)
}

public enum CellTableCreateType
{
    case nib(nib_name:String, reuse_id:String)
    case code(type:UITableViewCell.Type, reuse_id:String)
}

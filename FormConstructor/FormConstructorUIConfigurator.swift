//
//  FormConstructorUIConfigurator.swift
//  FormConstructor
//
//  Created by Alexey Ivankov on 25.03.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation
import UIKit

public protocol FormConstructorUIConfigurator
{
    func configureCell(cell:UITableViewCell, value:AnyObject?);
    func typeCreateCell(rowType: String, sectionType: String) -> CellTableCreateType;
    func heightCell(sectionType:String, rowType:String) -> CGFloat;
    
    func heightHeader(sectionType:String) -> CGFloat;
    func titleHeader(sectionType:String) -> String?;
    func typeCreateHeader(sectionType: String) -> HeaderSectionCreateType?;
    
    func heightFooter(sectionType:String) -> CGFloat;
    func typeCreateFooter(sectionType: String) -> FooterSectionCreateType?;
}

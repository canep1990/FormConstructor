//
//  FormCostructorDataSource.swift
//  FormConstructor
//
//  Created by Alexey Ivankov on 25.03.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation


public protocol FormConstructorDataSource : class
{
    func countSections() -> Int;
    func countRows(sectionType:String) -> Int;
    
    func sectionType(index:Int) -> String;
    func rowType(index:Int, sectionType:String) -> String;
    func rowValue(index:Int, sectionType:String) -> AnyObject?;
}

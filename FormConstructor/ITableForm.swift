//
//  ITableForm.swift
//  FormConstructor
//
//  Created by Alexey Ivankov on 18.04.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation
import UIKit

public protocol ITableForm : TableFormBuildInfo, TableFormConfigure
{
    var tableView:UITableView { get }
    
    func configure();
}

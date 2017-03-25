//
//  UITableView+RegistelCell.swift
//  WriteMe
//
//  Created by Alexey Ivankov on 29.11.16.
//  Copyright © 2016 Alexey Ivankov. All rights reserved.
//

import Foundation
import UIKit

extension UITableView
{
    func registerCell(reuseId:String, nibName:String)
    {
        let nib = UINib(nibName: nibName, bundle: nil)
        self.register(nib, forCellReuseIdentifier: reuseId);
    }
    
    func registerCell(type:UITableViewCell.Type, reuse_id:String){
        self.register(type, forCellReuseIdentifier: reuse_id);
    }

    func registerHeaderFooter(reuseId:String, nibName:String)
    {
        let nib = UINib(nibName: nibName, bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: reuseId);
    }
    
    func registerHeaderFooter(type:UITableViewHeaderFooterView.Type, reuse_id:String){
        self.register(type, forHeaderFooterViewReuseIdentifier: reuse_id);
    }
    
    
    
    func dequeAndRegisterCell(type:TypeRegistration<UITableViewCell.Type>) -> UITableViewCell?
    {
        var cell:UITableViewCell?;
        
        switch type
        {
        case let .nib(nib_name, reuse_id):
            cell = self.dequeueReusableCell(withIdentifier: reuse_id);
            
            if cell == nil {
                self.registerCell(reuseId: reuse_id, nibName: nib_name)
            }
            
            cell = self.dequeueReusableCell(withIdentifier: reuse_id);
            
            break;
            
            
        case let .code(type, reuse_id):
            cell = self.dequeueReusableCell(withIdentifier: reuse_id);
            
            if cell == nil{
                self.registerCell(type: type, reuse_id: reuse_id);
            }
            
            cell = self.dequeueReusableCell(withIdentifier: reuse_id);
            
            break;
        }
        
        return cell;
    }
    
    
    func dequeAndRegisterHeaderFooter(type:TypeRegistration<UITableViewHeaderFooterView.Type>) -> UITableViewHeaderFooterView?
    {
        var header_footer:UITableViewHeaderFooterView?;
        
        switch type
        {
        case let .nib(nib_name, reuse_id):
            header_footer = self.dequeueReusableHeaderFooterView(withIdentifier: reuse_id);
            
            if header_footer == nil {
                self.registerHeaderFooter(reuseId: reuse_id, nibName: nib_name);
            }
            
            header_footer = self.dequeueReusableHeaderFooterView(withIdentifier: reuse_id);
            
            break;
            
            
        case let .code(type, reuse_id):
             header_footer = self.dequeueReusableHeaderFooterView(withIdentifier: reuse_id);
            
            if header_footer == nil{
                self.registerHeaderFooter(type: type, reuse_id: reuse_id);
            }
             
             header_footer = self.dequeueReusableHeaderFooterView(withIdentifier: reuse_id);
            
            break;
        }
        
        return header_footer;
    }
}



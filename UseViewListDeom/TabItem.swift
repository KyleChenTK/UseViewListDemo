//
//  TabItem.swift
//  UseViewListDeom
//
//  Created by Kyle Chen on 2022/6/27.
//

import Cocoa

class TabItem: NSCollectionViewItem {
    
    @IBOutlet weak var tabBackView: ColoredView!
    @IBOutlet weak var tabName: NSTextField!
    
    override var isSelected: Bool {
        didSet {
            
            super.isSelected = isSelected
            
            self.tabBackView.backgroundColor = self.isSelected ? .red : .lightGray
            
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBackView.backgroundColor = .lightGray
       
    }
    
}

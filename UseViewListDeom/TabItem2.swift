//
//  TabItem2.swift
//  UseViewListDeom
//
//  Created by Kyle Chen on 2022/6/28.
//

import Cocoa

class TabItem2: NSCollectionViewItem {

    @IBOutlet weak var tabBackView: ColoredView!
    
    @IBOutlet weak var tabName: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBackView.backgroundColor = .lightGray
       
    }
    
}

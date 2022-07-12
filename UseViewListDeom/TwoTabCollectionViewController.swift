//
//  TwoTabCollectionViewController.swift
//  UseViewListDeom
//
//  Created by Kyle Chen on 2022/6/28.
//

import Cocoa

class TwoTabCollectionViewController: NSViewController {

    @IBOutlet weak var tabCollectionView: NSCollectionView!
    
    var displays = [String]()
    
    let registeredType = NSPasteboard.PasteboardType.string
    
    private var indexPathsOfItemsBeingDragged: Set<IndexPath>!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        self.registerCollectionView()
    }
    
    private func registerCollectionView() {
        
        self.tabCollectionView.register(TabItem2.self,
                                        forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "TabItem2"))
        
        self.tabCollectionView.registerForDraggedTypes([self.registeredType])
        
        self.tabCollectionView.setDraggingSourceOperationMask(.move, forLocal: true)
        
    }
    
}

extension TwoTabCollectionViewController: NSCollectionViewDataSource {
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.displays.count
    
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        let tabItem = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "TabItem2"), for: indexPath) as! TabItem2
        
        tabItem.tabName.stringValue = self.displays[indexPath.item]
        
        return tabItem
        
    }
    
}

extension TwoTabCollectionViewController: NSCollectionViewDelegate {

    func collectionView(_ collectionView: NSCollectionView, canDragItemsAt indexPaths: Set<IndexPath>, with event: NSEvent) -> Bool {
        
        return true
        
    }
    
    func collectionView(_ collectionView: NSCollectionView,
                        draggingSession session: NSDraggingSession,
                        willBeginAt screenPoint: NSPoint,
                        forItemsAt indexPaths: Set<IndexPath>) {
        
        self.indexPathsOfItemsBeingDragged = indexPaths
        
    }
    
    func collectionView(_ collectionView: NSCollectionView,
                        draggingSession session: NSDraggingSession,
                        endedAt screenPoint: NSPoint,
                        dragOperation operation: NSDragOperation) {
        
        self.indexPathsOfItemsBeingDragged = nil
        
    }
    
    func collectionView(_ collectionView: NSCollectionView,
                        validateDrop draggingInfo: NSDraggingInfo,
                        proposedIndexPath proposedDropIndexPath: AutoreleasingUnsafeMutablePointer<NSIndexPath>,
                        dropOperation proposedDropOperation: UnsafeMutablePointer<NSCollectionView.DropOperation>) -> NSDragOperation {
        
        if proposedDropOperation.pointee == .on { return NSDragOperation.move }
        
        return []
        
    }
    
    func collectionView(_ collectionView: NSCollectionView,
                        acceptDrop draggingInfo: NSDraggingInfo,
                        indexPath: IndexPath,
                        dropOperation: NSCollectionView.DropOperation) -> Bool {
       
        let pasteboard = draggingInfo.draggingPasteboard
        
        guard
            let sourceStr = pasteboard.string(forType: self.registeredType),
            let source = draggingInfo.draggingSource as? NSCollectionView
            else { return false }
        
        if source != self.tabCollectionView {
            
            print(sourceStr)

        }

        return true
        
    }
    
}

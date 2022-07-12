//
//  OneTabCollectionViewController.swift
//  UseViewListDeom
//
//  Created by Kyle Chen on 2022/6/27.
//

import Cocoa

protocol SelectGroupDelegate {
    
    func selectViewController(tag: Int,selectIndex: Int,state: NSControl.StateValue)
    
}


class OneTabCollectionViewController: NSViewController {
    
    @IBOutlet weak var tabCollectionView: NSCollectionView!
    
    @IBOutlet weak var expandCondensationBtn: NSButton!
    
    var selectGroupDelegate: SelectGroupDelegate?
    
    var groupA = [String]()
    
    var selectIndex: Int?
    
    let registeredType = NSPasteboard.PasteboardType.string
    
    private var indexPathsOfItemsBeingDragged: Set<IndexPath>!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        self.registerCollectionView()
    }
    
    private func registerCollectionView() {
        
        self.tabCollectionView.register(TabItem.self,
                                        forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "TabItem"))
        
        self.tabCollectionView.registerForDraggedTypes([self.registeredType])
        
        self.tabCollectionView.setDraggingSourceOperationMask(.move, forLocal: true)
        
        self.tabCollectionView.selectItems(at: [IndexPath(item: 0, section: 0)],
                                           scrollPosition: .centeredHorizontally)
        
    }
    
    @IBAction func deleteAndExpandCondensation(_ sender: Any) {
        
        guard let button = sender as? NSButton else { return }

        guard let index = self.selectIndex else { return }
        
        self.selectGroupDelegate?.selectViewController(tag: button.tag, selectIndex: index, state: button.state)
        
    }
    
}

extension OneTabCollectionViewController: NSCollectionViewDataSource {
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.groupA.count
    
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        let tabItem = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "TabItem"), for: indexPath) as! TabItem
        
        tabItem.tabName.stringValue = self.groupA[indexPath.item]
        
        return tabItem
        
    }
    
}

extension OneTabCollectionViewController: NSCollectionViewDelegate {

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
                        pasteboardWriterForItemAt indexPath: IndexPath) -> NSPasteboardWriting? {
        
        let pbItem = NSPasteboardItem()
        
        pbItem.setString(self.groupA[indexPath.item], forType: self.registeredType)
       
        return pbItem
    }

    func collectionView(_ collectionView: NSCollectionView,
                        validateDrop draggingInfo: NSDraggingInfo,
                        proposedIndexPath proposedDropIndexPath: AutoreleasingUnsafeMutablePointer<NSIndexPath>,
                        dropOperation proposedDropOperation: UnsafeMutablePointer<NSCollectionView.DropOperation>) -> NSDragOperation {
        
        return NSDragOperation.move
        
    }
    
    func collectionView(_ collectionView: NSCollectionView,
                        acceptDrop draggingInfo: NSDraggingInfo,
                        indexPath: IndexPath,
                        dropOperation: NSCollectionView.DropOperation) -> Bool {
       
        for fromIndexPath in self.indexPathsOfItemsBeingDragged {

            let temp = self.groupA.remove(at: fromIndexPath.item)
            
            var currentIndexPath = IndexPath(item: indexPath.item,
                                             section: indexPath.section)

            currentIndexPath.item = fromIndexPath < indexPath ? (currentIndexPath.item - 1) : currentIndexPath.item
            
            self.groupA.insert(temp, at: currentIndexPath.item)
            
            self.tabCollectionView.animator().moveItem(at: fromIndexPath, to: currentIndexPath)
            
        }
        
        return true
        
    }
    
}

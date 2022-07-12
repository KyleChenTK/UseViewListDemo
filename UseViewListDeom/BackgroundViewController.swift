//
//  ViewController.swift
//  UseViewListDeom
//
//  Created by Kyle Chen on 2022/6/27.
//

import Cocoa

class BackgroundViewController: NSViewController {
    
    @IBOutlet weak var myScrollContentView: NSView!
    
    @IBOutlet weak var displayGroupsView: NSView!
    
    var a = [["Apple", "Banana", "Grape", "Peach","Gomi", "Hoge", "Piyo","Apple", "Banana", "Grape", "Peach","Gomi", "Hoge", "Piyo","Apple", "Banana", "Grape", "Peach","Gomi", "Hoge", "Piyo","Apple", "Banana", "Grape", "Peach","Gomi", "Hoge", "Piyo"],["Apple", "Banana", "Grape", "Peach"],["Apple"],["Apple", "Banana", "Grape", "Peach"],["Apple", "Banana", "Grape", "Peach"],["Apple", "Banana", "Grape", "Peach"],["Apple", "Banana", "Grape", "Peach"],["Apple", "Banana", "Grape", "Peach"],["Apple", "Banana", "Grape", "Peach"],["Apple", "Banana", "Grape", "Peach"],["Apple", "Banana", "Grape", "Peach"],["Apple", "Banana", "Grape", "Peach"]]
    
    var canvasGroups = [[String]](){
        
        didSet{
            
            self.removeAllGroupView()
            
            self.createAllGroupView()
            
        }
        
    }
    
    var displayList = ["Apple", "Banana", "Grape", "Peach","Gomi", "Hoge", "Piyo","Apple"]
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.canvasGroups = self.a
    
        self.generateDisplayTab(displays: self.displayList)
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    private func createAllGroupView() {
        
        for index in 0..<self.canvasGroups.count {
            
            let groupView = NSView(frame: .zero)
            
            self.myScrollContentView.addSubview(groupView)
        
            let oneTabCollectionViewController = NSStoryboard.main?.instantiateController(withIdentifier: "OneTabCollectionViewController") as! OneTabCollectionViewController
          
            oneTabCollectionViewController.groupA = self.canvasGroups[index]
            
            oneTabCollectionViewController.selectIndex = index
            
            oneTabCollectionViewController.selectGroupDelegate = self
            
            self.addChild(oneTabCollectionViewController)

            oneTabCollectionViewController.view.frame = groupView.bounds

            oneTabCollectionViewController.view.autoresizingMask = [.height, .width]

            groupView.addSubview(oneTabCollectionViewController.view)
            
            groupView.translatesAutoresizingMaskIntoConstraints = false
            
            var constriants = [NSLayoutConstraint]()

            constriants.append(groupView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10))

            constriants.append(groupView.topAnchor.constraint(equalTo: index < 1 ? self.myScrollContentView.topAnchor : self.myScrollContentView.subviews[index].bottomAnchor, constant: 70))

            constriants.append(groupView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7))
            
            constriants.append(groupView.heightAnchor.constraint(equalToConstant: 200))
            
            NSLayoutConstraint.activate(constriants)
            
        }
       
        //self.myScrollContentView.frame.size.height = CGFloat(self.canvasGroups.count * 300)
        
    }
    
    private func removeAllGroupView() {
        
        guard self.myScrollContentView.subviews.count > 1 else { return }
        
        self.myScrollContentView.subviews.removeSubrange(1...)
        
        self.children.removeAll()
        
    }
    
    private func expandAndCondensation(index:Int,state: NSControl.StateValue) {
        
        self.myScrollContentView.subviews[index+1].constraints.filter({ $0.firstAttribute == .height && $0.firstItem as! NSObject == self.myScrollContentView.subviews[index+1] }).first!.isActive = false
        
        self.myScrollContentView.subviews[index+1].heightAnchor.constraint(equalToConstant: state == .on ? 50 : 200).isActive = true
       
    }

    private func generateDisplayTab(displays: [String]) {
        
        let twoTabCollectionViewController = NSStoryboard.main?.instantiateController(withIdentifier: "TwoTabCollectionViewController") as! TwoTabCollectionViewController

        twoTabCollectionViewController.displays = displays

        self.addChild(twoTabCollectionViewController)

        twoTabCollectionViewController.view.frame = self.displayGroupsView.bounds

        twoTabCollectionViewController.view.autoresizingMask = [.height, .width]

        self.displayGroupsView.addSubview(twoTabCollectionViewController.view)
        
    }
    
    @IBAction func add(_ sender: Any) {
        
        self.canvasGroups.insert(["新增"], at: 0)
        
    }
    
}

extension BackgroundViewController: SelectGroupDelegate {
    
    func selectViewController(tag: Int,selectIndex: Int,state: NSControl.StateValue) {
        
        switch tag {
            case 1:
            self.canvasGroups.remove(at: selectIndex)
            case 2:
            self.expandAndCondensation(index: selectIndex, state: state)
            default:
                return
        }
        
    }

}

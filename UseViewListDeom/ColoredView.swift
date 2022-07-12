//
//  ColoredView.swift
//  UseViewListDeom
//
//  Created by Kyle Chen on 2022/6/27.
//
import Cocoa

//@IBDesignable
class ColoredView: NSView {

    @IBInspectable var backgroundColor: NSColor = .windowBackgroundColor {
        
        didSet {
            
            self.needsDisplay = true
            
        }
        
    }
    
    override func draw(_ dirtyRect: NSRect) {
        
        super.draw(dirtyRect)
        
        self.backgroundColor.setFill()
        
        self.bounds.fill()
        
    }
    
}

extension NSColor {
    convenience init(hex: Int, alpha: Double = 1.0) {
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0xFF00) >> 8) / 255.0
        let blue = Double((hex & 0xFF)) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

class HiddenScroller: NSScroller {

    // @available(macOS 10.7, *)
    // let NSScroller tell NSScrollView that its own width is 0, so that it will not really occupy the drawing area.
    override class func scrollerWidth(for controlSize: ControlSize, scrollerStyle: Style) -> CGFloat {
        0
    }
    
}

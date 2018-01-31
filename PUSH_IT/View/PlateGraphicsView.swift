//
//  PlateGraphicsView.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/31/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit

class PlateGraphicsView: UIView {
    
    var plates = [Int]()
    
    
    let width45: CGFloat = 25
    let width35: CGFloat = 20
    let width25: CGFloat = 15
    let width10: CGFloat = 12
    let width5: CGFloat = 8
    let width2: CGFloat = 5

    override func draw(_ rect: CGRect) {
        // Drawing code
        let height = self.frame.height
        let width = self.frame.width
        
        
        
        
        drawBar(height: height, width: width)
        
        let startX = self.frame.width / 2
        var currX = startX
        
        for plate in plates {

            switch plate {
            case 45:
                drawPlate(start: currX, size: 45, frameHeight: self.frame.height)
                currX += CGFloat(width45)
            case 35:
                drawPlate(start: currX, size: 35, frameHeight: self.frame.height)
                currX += CGFloat(width35)
            case 25:
                drawPlate(start: currX, size: 25, frameHeight: self.frame.height)
                currX += CGFloat(width25)
            case 10:
                drawPlate(start: currX, size: 10, frameHeight: self.frame.height)
                currX += CGFloat(width10)
            case 5:
                drawPlate(start: currX, size: 5, frameHeight: self.frame.height)
                currX += CGFloat(width5)
            case 2:
                drawPlate(start: currX, size: 2, frameHeight: self.frame.height)
            default:
                return
            }
        }
    }
    
    func drawPlate(start: CGFloat, size: Int, frameHeight: CGFloat) {
        let height45 = 7 * self.frame.height/8
        let height35 = 3 * self.frame.height/4
        let height25 = self.frame.height/2
        let height10 = self.frame.height/3
        let height5 = self.frame.height/4
        let height2 = self.frame.height/6
        
        switch size {
        case 45:
            drawRectangle(from: CGPoint(x: start, y: frameHeight / 2 - height45 / 2), to: CGPoint(x: start + width45, y: frameHeight / 2 + height45 / 2), color: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
        case 35:
            drawRectangle(from: CGPoint(x: start, y: frameHeight / 2 - height35 / 2), to: CGPoint(x: start + width35, y: frameHeight / 2 + height35 / 2), color: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
        case 25:
            drawRectangle(from: CGPoint(x: start, y: frameHeight / 2 - height25 / 2), to: CGPoint(x: start + width25, y: frameHeight / 2 + height25 / 2), color: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1))
        case 10:
            drawRectangle(from: CGPoint(x: start, y: frameHeight / 2 - height10 / 2), to: CGPoint(x: start + width10, y: frameHeight / 2 + height10 / 2), color: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
        case 5:
            drawRectangle(from: CGPoint(x: start, y: frameHeight / 2 - height5 / 2), to: CGPoint(x: start + width5, y: frameHeight / 2 + height5 / 2), color: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
        case 2:
            drawRectangle(from: CGPoint(x: start, y: frameHeight / 2 - height2 / 2), to: CGPoint(x: start + width2, y: frameHeight / 2 + height2 / 2), color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
        default:
            return
        }
        
    }
    
    func drawBar(height: CGFloat, width: CGFloat) {
        let start = CGPoint(x: 0, y: height/2 - 4)
        let end = CGPoint(x: width/2, y: height/2 + 4)
        drawRectangle(from: start, to: end, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        drawRectangle(from: CGPoint(x: width/2 - 8, y: height/2 - 12), to: CGPoint(x: width/2 + 8, y: height/2 + 12), color: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
        drawRectangle(from: CGPoint(x: width/2, y: height/2 - 8), to: CGPoint(x: 3 * width/4, y: height/2 + 8), color: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
    }
    
    func drawRectangle(from: CGPoint, to: CGPoint, color: CGColor) {
        let startX = from.x
        let startY = from.y
        let endX = to.x
        let endY = to.y
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: startX, y: startY))
        path.addLine(to: CGPoint(x: startX, y: endY))
        path.addLine(to: CGPoint(x: endX, y: endY))
        path.addLine(to: CGPoint(x: endX, y: startY))
        
        path.close()
        
        let rect = CAShapeLayer()
        rect.path = path.cgPath
        rect.fillColor = color
        self.layer.addSublayer(rect)
    }
}



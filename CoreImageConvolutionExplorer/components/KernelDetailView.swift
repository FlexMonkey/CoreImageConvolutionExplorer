//
//  KernelDetailView.swift
//  CoreImageConvolutionExplorer
//
//  Created by Simon Gladman on 17/03/2016.
//  Copyright © 2016 Simon Gladman. All rights reserved.
//

import UIKit

class KernelDetailView: UIView
{
    let totalLabel: UILabel =
    {
        let label = UILabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.text = "Select Kernel";
        
        return label
    }()
    
    let labels: [UILabel] =
    {
        var array = [UILabel]()
        
        for _ in 0 ..< 49
        {
            let label = UILabel()
            
            label.backgroundColor = .darkGray
            label.textColor = .white
            label.textAlignment = .center
            label.adjustsFontSizeToFitWidth = true
            label.font = UIFont.boldSystemFont(ofSize: 20)
            
            array.append(label)
        }
        
        return array
    }()
    
    var weights: [CGFloat]?
    {
        didSet
        {
            if weights?.count != 9 && weights?.count != 25 && weights?.count != 49
            {
                fatalError("Weights array is wrong length!")
            }
            
            if let weights = weights
            {
                let total = weights.reduce(0, +)

                totalLabel.textColor = total == 0 ? UIColor.yellow : total < 0 ? UIColor.red : UIColor.black
                totalLabel.backgroundColor = total == 0 ? UIColor.darkGray : UIColor.white
                totalLabel.text = "Σ \(total)"
            }
            else
            {
                totalLabel.text = ""
            }
            
            updateWeightsGrid()
        }
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        labels.forEach
        {
            addSubview($0)
        }
        
        addSubview(totalLabel)
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateWeightsGrid()
    {
        guard let weights = weights else
        {
            return
        }
        
        var sourceIndex = 0
        
        labels.enumerated().forEach
        {
            let x = $0 % 7
            let y = $0 / 7
            
            switch weights.count
            {
            case 9:
                if x > 1 && x < 5 && y > 1 && y < 5
                {
                    $1.text = "\(weights[sourceIndex])"
                    sourceIndex += 1
                }
                else
                {
                    $1.text = ""
                }
            case 25:
                if x > 0 && x < 6 && y > 0 && y < 6
                {
                    $1.text = "\(weights[sourceIndex])"
                    sourceIndex += 1
                }
                else
                {
                    $1.text = ""
                }
            default:
                $1.text = "\(weights[$0])"
            }
        }
    }
    
    override func layoutSubviews()
    {
        let boxSide = Int(min(frame.width, frame.height) / 7)
        let boxesTop = (Int(max(frame.width, frame.height)) - (boxSide * 7)) / 2

        labels.enumerated().forEach
        {
            let x = $0 % 7
            let y = $0 / 7
            
            $1.frame = CGRect(x: x * boxSide,
                y: boxesTop + y * boxSide,
                width: boxSide,
                height: boxSide).insetBy(dx: 0.5, dy: 0.5)
        }
        
        totalLabel.frame = CGRect(x: 0, y:
            frame.height - 10 - totalLabel.intrinsicContentSize.height,
            width: frame.width,
            height: totalLabel.intrinsicContentSize.height)
    }
}

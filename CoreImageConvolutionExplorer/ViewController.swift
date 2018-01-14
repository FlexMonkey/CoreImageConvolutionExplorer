//
//  ViewController.swift
//  CoreImageConvolutionExplorer
//
//  Created by Simon Gladman on 17/03/2016.
//  Copyright © 2016 Simon Gladman. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    let kernelsTableView = KernelsTableView()
    let kernelDetailView = KernelDetailView()
    let convolutionImageViewer = ConvolutionImageViewer()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
   
        view.addSubview(kernelsTableView)
        view.addSubview(kernelDetailView)
        view.addSubview(convolutionImageViewer)
        
        kernelsTableView.addTarget(self,
                                   action: #selector(ViewController.kernelSelectionChange),
                                   for: .valueChanged)
    }
    
    @objc func kernelSelectionChange()
    {
        kernelDetailView.weights = kernelsTableView.weights
        convolutionImageViewer.weights = kernelsTableView.weights
    }
    
    override func viewDidLayoutSubviews()
    {
        let topMargin = topLayoutGuide.length
        let kernelsTableViewWidth = CGFloat(200)
        let workspaceWidth = view.frame.width - kernelsTableViewWidth
        let workspaceHeight = view.frame.height - topMargin
        
        kernelsTableView.frame = CGRect(x: 0,
            y: topMargin,
            width: kernelsTableViewWidth,
            height: workspaceHeight).insetBy(dx: 5, dy: 0)

        kernelDetailView.frame = CGRect(x: kernelsTableViewWidth,
            y: topMargin,
            width: workspaceWidth / 2,
            height: workspaceHeight).insetBy(dx: 5, dy: 0)
        
        convolutionImageViewer.frame = CGRect(x: kernelsTableViewWidth + workspaceWidth / 2,
            y: topMargin,
            width: workspaceWidth / 2,
            height: workspaceHeight).insetBy(dx: 5, dy: 0)
    }

}


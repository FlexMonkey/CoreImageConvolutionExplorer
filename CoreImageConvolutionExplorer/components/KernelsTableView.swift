//
//  KernelsTableView.swift
//  CoreImageConvolutionExplorer
//
//  Created by Simon Gladman on 17/03/2016.
//  Copyright © 2016 Simon Gladman. All rights reserved.
//

import UIKit

class KernelsTableView: UIControl
{
    let model = CoreImageConvolutionExplorerModel()
    
    let tableView: UITableView =
    {
        let tableView = UITableView(frame: CGRect.zero,
            style: UITableViewStyle.plain)

        tableView.register(UITableViewCell.self,
            forCellReuseIdentifier: "ItemRenderer")
        
        return tableView
    }()
    
    private (set) var weights: [CGFloat]?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)

        addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.reloadData()
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews()
    {
        tableView.frame = bounds
    }
}

extension KernelsTableView: UITableViewDataSource
{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return model.kernels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemRenderer",
                                                 for: indexPath)
     
        cell.textLabel?.text = model.kernels[indexPath.row].name
        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.textAlignment = .center
        
        return cell
    }
}

extension KernelsTableView: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        weights = model.kernels[indexPath.row].weights

        sendActions(for: .valueChanged)
    }
}

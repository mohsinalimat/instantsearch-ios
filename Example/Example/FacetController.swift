//
//  FacetController.swift
//  BasicDemo
//
//  Created by Guy Daher on 23/03/2017.
//  Copyright © 2017 Guy Daher. All rights reserved.
//

import Foundation
import UIKit
import InstantSearchCore
import InstantSearch

class FacetController: UIViewController, RefinementTableViewDataSource, UITableViewDataSource, UITableViewDelegate {
    
    var instantSearchBinder: InstantSearchBinder!
    @IBOutlet weak var refinementList: RefinementTableWidget!
    @IBOutlet weak var statLabel: LabelStatsWidget!
    
    var refinementViewController: RefinementViewController!
    
    override func viewDidLoad() {
        refinementViewController = RefinementViewController(table: refinementList)
        refinementList.dataSource = self
        refinementList.delegate = self
        refinementViewController.tableDataSource = self
        // refinementViewController.tableDelegate = self
        
        instantSearchBinder = AlgoliaSearchManager.instance.instantSearchBinder
        instantSearchBinder.add(widget: refinementList)
        instantSearchBinder.add(widget: statLabel)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refinementViewController.tableView(tableView, numberOfRowsInSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return refinementViewController.tableView(tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return refinementViewController.tableView(tableView, didSelectRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("Hello Height!")
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, containing facet: String, with count: Int, is refined: Bool) -> UITableViewCell {
        let cell = refinementList.dequeueReusableCell(withIdentifier: "facetCell", for: indexPath)
        
        cell.textLabel?.text = facet
        cell.detailTextLabel?.text = String(count)
        cell.accessoryType = refined ? .checkmark : .none
        
        return cell
    }
}

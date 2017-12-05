//
//  OutputHistoryViewController.swift
//  APPdentify
//
//  Created by Michael Castillo on 11/7/17.
//  Copyright © 2017 Michael Castillo. All rights reserved.
//

import UIKit

class OutputHistoryViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let imagePickerManager = ImagePickerManager()
    fileprivate let core = App.sharedCore
    fileprivate var predictions: [ImagePrediction] {
        return core.state.currentPredictions
    }
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        core.add(subscriber: self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        core.remove(subscriber: self)
    }
    
    // MARK: - IBActions
    
    @IBAction func imageViewTapped(_ sender: Any) {
        imagePickerManager.presentPickerAlert(on: self)
    }
   
}


// MARK: - Fileprivate

extension OutputHistoryViewController: Subscriber {
    
    // Updates our UI through the AppState
    func update(with state: AppState) {
        imageView.image = state.currentImage ?? #imageLiteral(resourceName: "photo-camera")
        tableView.reloadData()
    }
    
}


// MARK: - TableView Data Source

extension OutputHistoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return predictions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "predictionCell")!
        let prediction = predictions[indexPath.row]
        cell.textLabel?.text = prediction.predictedTitle
        let accuracyDescription = String(format: "%.4f", prediction.accuracy)
        cell.detailTextLabel?.text = accuracyDescription
        return cell
    }
    
}

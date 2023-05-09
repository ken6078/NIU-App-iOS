//
//  ViewController.swift
//  NIU App
//
//  Created by Jacky Ben on 2023/5/9.
//

import UIKit
import TensorFlowLiteTaskVision

class ViewController: UIViewController {
    
    var testLabel: UILabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let modelPath = Bundle.main.path(
            forResource: "model-meta",
            ofType: "tflite"
        ) else {
            print("ModelPathError")
            return
        }
        let options = ImageClassifierOptions(modelPath: modelPath)
        
        do {
            let classifier = try ImageClassifier.classifier(options: options)
            let image = UIImage(named: "test")!
            let mlImage = MLImage(image: image)!
            let classificationResults = try classifier.classify(mlImage: mlImage)
            print("classificationResults:", classificationResults.classifications[0].categories[0].index)
        } catch {
            print("ERROR")
            print(error)
        }
        
        
        testLabel.text = "Hello World"
        
        view.addSubview(testLabel)
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        testLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        testLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        
    }


}


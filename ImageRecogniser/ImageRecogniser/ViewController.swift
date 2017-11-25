//
//  ViewController.swift
//  ImageRecogniser
//
//  Created by Jude Molloy on 25/11/2017.
//  Copyright © 2017 Jude Molloy. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var recognisedImageView: UIImageView!
    
    @IBOutlet weak var resultsLabel: UILabel!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set attributes of imagePicker view
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // Stores the image that the user selected
        if let userSelectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            // Set image on screen to the user selected image
            recognisedImageView.image = userSelectedImage
            
            // Image is converted to be able to be used by the Vision framework and Core ML
            guard let ciimage = CIImage(image: userSelectedImage) else {
                fatalError("Could not convert to CIImage")
            }
            
            // Calls the image to be recognized
            detect(image: ciimage)
            
        }
        
        // After image is selected the camera view screen is closed user is returned to recognised image screen
        imagePicker.dismiss(animated: true, completion: nil)
        
        
    }
    
    func detect(image: CIImage) {
        
        // Creates new instance of the Inceptionv3 model
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Loading CoreML model failed")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            // Follwing is code that happens when request has been completed
            
            // Set results to the results obtained from the recognizer
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image.")
            }
            
            print(results)
            
            if let finalResult = results.first {
                // Set the label depending on results
                if finalResult.identifier.contains("pizza") {
                  self.resultsLabel.textColor = #colorLiteral(red: 0.4500938654, green: 0.9813225865, blue: 0.4743030667, alpha: 1)
                  self.resultsLabel.text = "Pizza!"
                } else {
                self.resultsLabel.textColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
                self.resultsLabel.text = "Not Pizza!"
            }
            
        }
            
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        // Try to make a request to recognize the image that has been selected
        do {
            try handler.perform([request])
        }
        catch {
            print(error)
        }
    

    }
    
    @IBAction func cameraButtonTapped(_ sender: Any) {
        
        // When camera button pressed present camera screen
        present(imagePicker, animated: true, completion: nil)
        
    }

}

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
            
        }
        
        // After image is selected the camera view screen is closed user is returned to recognised image screen
        imagePicker.dismiss(animated: true, completion: nil)
        
        
    }

    @IBAction func cameraButtonTapped(_ sender: Any) {
        
        // When camera button pressed present camera screen
        present(imagePicker, animated: true, completion: nil)
        
    }
    

}


//
//  ViewController.swift
//  ImageRecognizer
//
//  Created by Byron De Paz on 3/6/21.
//

import UIKit
import CoreML
import Vision // used to applu classification models to images

class ViewController: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    var resnetModel = Resnet50()
    var imagePicker  = UIIMagePickerController()

    @IBOutlet weak var imageView: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        if let image = imageView.image{
            classifyPicture(image: image)
        }
    }
    
    func classifyPicture(image: UIImage){
        
    }

}


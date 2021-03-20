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
    var chapter7Model = Chapter7Attempt3()
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBAction func albumTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker,animated: true, completion:nil)
    }
    
    @IBAction func photoTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBOutlet weak var imageView: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        if let image = imageView.image{
            classifyPicture(image: image)
        }
    }
    
    func classifyPicture(image: UIImage){
         // get a model reference with VNCoreML and providing resNetModel as the argument
        // VNCoreMLModel is the container for the Core ML model used in Vision
        if let model = try? VNCoreMLModel (for: resnetModel.model){
            // the model reference will create an analysis request for the image and processed through
            // the handler
            let request = VNCoreMLRequest(model: model) {(request,error) in
                if let results = request.results as? [VNClassificationObservation]{
                    let result = results[0]
                    self.navBar?.title = result.identifier
                }
            }
            // The completion handler is called when we get back information after the request has been
            // completed. then we execute it with the perform method of VNImageRequestHandler
            if let imageData = image.jpegData(compressionQuality: 1.0){
                let handler = VNImageRequestHandler(data:imageData, options:[:])
                try? handler.perform([request])
            }
        }
        
        /*
        // this should attempt to use my ML model to check the animals tested. it does not assign the label to
        // the classLabel
        if let model = try? VNCoreMLModel (for: chapter7Model.model){
            // the model reference will create an analysis request for the image and processed through
            // the handler
            let request = VNCoreMLRequest(model: model) {(request,error) in
                if let results = request.results as? [VNClassificationObservation]{
                    //print(results)
                    let result = results[0]
                    self.navBar?.title = result.identifier
                }
            }
            // The completion handler is called when we get back information after the request has been
            // completed. then we execute it with the perform method of VNImageRequestHandler
            if let imageData = image.jpegData(compressionQuality: 1.0){
                let handler = VNImageRequestHandler(data:imageData, options:[:])
                try? handler.perform([request])
            }
        } */
    }
    
    func imagePickerController(_ picker:UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let image = info[.originalImage] as? UIImage{
            imageView.image = image
            classifyPicture(image: image)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }

}


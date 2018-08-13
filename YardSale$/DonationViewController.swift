//
//  DonationViewController.swift
//  YardSale$
//
//  Created by Josh Jaslow on 11/27/16.
//  Copyright © 2016 Josh Jaslow. All rights reserved.
//

import UIKit
import os.log

class DonationViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    @IBOutlet weak var changeName: UITextField!
    @IBOutlet weak var changePrice: UITextField!
    @IBOutlet weak var changeCategory: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var comments: UITextField!
    
    var image: UIImage? = nil
    var item: Item? //Create a temporary item for adding to the table
    
    //MARK: - View functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        changeName.delegate = self
        changePrice.delegate = self
        changeCategory.delegate = self
        comments.delegate = self
        
        //Set up views if editing an existing item
        if let item = item {
            navigationItem.title = "Editing \(item.name)"
            changeName.text = item.name
            changePrice.text = String(item.price)
            changeCategory.text = item.category
            photoImageView.image = item.photo
            ratingControl.rating = item.rating
            comments.text = item.comment
        }
        
        updateSaveButtonState(textField: changeName)
    }
    
    // MARK: UITextFieldDelegate Functions
    // Open and close the keyboard when editing
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        navigationItem.title = changeName.text
        updateSaveButtonState(textField: changeName)
        updateSaveButtonState(textField: changePrice)
        updateSaveButtonState(textField: changeCategory)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    private func updateSaveButtonState(textField: UITextField) {
        // Disable the Save button if the text field is empty.
        saveButton.isEnabled = !(textField.text?.isEmpty)!
    }
    
    // MARK: UIImage Delegate and Selection
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) { //Closes photo album is cancel is pressed
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) { //Used to access photo album
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) { //Used to select picture from album
        // Hide any open keyboard
        resignResponder(textField: changeName)
        resignResponder(textField: changeCategory)
        resignResponder(textField: changePrice)
        resignResponder(textField: comments)
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        //Create an action sheet button to manage buttons for image source
        let actionSheet = UIAlertController(title: "Image Source", message: "Choose camera or your photo library", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }
            else{
                let camNotAvailable = UIAlertController(title: "Camera Not Available", message: "", preferredStyle: UIAlertControllerStyle.alert)
                camNotAvailable.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(camNotAvailable, animated: true, completion: nil)
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            // Allow an image to be used
            imagePickerController.sourceType = .photoLibrary
            //Show image
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        //Show actionSheet
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        if let owningNavController = navigationController {
            owningNavController.popViewController(animated: true)
        }
        dismiss(animated: true, completion: nil)
    }
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = changeName.text ?? ""
        let price = Double(changePrice.text!)
        let category = changeCategory.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        let comment = comments.text ?? ""
        
        // Set the item to be passed to itemTableViewController after the unwind segue.
        item = Item(name: name, price: price!, category: category, photo: photo, rating: rating, comment: comment)
    }
    
    func resignResponder(textField: UITextField){
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
    }
}

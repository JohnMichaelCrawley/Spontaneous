/*
 Project:           Spontaneous
 File:              CircularProgressBarView.swift
 Created:           01/09/2023
 Author:            John Michael Crawley
 
 Description:
 This class creates a circular progress bar to
 show the current monthly usage of the end user's
 API, for example if the user uses 90% of their
 API usage, it'll show 90% in a circular progress
 bar
 
 */
//Import List
import UIKit
//MARK: - Circular Progress Bar View Class
class CircularProgressBarView: UIView, CAAnimationDelegate
{
    // MARK: - Custom Colours
    let customColours = CustomColours()
    // MARK: - Circular Progress Bar Variables
    // First create two layer properties
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private var currentProgress: CGFloat = 0
    private var progressLabel = UILabel()
    //MARK: - Inits
    override init(frame: CGRect) 
    {
        super.init(frame: frame)
        createCircularPath()
    }
    required init?(coder aDecoder: NSCoder) 
    {
        super.init(coder: aDecoder)
        createCircularPath()
    }
    //MARK: - Create Circular Path
    func createCircularPath()
     {
         // Create the path
         let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: 140, startAngle: -.pi / 2, endAngle: 3 * .pi / 2, clockwise: true)
         // Set up the path, colour and stroke
         circleLayer.path = circularPath.cgPath
         
        
         // Check the theme of the application and set the current CG Colour
         if ThemeViewModel().returnCurrentTheme() == "dark"
         {
             circleLayer.fillColor = UIColor.black.cgColor
         }
         else if ThemeViewModel().returnCurrentTheme() == "light"
         {
            circleLayer.fillColor = UIColor.white.cgColor
         }
         

         
         
         circleLayer.lineCap = .round
         circleLayer.lineWidth = 25.0
         circleLayer.strokeColor = customColours.returnDefaultCGColour()
         progressLayer.path = circularPath.cgPath
         progressLayer.fillColor = UIColor.clear.cgColor
         progressLayer.lineCap = .round
         progressLayer.lineWidth = 25.0
         progressLayer.strokeEnd = 0
         progressLayer.strokeColor = customColours.returnSecondaryCGColour()
         layer.addSublayer(circleLayer)
         layer.addSublayer(progressLayer)
         // Calculate the position of the label
         let labelSize: CGFloat = 60
         let labelX = (frame.size.width - labelSize) / 2
         let labelY = (frame.size.height - labelSize) / 2
         // Configure the progress label
         progressLabel.frame = CGRect(x: labelX, y: labelY, width: labelSize, height: labelSize)
         progressLabel.textAlignment = .center
         progressLabel.textColor = UIColor.label
         progressLabel.font = UIFont.systemFont(ofSize: 24)
        addSubview(progressLabel)
    }
    //MARK: - Progress Animation
    func progressAnimation(duration: TimeInterval, stopPercentage: CGFloat)
    {
        // Create the progress animation
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = stopPercentage
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        circularProgressAnimation.delegate = self
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
        // Create a number formatter to show the percentage
        let percentageFormatter = NumberFormatter()
        percentageFormatter.numberStyle = .percent
        percentageFormatter.maximumFractionDigits = 0
        if let formattedPercentage = percentageFormatter.string(from: NSNumber(value: Double(stopPercentage))) 
        {
            progressLabel.text = formattedPercentage
        }
        // Store the target stopPercentage
        currentProgress = stopPercentage
        // Create a CADisplayLink to update the label text
        let displayLink = CADisplayLink(target: self, selector: #selector(updateLabel))
        displayLink.add(to: .main, forMode: .default)
      }
    //MARK: - Upgate Label
    @objc private func updateLabel() 
    {
        let step = 0.01 // Adjust the step size as needed
        if currentProgress > progressLayer.strokeEnd 
        {
            progressLayer.strokeEnd += CGFloat(step)
            // Create a number formatter to show the percentage
            let percentageFormatter = NumberFormatter()
            percentageFormatter.numberStyle = .percent
            percentageFormatter.maximumFractionDigits = 0
            if let formattedPercentage = percentageFormatter.string(from: NSNumber(value: Double(progressLayer.strokeEnd))) 
            {
                progressLabel.text = formattedPercentage
            }
        } 
        else
        {
            // Animation finished, reset the display link
            progressLabel.text = "\(Int(currentProgress * 100))%"
        }
    }
}

//
//  ViewController.swift
//  MyMetalView
//
//  Created by Brian Jones on 4/30/16.
//  Copyright © 2016 Brian Jones. All rights reserved.
//

import UIKit
import Metal
import MetalKit

class ViewController: UIViewController, MTKViewDelegate {
    
    var device: MTLDevice! = nil
    var commandQueue: MTLCommandQueue! = nil
    var library: MTLLibrary! = nil
    var myView: MTKView! = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupMetal()
        setupView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawInMTKView(view: MTKView) {
        //
        
        let cb = commandQueue.commandBuffer()
        let rpd = view.currentRenderPassDescriptor
        
        rpd?.colorAttachments[0].loadAction = .Clear
        rpd?.colorAttachments[0].storeAction = .Store
        rpd?.colorAttachments[0].clearColor
        rpd?.depthAttachment.loadAction = .Clear
        rpd?.depthAttachment.storeAction = .DontCare
        
        let ce = cb.renderCommandEncoderWithDescriptor(rpd!)
        ce.endEncoding()
        
        
        cb.presentDrawable(view.currentDrawable!)
        cb.commit()
    }
    
    
    func mtkView(view: MTKView, drawableSizeWillChange size: CGSize) {
        // no operation
    }
    
    
    func setupMetal() {
        device = MTLCreateSystemDefaultDevice()
        commandQueue = device.newCommandQueue()
        //library = device.newDefaultLibrary()
    }
    
    func setupView() {
        myView = view as? MTKView
        myView.device = device
        myView.delegate = self
        myView.colorPixelFormat = .BGRA8Unorm
        myView.depthStencilPixelFormat = .Depth32Float_Stencil8
        myView.framebufferOnly = true
        myView.clearColor = MTLClearColor(red: 0.3, green: 0.6, blue: 0.53, alpha: 1.0)
        myView.clearDepth = 1.0
    }
    
    func configureRenderPassDescriptor(rpd: MTLRenderPassDescriptor) -> MTLRenderPassDescriptor{
        
    }
    

}


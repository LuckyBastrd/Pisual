import UIKit
import SceneKit
import SpriteKit

class SceneKitViewController: UIViewController {
    
    var sceneView = SCNView()
    var camera = SCNCamera()
    
    var noiseNode: SKSpriteNode?
    
    var sunlight = SCNLight()
    var ambientLight = SCNLight()
    
    var fStop: Double = 1.4
    var shutter: Double = 1/8000
    var iso: Double = 50
    
    let defaultFStop: Double = 1.4
    let defaultShutter: Double = 1/8000
    let defaultISO: Double = 50
    
    var timeFactor: CGFloat = 1.0
    
    let baselineSunlightIntensity: CGFloat = 5000
    let baselineAmbientIntensity: CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
        updateExposure()
        setupNoiseOverlay()
        addObserverListener()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.isPlaying = false
        
        sceneView.scene?.isPaused = true
        
        sceneView.scene = nil
        
        self.removeObserverListener()
     }
    
    private func setupScene() {
        sceneView.frame = view.bounds
        sceneView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(sceneView)
        
        let scene = SCNScene()
        
        // SkyBox setup
        let skySphere = SCNSphere(radius: 50)
        skySphere.firstMaterial?.isDoubleSided = true
        skySphere.firstMaterial?.diffuse.contents = UIImage(named: "EarthBackground")
        skySphere.firstMaterial?.lightingModel = .lambert
        skySphere.firstMaterial?.writesToDepthBuffer = false
        skySphere.firstMaterial?.isLitPerPixel = true
        
        let skyNode = SCNNode(geometry: skySphere)
        skyNode.position = SCNVector3(0, 0, 0)
        scene.rootNode.addChildNode(skyNode)
        
        // Sunlight (Directional Light)
        sunlight.type = .directional
        sunlight.intensity = baselineSunlightIntensity
        sunlight.color = UIColor.white
        sunlight.castsShadow = true
        sunlight.shadowMode = .deferred
        sunlight.shadowColor = UIColor.black.withAlphaComponent(0.4)
        sunlight.shadowRadius = 3.0
        sunlight.automaticallyAdjustsShadowProjection = true
        
        let sunlightNode = SCNNode()
        sunlightNode.light = sunlight
        sunlightNode.position = SCNVector3(0, 100, 0)
        sunlightNode.eulerAngles = SCNVector3(-Float.pi / 6, 0, 0)
        scene.rootNode.addChildNode(sunlightNode)
        
        // Ambient Light
        ambientLight.type = .ambient
        ambientLight.intensity = baselineAmbientIntensity
        ambientLight.color = UIColor.white
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = ambientLight
        scene.rootNode.addChildNode(ambientLightNode)
        
        // Camera setup
        camera.fieldOfView = 33
        camera.wantsDepthOfField = true
        camera.fStop = fStop
        camera.focusDistance = 0.5
        
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(0, 0, 15)
        scene.rootNode.addChildNode(cameraNode)
        
        // Cube object setup
        let cube = SCNNode(geometry: SCNBox(width: 3.0, height: 3.0, length: 3.0, chamferRadius: 0.1))
        cube.position = SCNVector3(0, 0, 0)
        cube.eulerAngles = SCNVector3(0.27, 0.7, 0)
        
        let cubeMaterial = SCNMaterial()
        cubeMaterial.lightingModel = .physicallyBased
        cubeMaterial.metalness.contents = 0.2
        cubeMaterial.roughness.contents = 0.8
        cubeMaterial.diffuse.contents = UIImage(named: "CubeTexture")
        cube.geometry?.firstMaterial = cubeMaterial
        
        scene.rootNode.addChildNode(cube)
        
        sceneView.scene = scene
        sceneView.allowsCameraControl = false
    }
    
    /// Sets up a SpriteKit overlay with a noise texture.
    private func setupNoiseOverlay() {
        let skScene = SKScene(size: sceneView.bounds.size)
        skScene.backgroundColor = .clear
        
        let noiseTexture = SKTexture(imageNamed: "CameraNoise")
        noiseTexture.filteringMode = .nearest
        
        let noiseSprite = SKSpriteNode(texture: noiseTexture)
        noiseSprite.size = skScene.size
        noiseSprite.position = CGPoint(x: skScene.size.width / 2, y: skScene.size.height / 2)
        noiseSprite.alpha = 0.0
        noiseSprite.zPosition = 1
        
        skScene.addChild(noiseSprite)
        sceneView.overlaySKScene = skScene
        
        self.noiseNode = noiseSprite
    }
    
    func updateExposure() { 
        // Compute brightness factor from camera exposure settings.
        let brightnessFactor = (iso / defaultISO) *
        (shutter / defaultShutter) *
        pow((defaultFStop / fStop), 2)
        
        // Multiply by the time-of-day factor.
        let combinedFactor = CGFloat(brightnessFactor) * timeFactor
        
        sunlight.intensity = baselineSunlightIntensity * combinedFactor
        ambientLight.intensity = baselineAmbientIntensity * combinedFactor
        
        // Adjust noise overlay based on ISO.
        let maximumNoiseAlpha: CGFloat = 0.5
        let noiseAlpha: CGFloat
        if iso > defaultISO {
            let normalizedISO = CGFloat(min((iso - defaultISO) / (6400 - defaultISO), 1))
            noiseAlpha = normalizedISO * maximumNoiseAlpha
        } else {
            noiseAlpha = 0
        }
        noiseNode?.alpha = noiseAlpha
    }
}

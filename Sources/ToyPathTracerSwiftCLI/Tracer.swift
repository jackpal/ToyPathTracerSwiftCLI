import ArgumentParser
import Cocoa
import Foundation
import ToyPathTracerSwift

@main
struct Tracer: ParsableCommand {
  @Option(help: "use multiple threads.")
  var threaded = true
  
  @Option(help: "width of the image.")
  var width = 960
  
  @Option(help: "height of the image.")
  var height = 494
  
  @Option(help: "number of frames to average together to create the image.")
  var frames = 1000
  
  @Option(help: "lossy compression quality level.")
  var lossyCompressionQuality = 0.76
  
  @Option(help: "output file name. (heic, jpeg, png, tiff)")
  var out = "trace.heic"

  mutating func run() throws {
    let buffer = trace(width: width, height: height, frames: frames, threaded: threaded)
    let image = createImage(buffer)
    
    let options = [kCGImageDestinationLossyCompressionQuality
                   as CIImageRepresentationOption : lossyCompressionQuality]
    let context = CIContext()
    let colorSpace = image.colorSpace!
    let filename = URL(fileURLWithPath: out)
    let pathExtension = filename.pathExtension
    switch pathExtension.lowercased() {
    case "heic","heif":
      try context.writeHEIF10Representation(of: image.settingAlphaOne(in: image.extent),
                                          to: filename,
                                          colorSpace: colorSpace,
                                          options: options)
    case "jpeg", "jpg":
      try context.writeJPEGRepresentation(of: image,
                                          to: filename,
                                          colorSpace: colorSpace,
                                          options: options)

    case "png":
      try context.writePNGRepresentation(of: image,
                                         to: filename,
                                         format: .RGBA16,
                                         colorSpace: colorSpace,
                                         options: options)
    case "tif", "tiff":
      try context.writeTIFFRepresentation(of: image,
                                         to: filename,
                                         format: .RGBA16,
                                         colorSpace: colorSpace,
                                         options: options)
    default:
      print("Unknown file extension: \(pathExtension)")
    }
  }
}

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
  
  @Option(help: "0.0 .1.0 lossy compression quality level.")
  var lossyCompressionQuality = 0.76
  
  @Option(help: "output file name")
  var out = "trace.heic"

  mutating func run() throws {
    let buffer = trace(width: width, height: height, frames: frames, threaded: threaded)
    let image = buffer.image()
    
    let context = CIContext(options: [.workingFormat: CIFormat.RGBAf])
    let filename = getDocumentsDirectory().appendingPathComponent(out)
    print("Writing to \(filename.absoluteString)")
    try context.writeHEIF10Representation(of: image.settingAlphaOne(in: image.extent),
                                        to: filename,
                                        colorSpace: image.colorSpace!,
                                        options: [kCGImageDestinationLossyCompressionQuality
                                                  as CIImageRepresentationOption : lossyCompressionQuality])
  }
}

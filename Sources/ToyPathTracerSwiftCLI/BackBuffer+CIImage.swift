import CoreImage
import ToyPathTracerSwift

extension BackBuffer {
  /// Create an Image from a BackBuffer.
  func image() -> CIImage {
    let sizeOfFloat = 4
    let bytesPerRow = sizeOfFloat * pixelStride * w
    var data = Data(count: bytesPerRow * h)
    data.withUnsafeMutableBytes { (buffer: UnsafeMutableRawBufferPointer) in
      let ptr = buffer.bindMemory(to: Float.self)
      let componentsPerScanline = pixelStride * w
      for (y, scanline) in scanlines.enumerated() {
        // Flip Y coordinate.
        var outputIndex = (h - y - 1) * componentsPerScanline
        for i in 0..<componentsPerScanline {
          ptr[outputIndex] = scanline.buffer[i]
          outputIndex += 1
        }
      }
    }
    let convertedData: NSData = data as NSData
    let dataProvider = CGDataProvider(data: convertedData)!
    let bitmapInfo: CGBitmapInfo = [
          .byteOrder32Little,
          .floatComponents,
          CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
          ]

    let colorSpace = CGColorSpace(name: CGColorSpace.extendedLinearDisplayP3)!
    let cgImage = CGImage(width: w,
                          height: h,
                          bitsPerComponent: 32,
                          bitsPerPixel: 32*pixelStride,
                          bytesPerRow: bytesPerRow,
                          space: colorSpace,
                          bitmapInfo: bitmapInfo,
                          provider: dataProvider,
                          decode: nil,
                          shouldInterpolate: false,
                          intent: .defaultIntent)!
    let ciImage = CIImage(cgImage:cgImage)
    return ciImage
  }
}

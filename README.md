# ToyPathTracerSwiftCLI

A command line interface for a toy path tracer written in Swift.

This is a companion to the blog article
[Porting a Toy Path Tracer to Swift](https://jackpal.github.io/2020/01/20/Porting_a_Toy_Path_Tracer_to_Swift.html)

## Requirements

+ MacOS 12.0
+ Swift 5.6 or later. (Xcode 13.3 or later.)

## Build

```
swift build -c release
```

## Run

```
.build/release/ToyPathTracerSwiftCLI
```

## Arguments

```
.build/release/ToyPathTracerSwiftCLI --help

USAGE: tracer [--threaded <threaded>] [--width <width>] [--height <height>] [--frames <frames>] [--lossy-compression-quality <lossy-compression-quality>] [--out <out>]

OPTIONS:
  --threaded <threaded>   use multiple threads. (default: true)
  --width <width>         width of the image. (default: 960)
  --height <height>       height of the image. (default: 494)
  --frames <frames>       number of frames to average together to create the image. (default: 1000)
  --lossy-compression-quality <lossy-compression-quality>
                          0.0 .1.0 lossy compression quality level. (default: 0.76)
  --out <out>             output file name (default: trace.heic)
  -h, --help              Show help information.
```

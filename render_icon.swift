import AppKit

let iconSize: CGFloat = 1024
let img = NSImage(size: NSSize(width: iconSize, height: iconSize))
img.lockFocus()

// Background squircle
NSColor(red: 0.961, green: 0.957, blue: 0.941, alpha: 1.0).setFill()
NSBezierPath(roundedRect: NSRect(x: 0, y: 0, width: iconSize, height: iconSize), xRadius: 200, yRadius: 200).fill()

// White inner
NSColor.white.setFill()
NSBezierPath(roundedRect: NSRect(x: 55, y: 55, width: iconSize - 110, height: iconSize - 110), xRadius: 155, yRadius: 155).fill()

// Text
let fontSize: CGFloat = 440
let font = NSFont(name: "Avenir Next Bold", size: fontSize)
       ?? NSFont(name: "HelveticaNeue-Bold", size: fontSize)
       ?? NSFont.boldSystemFont(ofSize: fontSize)
let color = NSColor(red: 0.165, green: 0.529, blue: 0.294, alpha: 1.0)
let attrs: [NSAttributedString.Key: Any] = [
    .font: font,
    .foregroundColor: color
]
let str = "MD" as NSString
let strSize = str.size(withAttributes: attrs)
let x = (iconSize - strSize.width) / 2
let y = (iconSize - strSize.height) / 2 - 10
str.draw(at: NSPoint(x: x, y: y), withAttributes: attrs)

img.unlockFocus()

// Save PNG
guard let tiff = img.tiffRepresentation,
      let rep = NSBitmapImageRep(data: tiff),
      let png = rep.representation(using: .png, properties: [:]) else {
    exit(1)
}
try! png.write(to: URL(fileURLWithPath: "/tmp/md_reader_icon.png"))
print("done")

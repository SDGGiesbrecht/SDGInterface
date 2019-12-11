
import SwiftUI

import SDGMathematics

import SDGViews

struct AspectRatio_Previews: PreviewProvider {
  static var previews: some SwiftUI.View {

    let redSquare = Ellipse()
      .fill(Color.red)

    return Group {

      redSquare
        .aspectRatio(1 ÷ 2, contentMode: .fill)
        .background(Color.blue)
        .previewLayout(.fixed(width: 124, height: 64))
        .previewDisplayName("Ratio + Fill")
      
      redSquare
        .aspectRatio(1 ÷ 2, contentMode: .fit)
        .background(Color.blue)
        .previewLayout(.fixed(width: 124, height: 64))
        .previewDisplayName("Ratio + Fit")

        redSquare
          .aspectRatio(nil, contentMode: .fill)
          .background(Color.blue)
          .previewLayout(.fixed(width: 124, height: 64))
          .previewDisplayName("nil + Fill")

        redSquare
          .aspectRatio(nil, contentMode: .fit)
          .background(Color.blue)
          .previewLayout(.fixed(width: 124, height: 64))
          .previewDisplayName("nil + Fit")
    }
  }
}

//
//  MoreRow.swift
//  Recreationalist
//
//  Created by Kimberly Govea on 3/18/21.
//

import SwiftUI

struct MoreRow: View {
    // MARK: - PROPERTIES
    
    var firstText: String
    
    // MARK: - BODY
    
    var body: some View {
        HStack {
            Text(firstText).foregroundColor(Color.black)
                .fontWeight(.semibold)
            Spacer()
        }
    }
}

// MARK:  - PREVIEW
struct MoreRow_Previews: PreviewProvider {
    static var previews: some View {
        MoreRow(firstText: "Application")
            .previewLayout(.fixed(width:375, height:60))
            .padding()
    }
}

//
//  LandmarkListView.swift
//  ChinaLandmark
//
//  Created by lizhonglian on 2020/11/28.
//

import SwiftUI

struct LandmarkListView: View {
    var body: some View {
        NavigationView{
            
            List(landmarks){ item in
                NavigationLink(destination: LandmarkDetail(item: item)){
                    LandmarkCell(lland: item)
                }
            }.navigationBarTitle(Text("中国地标"))
        }
        
       
    }
}

struct LandmarkListView_Previews: PreviewProvider {
    static var previews: some View {
//        Group{
//            LandmarkListView()
//                .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
//                .previewDisplayName(deviceName)
//            LandmarkListView()
//                .previewDevice(PreviewDevice(rawValue: "iPhone 8")))
//                .previewDisplayName(deviceName)
//        }
        
        // List 对象必须加 标识符
        ForEach(["iPhone 11","iPhone 8"], id: \.self){ deviceName in
            LandmarkListView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)

        }
        
    }
}

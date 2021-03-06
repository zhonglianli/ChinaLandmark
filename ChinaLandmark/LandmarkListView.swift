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
            
            ExtractedView(userData: UserData())
        }
    }
}

struct ExtractedView: View {
    // state 重新刷新相关view
    @State
    private var showFavOnly = false
    
    // 页面用了EnvironmentObject，类似于某个页面用了state 属性
    @ObservedObject
    var userData: UserData
    
    var body: some View {
        List() {
            //$：转化成Binding；双向绑定
            Toggle(isOn: $showFavOnly, label: {
                Text("只展示收藏")
            })
            
            // 这个地方用list 就会显示不全
            ForEach(userData.userLandmarks){ item in
                // 逻辑或的短路效果；和上面的效果相同
                if !self.showFavOnly || item.isFavourite {
                    NavigationLink(destination:
                                    LandmarkDetail(item: item,userData: userData)){
                        LandmarkCell(lland: item)
                    }
                }
                
            }
            
        }
        .navigationBarTitle(Text("中国地标"))
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
        ForEach(["iPhone 11"], id: \.self){ deviceName in
            LandmarkListView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)

        }.environmentObject(UserData())
        
    }
}

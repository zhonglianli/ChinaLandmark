//
//  ContentView.swift
//  ChinaLandmark
//
//  Created by lizhonglian on 2020/11/28.
//

import SwiftUI

struct LandmarkDetail: View {
    
    let item : Landmark
    
    @ObservedObject
    var userData:UserData
    
    // 计算属性
    var landmarkIndex : Int {
        userData.userLandmarks.firstIndex(where: {
            $0.id == item.id
        })!
    }
    
    var body: some View {
        
        VStack{
            // 地图
            MapView(center: item.locationCoordinate)
                //忽略顶端的安全区
                .edgesIgnoringSafeArea(.top)
                .frame(height:500)

            // 圆形标志图
            Image(item.imageName)
                .resizable()
                .frame(width: 250, height: 250, alignment: .center)
                //裁剪成圆形的view
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/, style: FillStyle())
                // 描边，stroke 抽空
                .overlay(Circle().stroke(Color.white,lineWidth: 6))
                // 阴影
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                //上拉
                .offset(x: 0, y: -130)
                // 去除下方的空白占位
                .padding(.bottom,-130)
            
            VStack(alignment: .leading, spacing: 8){
                HStack{
                    Text(item.name).font(.title)
                    Button(action: {
                        self.userData.userLandmarks[self.landmarkIndex].isFavourite.toggle()
                    }) {
                        if self.userData.userLandmarks[self.landmarkIndex].isFavourite{
                            Image(systemName: "star.fill").foregroundColor(.yellow)
                        } else{
                            Image(systemName: "star").foregroundColor(.gray)
                        }
                    }
                }
                
                HStack{
                    Text(item.city).font(.subheadline)
                    // 水平布局中，把2个对象推开
                    Spacer()
                    Text(item.province).font(.subheadline)
                }
            }.padding()
        
            Spacer()
            
        }.navigationBarTitle(Text(item.name),displayMode: .inline)
        
        
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            LandmarkDetail(item: landmarks[1],userData: UserData())
        }
    }
}

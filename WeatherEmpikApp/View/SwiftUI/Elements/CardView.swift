//
//  CardView.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 09/02/2023.
//

import SwiftUI

struct CardView: View {
    let model: WeatherModel
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 10) {
            
            Spacer()
            
            HStack(alignment: .center) {
                
                VStack(alignment: .leading, spacing: 1) {
                    Text(model.time)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                    
                    Text(model.cityName)
                        .foregroundColor(.white)
                        .font(.system(size: 45))
                        .bold()
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                }
                .padding()
                
                Spacer()
                
                VStack(alignment: .center, spacing: 50) {
                    
                    Image(systemName: model.conditionName)
                        .resizable()
                        .frame(width: 120, height: 90)
                        .foregroundColor(model.color)
                        .padding(.trailing, 20)
                        .padding(.top, 20)
                    
                    HStack(alignment: .center, spacing: 5) {
                        
                        ImageBundle.temp()
                            .resizable()
                            .frame(width: 20, height: 30)
                        
                        Text(model.temperature.getTemperature())
                            .font(.system(size: 35))
                            .bold()
                            .padding(.trailing, 20)
                            .lineLimit(1)
                            .minimumScaleFactor(0.2)
                    }
                    .foregroundColor(model.temperature.getColor())
                }
            }
            
            Spacer()
            
            HStack(alignment: .bottom) {
                HStack(spacing: 3) {
                    ImageBundle.humidity()
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text(model.humidity)
                }
                
                Spacer()
                
                HStack(spacing: 3) {
                    ImageBundle.wind()
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text(model.windSpeed)
                }
                
                Spacer()
                
                HStack(spacing: 3) {
                    ImageBundle.rain()
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text(model.precipitation)
                }
            }
            .foregroundColor(Color.black)
            .padding()
            
            Spacer()
        }
        .frame(maxHeight: 400)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 18.5, style: .continuous)
                .stroke(Color.white, lineWidth: 1)
                .foregroundColor(.white)
                .padding())
    }
}

//
//  DailyClockWidget.swift
//  DailyClockWidget
//
//  Created by 成焱 on 2020/9/24.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        let sharedDefaults = UserDefaults(suiteName: "group.com.chengyan.DailyClock")?.object(forKey: "shareData")
        return SimpleEntry(info: sharedDefaults as! NSDictionary)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let sharedDefaults = UserDefaults(suiteName: "group.com.chengyan.DailyClock")?.object(forKey: "shareData")
        let entry = SimpleEntry(info: sharedDefaults as! NSDictionary)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        let sharedDefaults = UserDefaults(suiteName: "group.com.chengyan.DailyClock")?.object(forKey: "shareData")
        let entry = SimpleEntry(info: sharedDefaults as! NSDictionary)
        entries.append(entry)
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    var date = Date()
    
    let info: NSDictionary
}

struct DailyClockWidgetEntryView : View {
    var entry: Provider.Entry
    var body: some View {
            ZStack {
                let bg = self.entry.info.object(forKey: "bg") as? String ?? "bbg1"
                let icon = self.entry.info.object(forKey: "icon") as? String ?? "dog"
                let title = self.entry.info.object(forKey: "title") as? String ?? "遛狗"
                let days = self.entry.info.object(forKey: "days") as? String ?? "0天"
                Image(bg).resizable()
                    .ignoresSafeArea(.all)
                VStack(alignment: .leading){
                    HStack(alignment: .center, spacing:0) {
                        Image(icon)
                            .padding(.leading,15)
                        Text(title).foregroundColor(.black)
                            .padding(.leading,20)
                            .font(.system(size:15))
                        Spacer()
                        HStack(alignment: .bottom, spacing:0) {
                            Text(days)
                                .foregroundColor(
                                    .black)
                                .padding()
                                .font(.system(size: 18))
                        }
                    }
                    .padding(.top,20)
                    Spacer()
                    
                    HStack(alignment: .center){
                        Spacer()
                        Text("周一")
                            .frame(width: 38, height: 38, alignment: .center)
                            .background(Color.init(red: 181/255, green: 255/255, blue: 243/255)).cornerRadius(19)
                            .font(.system(size: 12))
                        Text("周二")
                            .frame(width: 38, height: 38, alignment: .center)
                            .background(Color.init(red: 181/255, green: 255/255, blue: 243/255)).cornerRadius(19)
                            .font(.system(size: 12))
                        Text("周三")
                            .frame(width: 38, height: 38, alignment: .center)
                            .background(Color.init(red: 181/255, green: 255/255, blue: 243/255)).cornerRadius(17)
                            .font(.system(size: 12))
                        Text("周四")
                            .frame(width: 38, height: 38, alignment: .center)
                            .background(Color.init(red: 181/255, green: 255/255, blue: 243/255)).cornerRadius(19)
                            .font(.system(size: 12))
                        Text("周五")
                            .frame(width: 38, height: 38, alignment: .center)
                            .background(Color.init(red: 181/255, green: 255/255, blue: 243/255)).cornerRadius(19)
                            .font(.system(size: 12))
                        Text("周六")
                            .frame(width: 38, height: 38, alignment: .center)
                            .background(Color.init(red: 181/255, green: 255/255, blue: 243/255)).cornerRadius(19)
                            .font(.system(size: 12))
                        Text("周日")
                            .frame(width: 38, height: 38, alignment: .center)                            .background(Color.init(red: 181/255, green: 255/255, blue: 243/255)).cornerRadius(19)
                            .font(.system(size: 12))
                        Spacer()
                    }
                    .padding(.bottom,30)
//                    .background(Color.red)
                }
            }
    }
    
    
}

@main
struct DailyClockWidget: Widget {
    let kind: String = "DailyClockWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            DailyClockWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("打卡")
        .description("每日最新打卡信息")
        .supportedFamilies([.systemMedium])
    }
}

struct DailyClockWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            let sharedDefaults = UserDefaults(suiteName: "group.com.chengyan.DailyClock")?.object(forKey: "shareData")
            DailyClockWidgetEntryView(entry: SimpleEntry(info: sharedDefaults as! NSDictionary))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}

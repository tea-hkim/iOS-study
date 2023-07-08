//
//  MyWidget.swift
//  MyWidget
//
//  Created by Nick on 2023/07/06.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct MyWidgetEntryView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: Provider.Entry

    var body: some View {
        switch self.family {
        case .systemSmall:
            Text(".systemSmall")
        case .systemMedium:
            Text(".systemMeduim")
        case .systemLarge:
            Text(".systemLarge")
        case .systemExtraLarge:
            Text(".systemExtraLarge")
        @unknown default:
            Text("default")
        }
    }
}

struct MyWidget: Widget {
    let kind: String = "MyWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind,
                            intent: ConfigurationIntent.self,
                            provider: Provider()) { entry in
            MyWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("위젯 설정 제목")
        .description("이곳을 통해 위젯을 설정합니다")
    }
}

struct MyWidget_Previews: PreviewProvider {
    static var previews: some View {
        MyWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

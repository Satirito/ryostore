import QtQuick
import "i18n"

Rectangle {
    id: root
    property var pluginApi
    property string density: "full"
    property real s: 1
    property real widthBudget: 320
    property bool active: false
    readonly property var service: pluginApi ? pluginApi.mainInstance : null
    readonly property var state: service ? service.data : ({})
    readonly property color white: "#F5F5F5"
    readonly property color grey: "#B1B3B3"
    implicitWidth: widthBudget
    implicitHeight: 186 * s
    color: "#2D2E33"
    radius: 20 * s

    Column {
        x: 20 * root.s
        y: 17 * root.s
        width: root.width - 40 * root.s
        spacing: 13 * root.s

        Text {
            text: I18n.tr("System")
            color: root.white
            font.family: "Noto Sans"
            font.pixelSize: 16 * root.s
        }
        Rectangle { width: parent.width; height: 1; color: "#55565B" }
        Row {
            spacing: 11 * root.s
            Icon { kind: "network"; width: 19 * root.s; height: 19 * root.s; ink: root.white }
            Text { text: I18n.tr("Network"); color: root.grey; width: 92 * root.s; font.family: "Noto Sans"; font.pixelSize: 12 * root.s }
            Text { text: root.state.network === "full" ? I18n.tr("Online") : I18n.tr("Offline"); color: root.white; font.family: "Noto Sans"; font.pixelSize: 12 * root.s }
        }
        Row {
            spacing: 11 * root.s
            Icon { kind: "audio"; width: 19 * root.s; height: 19 * root.s; ink: root.white }
            Text { text: I18n.tr("Sound"); color: root.grey; width: 92 * root.s; font.family: "Noto Sans"; font.pixelSize: 12 * root.s }
            Text { text: root.state.muted ? I18n.tr("Muted") : String(root.state.volume ?? 0) + "%"; color: root.white; font.family: "Noto Sans"; font.pixelSize: 12 * root.s }
        }
        Row {
            spacing: 11 * root.s
            Icon { kind: "battery"; width: 19 * root.s; height: 19 * root.s; ink: root.white; level: root.state.battery ?? 100 }
            Text { text: I18n.tr("Battery"); color: root.grey; width: 92 * root.s; font.family: "Noto Sans"; font.pixelSize: 12 * root.s }
            Text {
                text: root.state.battery < 0 ? "--"
                    : root.state.charging ? String(root.state.battery) + "% · " + I18n.tr("Charging")
                    : root.state.plugged ? String(root.state.battery) + "% · " + I18n.tr("On AC")
                    : String(root.state.battery) + "%"
                color: root.state.battery >= 0 && root.state.battery <= 15 ? "#C8102E" : root.white
                font.family: "Noto Sans"
                font.pixelSize: 12 * root.s
            }
        }
    }
}

import QtQuick 2.6
import QtQuick.Window 2.2
import MrPlotter 0.1
import "mr-plotter-layouts" as MrPlotterLayouts

Window {
    visible: true

    Component.onCompleted: {
        mrpbl.autozoom();
    }

    Stream {
        id: s1
        dataDensity: false
        selected: false
        alwaysConnect: false

        color: "blue"
        timeOffset: [0, 0]
        archiver: "local"//"gabe.ns/s.giles/0/i.archiver"
        uuid: "e14bc2c9-e277-5239-9e60-8fa839394c01"
    }

    MrPlotterLayouts.SmoothYAxis {
        id: a1
        dynamicAutoscale: true
        name: "True Power"
        domain: [-2, 2]
        streamList: [s1]
    }

    MrPlotterLayouts.BasicPlot {
        id: mrpbl
        anchors.fill: parent
        timeDomain: [1415643674978, 1415643674979, 469055.0, 469060.0]
        timeZone: "America/Los_Angeles"
        timeTickPromotion: true
        axisList: [a1]
        streamList: [s1]
        scrollZoomable: true
    }
}

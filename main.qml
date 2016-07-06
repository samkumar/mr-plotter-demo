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
        archiver: "gabe.ns/s.giles/0/i.archiver"
        uuid: "e14bc2c9-e277-5239-9e60-8fa839394c01"
    }

    Stream {
        id: s2
        dataDensity: false
        selected: true
        alwaysConnect: true

        color: "red"
        timeOffset: [0, 0]
        archiver: "gabe.ns/s.giles/0/i.archiver"
        uuid: "e1a6abbc-ddbd-50da-896e-b8b27e1d5ff1"
    }

    Stream {
        id: dds1
        dataDensity: true
        selected: false
        alwaysConnect: false

        color: "blue"
        timeOffset: [0, 0]
        archiver: "gabe.ns/s.giles/0/i.archiver"
        uuid: "e14bc2c9-e277-5239-9e60-8fa839394c01"
    }

    MrPlotterLayouts.SmoothYAxis {
        id: a1
        dynamicAutoscale: true
        name: "True Power 1"
        domain: [-2, 2]
        streamList: [s1]
    }

    MrPlotterLayouts.SmoothYAxis {
        id: a2
        dynamicAutoscale: false
        name: "True Power 2"
        domain: [-2, 2]
        streamList: [s2]
        minTicks: 2
    }

    MrPlotterLayouts.SmoothYAxis {
        id: dda1
        dynamicAutoscale: true
        name: "Count"
        domain: [0, 2]
        streamList: [dds1]
    }

    MrPlotterLayouts.StandardPlot {
        id: mrpbl
        anchors.fill: parent
        timeDomain: [1415643674978, 1415643674979, 469055.0, 469060.0]
        timeZone: "America/Los_Angeles"
        timeTickPromotion: true
        leftAxisList: [a1]
        rightAxisList: [a2]
        streamList: [s1, s2]
        scrollZoomable: true
        leftDataDensityAxisList: [dda1]
        dataDensityStreamList: [dds1]
        dataDensityScrollZoomable: false
    }
}

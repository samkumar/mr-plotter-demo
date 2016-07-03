import QtQuick 2.6
import QtQuick.Window 2.2
import MrPlotter 0.1
import "mr-plotter-layouts" as MrPlotterLayouts

Window {
    visible: true

    MouseArea {
        anchors.fill: parent
        onClicked: {
            console.log("Clicked");
            a1.domain = [-20, 20];
        }
    }

    Component.onCompleted: {
        var mrp = mrpbl.plotter;
        var pa = mrpbl.plotarea;
        var ddpa = mrpbl.datadensityplotarea;
        var yaa = mrpbl.yaxisarea;
        var ddyaa = mrpbl.datadensityyaxisarea;

        var archiver = -1;//mrp.addArchiver("gabe.ns/s.giles/0/i.archiver");
        var s1 = mrp.newStream("e5f220f0-56fa-50ba-a7d8-ff6ed20c3ed6", archiver);
        //var s2 = mrp.newStream("e14bc2c9-e277-5239-9e60-8fa839394c01", archiver);
        //var s3 = mrp.newStream("3c911217-4a40-3992-9e16-80f66b3178ee", archiver);
        //var s4 = mrp.newStream("df3cf79d-7465-3b81-8040-79a6e0bd62a0", archiver);

        //s3.alwaysConnect = true;

        var a2 = mrp.newYAxis(-10, 2);
        var a3 = mrp.newYAxis(-1.9, 2.1);

        s1.setColor(0, 0, 1.0);
        //s2.setColor(1.0, 0, 0);
        //s3.setColor(0, 0.5, 0);
        //s4.setColor(0.5, 0, 0.5);

        //s3.setTimeOffset(0, 200);

        a1.addStream(s1);
        //a2.addStream(s2);
        //a3.addStream(s3);
        //a3.addStream(s4);

        a2.dynamicAutoscale = true;
        a3.dynamicAutoscale = true;

        a2.name = "Temperature";
        a3.name = "Humidity";

        var dds = mrp.newStream("e14bc2c9-e277-5239-9e60-8fa839394c01", archiver);
        dds.setColor(1.0, 0, 0);
        var dda = mrp.newYAxis(0, 10);
        dda.dynamicAutoscale = true;
        dda.minTicks = 2;
        dda.addStream(dds);


        mrp.timeTickPromotion = true;
        //ddpa.setScrollZoomable(false);

        var streamlist = [s1];
        var axislist = [a1, a2, a3];

        pa.streamList = streamlist;
        ddpa.streamList = [dds];
        yaa.axisList = axislist;
        ddyaa.axisList = [dda];

        mrp.scrollableDomain = [1415643674978, 1415643674980];

        mrp.timeDomain = [1415643674978.0, 1415643674979.0, 469055.0, 469060.0];
        mrp.setTimeZone("America/Los_Angeles");

        mrp.autozoom(streamlist);

        pa.update();
        yaa.update();

        mrp.updateDataAsync();
    }

    YAxis {
        id: a1
        dynamicAutoscale: true
        name: "True Power"
        domain: [-2, 2]

        Behavior on domainLo {
            NumberAnimation {
                duration: 200
            }
        }
        Behavior on domainHi {
            NumberAnimation {
                duration: 200
            }
        }
    }

    MrPlotterLayouts.BasicLayout {
        id: mrpbl
        anchors.fill: parent;
    }
}

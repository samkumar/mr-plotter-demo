import QtQuick 2.6
import QtQuick.Window 2.2
import MrPlotter 0.1

Window {
    visible: true

    Component.onCompleted: {
        var archiver = -1;//mrp.addArchiver("gabe.ns/s.giles/0/i.archiver");
        var s1 = mrp.newStream("e5f220f0-56fa-50ba-a7d8-ff6ed20c3ed6", archiver);
        //var s2 = mrp.newStream("c9287d59-e7a4-3917-aa89-dbda37b1c0a3", archiver);
        var s3 = mrp.newStream("aa69412d-c0d0-376e-9255-925211dcedcc", archiver);

        s3.alwaysConnect = true;

        var a1 = mrp.newYAxis(-2, 2);
        var a2 = mrp.newYAxis(-10, 2);
        var a3 = mrp.newYAxis(-1.9, 2.1);

        s1.setColor(0, 0, 1.0);
        //s2.setColor(1.0, 0, 0);
        s3.setColor(0, 0.5, 0);

        a1.addStream(s1);
        //a2.addStream(s2);
        a3.addStream(s3);

        //a1.dynamicAutoscale = true;
        //a3.dynamicAutoscale = true;

        a1.name = "True Power";
        a2.name = "Temperature";
        a3.name = "Humidity";

        a2.dynamicAutoscale = true;

        var dds = mrp.newStream("e14bc2c9-e277-5239-9e60-8fa839394c01", archiver);
        dds.setColor(1.0, 0, 0);
        var dda = mrp.newYAxis(0, 10);
        dda.dynamicAutoscale = true;
        dda.setMinTicks(2);
        dda.addStream(dds);

        var streamlist = [s1, s3];
        var axislist = [a1, a2, a3];

        pa.setStreamList(streamlist);
        ddpa.setStreamList([dds]);
        yaa.setAxisList(axislist);
        ddyaa.setAxisList([dda]);

        mrp.setTimeDomain(1415643674979, 1415643674979, 469055, 469318);
        mrp.setTimeZone("America/Los_Angeles");

        pa.update();
        yaa.update();

        mrp.updateDataAsync();
    }

    PlotArea {
        id: ddpa
        anchors.left: pa.left
        width: pa.width
        height: 70
        yaxisarea: ddyaa
    }

    YAxisArea {
        id: ddyaa
        y: 0
        anchors.right: ddpa.left
        width: yaa.width
        height: parent.height
        rangeStart: ddpa.y + ddpa.height
        rangeEnd: ddpa.y
    }

    PlotArea {
        id: pa
        y: ddpa.height + 15
        anchors.left: yaa.right
        width: parent.width - yaa.width
        height: Math.max(parent.height - taa.height - ddpa.height, 60)
        yaxisarea: yaa
    }

    YAxisArea {
        id: yaa
        y: 0
        anchors.left: parent.left
        width: Math.min(parent.width / 4, 300)
        height: parent.height
        rangeStart: pa.y + pa.height
        rangeEnd: pa.y
    }

    TimeAxisArea {
        id: taa
        anchors.top: pa.bottom
        x: 0
        width: parent.width
        height: 70
        rangeStart: pa.x
        rangeEnd: pa.x + pa.width
    }

    MrPlotter {
        id: mrp
        mainPlot: pa
        dataDensityPlot: ddpa
        timeaxisarea: taa
    }
}

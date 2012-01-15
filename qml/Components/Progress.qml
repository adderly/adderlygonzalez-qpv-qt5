
import QtQuick 1.1

Item {
     id: progressbar

     property int minimum: 0
     property int maximum: 100
     property int value: 0

     width: 250;
     height: 12
     clip: true

     Rectangle {
         id: highlight

         property int widthDest: ((progressbar.width * (value - minimum)) / (maximum - minimum) - 6)

         width: highlight.widthDest
         //Behavior on width { SmoothedAnimation { velocity: 1200 } }

         anchors { left: parent.left; top: parent.top; bottom: parent.bottom; margins: 3 }
         color: "#729fcf"
     }
 }

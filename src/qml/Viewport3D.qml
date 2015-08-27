/***********************************************************************
 *
 * Filename: Viewport3D.qml 
 *
 * Description: Holds the C++ viewport. 
 *
 * Copyright (C) 2015 Richard Layman, rlayman2000@yahoo.com 
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 ***********************************************************************/

import QtQuick 2.3
import feather.viewport 1.0
import feather.scenegraph 1.0

Rectangle {
    //anchors.fill: parent
    color: "orange"
    border.color: "black"
    border.width: 1
    property SceneGraph scenegraph: Null
    
    Viewport {
        id: renderer
        anchors.fill: parent
        anchors.margins: 2
        //width: 500
        //height: 500

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: false
            acceptedButtons: Qt.LeftButton | Qt.RightButton

            onPressed: {
                if(mouse.button == Qt.RightButton)
                    main_popup.popup();

                renderer.mousePressed(mouse.x,mouse.y)

            }
            onPositionChanged: { renderer.moveCamera(mouse.x,mouse.y) }
            //onReleased: { console.log("released") }
            onWheel: { renderer.zoomCamera(wheel.angleDelta.y); }
        }

    MainPopup { id: main_popup; visible: true }

    }

    //function update() { }

    function nodeAdded(uid) { console.log("node " + uid + " added"); renderer.nodeInitialize(uid) }


    Component.onCompleted: {
        //scenegraph.update.connect(update)
        scenegraph.nodeAdded.connect(nodeAdded)
    }
}

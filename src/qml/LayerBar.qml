/***********************************************************************
 *
 * Filename: LayerBar.qml 
 *
 * Description: How a single layer will be displayed by the layer editor. 
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
import QtQuick.Dialogs 1.0
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

Rectangle {
    id: layerFrame
    height: 24
    radius: 2
    color: (ListView.view.currentIndex==index) ? "hotpink" : layerColor 
    border.width: 1
    border.color: (ListView.view.currentIndex==index) ? "limegreen" : "black" 
    property int barId: 0
    property alias barName: label.text
    property bool barVisible: true  
    property bool barLocked: false
    property bool barSelected: layerSelected 

    signal selected(int id)
    signal deselected(int id)


    // LABEL

    ColorDialog {
        id: colorDialog
        title: "Layer Color"

        onAccepted: {
            layerFrame.color = colorDialog.color
            colorDialog.visible = false;
        }

        onRejected: { colorDialog.visible = false; }

        Component.onCompleted: visible = false 
    }

    Row {
        spacing: 8
        anchors.fill: parent
        anchors.margins: 4

        // Bar Selecting 

        Item { 
            id: selectIcon
            visible: true 
            width: 20
            height: parent.height 
            property color deselectColor: layerColor

            Image {
                id: select_on_icon
                anchors.fill: parent
                visible: (layerFrame.ListView.view.currentIndex==index) ? true : false 
                sourceSize.width: 18
                sourceSize.height: 18
                source: "icons/select_bubble_on.svg"
            }

            Image {
                id: select_off_icon
                anchors.fill: parent
                visible: (layerFrame.ListView.view.currentIndex==index) ? false : true 
                sourceSize.width: 18
                sourceSize.height: 18
                source: "icons/select_bubble_off.svg"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: { layerFrame.ListView.view.currentIndex = index }
            }
        }

        Item {
            id: labelName
            height: parent.height
            width: parent.width-110

            Text {
                id: label
                anchors.fill: parent
                visible: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 14
                font.bold: false

            }

            TextField {
                id: labelEdit
                anchors.fill: parent
                visible: false
                readOnly: false
            }
 
            MouseArea {
                id: mouseTextArea
                anchors.fill: parent
                hoverEnabled: true 
                acceptedButtons: Qt.LeftButton // | Qt.RightButton


                //onPressed: { console.log("text pressed"); /*mouse.accepted = false*/ }

                //onClicked: { mouse.accepted = false }

                onClicked: {
                    console.log("text clicked");
                    mouse.accepted = false
                    if(label.visible){
                        label.visible = false
                        labelEdit.visible = true
                        labelEdit.placeholderText = "Enter Layer Name" 
                        labelEdit.forceActiveFocus()
                    }
                }
    
                onDoubleClicked: { console.log("text double clicked");  mouse.accepted = false }

            }

            function setLabelName(){
                label.text = labelEdit.text
                labelEdit.visible = false
                label.visible = true
            }

            Component.onCompleted: { labelEdit.accepted.connect(setLabelName) } 
 
        }


        // Bar Color 

        Item { 
            id: barColorIcon
            visible: true 
            width: 20
            height: parent.height

            Image {
                id: color_icon
                anchors.fill: parent
                visible: true 
                sourceSize.width: 18
                sourceSize.height: 18
                source: "icons/color.svg"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    colorDialog.color = layerFrame.color
                    colorDialog.visible = (!colorDialog.visible) ? true : false
                    layerFrame.color = colorDialog.color
                    // TODO - set the core layer color
                    mouse.accepted = false
                }
            }
        }


        // Bar Visiblity 

        Item { 
            id: barVisibleIcon
            visible: true 
            width: 20
            height: parent.height

            Image {
                id: visible_icon
                anchors.fill: parent
                visible: true 
                sourceSize.width: 18
                sourceSize.height: 18
                source: "icons/visible.svg"
            }

            Image {
                id: not_visible_icon
                anchors.fill: parent
                visible: false 
                sourceSize.width: 18
                sourceSize.height: 18
                source: "icons/not_visible.svg"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    visible_icon.visible = (visible_icon.visible) ? false : true
                    not_visible_icon.visible = (not_visible_icon.visible) ? false : true
                    mouse.accepted = false
                }
            }
        }


        // Bar Locking 

        Item { 
            id: barLockIcon
            visible: true 
            width: 20
            height: parent.height 

            Image {
                id: locked_icon
                anchors.fill: parent
                visible: true 
                sourceSize.width: 18
                sourceSize.height: 18
                source: "icons/locked.svg"
            }

            Image {
                id: unlocked_icon
                anchors.fill: parent
                visible: false 
                sourceSize.width: 18
                sourceSize.height: 18
                source: "icons/unlocked.svg"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    locked_icon.visible = (locked_icon.visible) ? false : true
                    unlocked_icon.visible = (unlocked_icon.visible) ? false : true
                    mouse.accepted = false;
                }
            }
        }
    }
}
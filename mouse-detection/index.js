
var robot = require("robotjs");

const dgram = require('dgram');
const screenSize = robot.getScreenSize();
const screenCenter = {x: screenSize.width/2, y: screenSize.height/2}

setInterval(() => {
    const mouse = robot.getMousePos();
    const client = dgram.createSocket('udp4');
    const msgStr = [mouse.x-screenCenter.x, mouse.y-screenCenter.y].join(',')
    const message = Buffer.from(msgStr);
    console.log('sending mouse position, ', msgStr)
    client.send(message, 41234, 'localhost', (err) => {
      client.close();
    });
}, 1000 / 30);
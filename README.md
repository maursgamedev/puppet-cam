
# Puppet Cam
![PuppetCam Gif Example](https://github.com/mauriciogamedev/puppet-cam/blob/master/example.gif?raw=true)

This is a free alternative for a virtual webcam for streaming or youtube videos.
This project was developed on Linux, but it uses multi platform tools, so it
will probably work on Windows and OSX without problems.

## Dependencies:
 * Love2D 11.3
 * Nodejs 14.5.0

## How to use
Make sure to have both of the dependencies installed.
Use the love2d executable to run the `canvas/`folder, the project actually works without the mouse-detection part,
if you don't want the character eyes to follow the mouse on screen, then you're done.
To make the eyes to follow the mouse position then go to the `mouse-detection` folder then run:
```
$ npm install
```
After the installation is done, then you can use

```
$ node index.js
```
If you have both programs running (canvas and mouse-detection) the character eyes and face
should follow your mouse movement on screen.

### Canvas
The canvas folder is the love2d project.

### Mouse Detection
The mouse-detection folder is a nodejs tool to get the mouse position outside
the love2d window.

## What needs to be done:
 * [x] Microphone Capture.
 * [x] Render the example puppet.
 * [x] Make the puppet follow the microphone levels.
 * [x] Make the puppet blink randomly
 * [x] Make the puppet eyes follow the mouse on screen.
 * [x] Make the puppet eyes follow the mouse outside the game window

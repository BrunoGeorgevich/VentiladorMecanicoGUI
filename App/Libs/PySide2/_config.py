built_modules = list(name for name in
    "Core;Gui;Widgets;PrintSupport;Sql;Network;Test;Concurrent;X11Extras;Xml;XmlPatterns;Help;Multimedia;MultimediaWidgets;OpenGL;OpenGLFunctions;Positioning;Location;Qml;Quick;QuickControls2;QuickWidgets;RemoteObjects;Scxml;Script;ScriptTools;Sensors;SerialPort;TextToSpeech;Charts;Svg;DataVisualization;UiTools;WebChannel;WebEngineCore;WebEngine;WebEngineWidgets;WebSockets;3DCore;3DRender;3DInput;3DLogic;3DAnimation;3DExtras"
    .split(";"))

shiboken_library_soversion = str(5.15)
pyside_library_soversion = str(5.15)

version = "5.15.0"
version_info = (5, 15, 0, "", "")

__build_date__ = '2020-06-17T07:47:09+00:00'





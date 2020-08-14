#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Apr 17 17:29:24 2020

@author: bruno
"""

from Backend.System import System
from Backend.Controller.SplashController import SplashController

import sys
import os

from PySide2.QtWidgets import QApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import QResource
import PySide2

MAIN_PATH = os.path.dirname(os.path.realpath(__file__))
QML_PATH = os.path.join(MAIN_PATH, "qml.rcc")

if __name__ == "__main__":
    app = QApplication(sys.argv)

    app.setApplicationName("MechanicalRespiratorSoftware")
    app.setOrganizationName("UFAL")
    
    print(f"RCC FILE EXISTS :: {os.path.exists(QML_PATH)} -> {QML_PATH}")
    QResource.registerResource(QML_PATH)
    engine = QQmlApplicationEngine()
    ctx = engine.rootContext()

    splash_controller = SplashController()
    
    ctx.setContextProperty("splash_controller", splash_controller)
    engine.load('qrc:/pages/splash.qml')

    system = System()
    ctx.setContextProperty("system", system)
    
    splash_controller.splash_is_opened = False
    
    engine.load('qrc:/pages/main.qml')

    
    sys.exit(app.exec_())

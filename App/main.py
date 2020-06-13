#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Apr 17 17:29:24 2020

@author: bruno
"""

from Backend.System import System

import sys
import os

from PySide2.QtWidgets import QApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import QResource

if __name__ == "__main__":
    app = QApplication(sys.argv)

    app.setApplicationName("MechanicalRespiratorSoftware")
    app.setOrganizationName("UFAL")
    
    QResource.registerResource("qml.rcc")
    engine = QQmlApplicationEngine()

    system = System()

    ctx = engine.rootContext()
    ctx.setContextProperty("system", system)
    
    engine.load('qrc:/pages/main.qml')

    
    sys.exit(app.exec_())
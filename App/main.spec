# -*- mode: python ; coding: utf-8 -*-

import os
import sys

block_cipher = None

datas = []

a = Analysis(['main.py'],
             pathex=['.'],
             binaries=[],
             datas=datas,
             hiddenimports=['pkg_resources.py2_warn'],
             hookspath=[],
             runtime_hooks=[],
             excludes=[],
             win_no_prefer_redirects=False,
             win_private_assemblies=False,
             cipher=block_cipher,
             noarchive=False)

pyz = PYZ(a.pure, a.zipped_data,
             cipher=block_cipher)
pyz = PYZ(a.pure, a.zipped_data,
             cipher=block_cipher)
exe = EXE(pyz,
          a.scripts,
	  # a.binaries,
	  # a.zipfiles,
	  # a.datas,
          name='app',
	  exclude_binaries=True,
          debug=False,
          # bootloader_ignore_signals=False,
          strip=False,
          upx=True,
          # upx_exclude=[],
          # runtime_tmpdir=None,
          console=True)

coll = COLLECT(
    exe,
    a.binaries,
    a.zipfiles,
    a.datas,
    name='Ventilador',
    strip=False,
    upx=True
)

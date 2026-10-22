import math

from PyQt6.QtCore import Qt, QCoreApplication, QTimer, QRectF
from PyQt6.QtGui import QPixmap, QColor, QFont, QPen, QPainter, QBrush, QLinearGradient
from PyQt6.QtWidgets import QSplashScreen

from UM.Resources import Resources
from UM.Application import Application
from cura import ApplicationMetadata

import time

class CuraSplashScreen(QSplashScreen):
    def __init__(self):
        super().__init__()
        self._scale = 1

        splash_image = QPixmap(Resources.getPath(Resources.Images, "cura.png"))
        self.setPixmap(splash_image)

        self._current_message = ""
        self._progress_phase = 0.0

        self._to_stop = False
        self._change_timer = QTimer()
        self._change_timer.setInterval(30)
        self._change_timer.setSingleShot(False)
        self._change_timer.timeout.connect(self.updateLoadingImage)

        self._last_update_time = None

    def show(self):
        super().show()
        self._last_update_time = time.time()
        self._change_timer.start()

    def updateLoadingImage(self):
        if self._to_stop:
            return
        time_since_last_update = time.time() - self._last_update_time
        self._last_update_time = time.time()
        self._progress_phase += time_since_last_update * 0.8
        if self._progress_phase > 2.0:
            self._progress_phase -= 2.0
        self.repaint()

    def mousePressEvent(self, mouse_event):
        pass

    def drawContents(self, painter):
        if self._to_stop:
            return

        painter.save()
        painter.setRenderHint(QPainter.RenderHint.Antialiasing, True)

        bar_x = 40
        bar_w = 521
        bar_y = 340
        bar_h = 3

        track_color = QColor(255, 255, 255, 30)
        painter.setPen(Qt.PenStyle.NoPen)
        painter.setBrush(QBrush(track_color))
        painter.drawRoundedRect(QRectF(bar_x, bar_y, bar_w, bar_h), 1.5, 1.5)

        phase = self._progress_phase
        highlight_w = bar_w * 0.35
        if phase < 1.0:
            pos = phase
        else:
            pos = 2.0 - phase
        fill_x = bar_x + pos * (bar_w - highlight_w)

        gradient = QLinearGradient(fill_x, 0, fill_x + highlight_w, 0)
        gradient.setColorAt(0.0, QColor(232, 51, 74, 0))
        gradient.setColorAt(0.15, QColor(232, 51, 74, 220))
        gradient.setColorAt(0.5, QColor(232, 51, 74, 255))
        gradient.setColorAt(0.85, QColor(232, 51, 74, 220))
        gradient.setColorAt(1.0, QColor(232, 51, 74, 0))

        painter.setBrush(QBrush(gradient))
        painter.drawRoundedRect(QRectF(bar_x, bar_y, bar_w, bar_h), 1.5, 1.5)

        if self._current_message:
            font = QFont("Segoe UI", 9)
            font.setPixelSize(12)
            painter.setFont(font)
            pen = QPen()
            pen.setColor(QColor(180, 190, 200, 200))
            painter.setPen(pen)
            painter.drawText(bar_x, bar_y + 10, bar_w, 30,
                             Qt.AlignmentFlag.AlignLeft | Qt.AlignmentFlag.AlignTop,
                             self._current_message)

        painter.restore()
        super().drawContents(painter)

    def showMessage(self, message, *args, **kwargs):
        if self._to_stop:
            return

        self._current_message = message
        self.messageChanged.emit(message)
        QCoreApplication.processEvents()
        self.repaint()

    def close(self):
        self._to_stop = True
        self._change_timer.stop()
        super().close()

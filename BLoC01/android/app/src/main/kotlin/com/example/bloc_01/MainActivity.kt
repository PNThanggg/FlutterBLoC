package com.example.bloc_01

import android.media.AudioManager
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private var methodChannel: MethodChannel? = null

    companion object {
        private const val METHOD_CHANNEL_NAME = "native_channel"
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val audioManager = applicationContext.getSystemService(AUDIO_SERVICE) as AudioManager

        methodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            METHOD_CHANNEL_NAME
        )
        methodChannel!!.setMethodCallHandler { call, result ->
            when (call.method) {
                "get_volume" -> {
                    val volumeLevel = audioManager.getStreamVolume(AudioManager.STREAM_MUSIC)
                    val maxVolumeLevel = audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC)
                    val volumePercent = (volumeLevel.toFloat() / maxVolumeLevel * 100).toInt()

                    result.success(volumePercent)
                }

                "adjust_raise" -> {
                    audioManager.adjustStreamVolume(
                        AudioManager.STREAM_MUSIC,
                        AudioManager.ADJUST_RAISE,
                        AudioManager.FLAG_SHOW_UI
                    )

                    result.success("OK")
                }

                "adjust_lower" -> {
                    audioManager.adjustStreamVolume(
                        AudioManager.STREAM_MUSIC,
                        AudioManager.ADJUST_LOWER,
                        AudioManager.FLAG_SHOW_UI
                    )

                    result.success("OK")
                }

                "mute" -> {
                    when (audioManager.ringerMode) {
                        AudioManager.RINGER_MODE_SILENT -> {
                            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                                audioManager.adjustStreamVolume(
                                    AudioManager.STREAM_MUSIC,
                                    AudioManager.ADJUST_UNMUTE,
                                    AudioManager.FLAG_SHOW_UI
                                )

                                result.success("un mute")
                            } else {
                                result.error(
                                    "101",
                                    "Error build version code",
                                    null
                                )
                            }

                        }
                        AudioManager.RINGER_MODE_VIBRATE -> {
                            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                                audioManager.adjustStreamVolume(
                                    AudioManager.STREAM_MUSIC,
                                    AudioManager.ADJUST_UNMUTE,
                                    AudioManager.FLAG_SHOW_UI
                                )

                                result.success("un mute")
                            } else {
                                result.error(
                                    "101",
                                    "Error build version code",
                                    null
                                )
                            }
                        }
                        AudioManager.RINGER_MODE_NORMAL -> {
                            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                                audioManager.adjustStreamVolume(
                                    AudioManager.STREAM_MUSIC,
                                    AudioManager.ADJUST_MUTE,
                                    AudioManager.FLAG_SHOW_UI
                                )

                                result.success("mute")
                            } else {
                                result.error(
                                    "101",
                                    "Error build version code",
                                    null
                                )
                            }
                        }
                    }
                }

                else -> result.notImplemented()
            }
        }
    }
}

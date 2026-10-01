modRTToggle v1.0 - Real-time Ray Tracing, Path Tracing and Frame Gen toggles
============================================================================

Switch Ray Tracing, Path Tracing and Frame Generation in-game with a single
key, without opening the options menu. An on-screen notification shows the
current mode. (Notifications are in Portuguese.)

KEYS
----
F8 - cycles through the Ray Tracing modes, in this order:
       1. Ray Tracing and Path Tracing OFF
       2. Ray Tracing ON, Path Tracing OFF
       3. Ray Tracing and Path Tracing ON
       (then back to 1)

F9 - toggles Frame Gen on/off.
       Turns off whichever Frame Gen is active (DLSS, FSR or XeSS) and turns
       the same one back on next time. If none is active, it picks the one that
       matches the upscaler selected in the menu (DLSS -> DLSS FG,
       FSR -> FSR FG, XeSS -> XeSS FG).

Changes are saved, just as if they were made in the menu.

REQUIREMENTS
------------
- The Witcher 3 Next-Gen / remaster (4.04 or newer), DirectX 12.
- For Ray/Path Tracing: an RT-capable GPU.
- Does not modify any game files; Script Merger is not needed.

INSTALLATION
------------
1. Close the game.
2. Copy the "mods" folder from this package into the game install folder, e.g.:
     C:\Program Files (x86)\Steam\steamapps\common\The Witcher 3\
   Result:
     The Witcher 3\mods\modRTToggle\content\scripts\local\modRTToggle.ws
3. Double-click "instalar-teclas.bat" to add the F8 and F9 bindings.
   (It backs up your input.settings first.)
4. Launch the game. Scripts are recompiled on the first launch.

MANUAL KEY SETUP (instead of step 3)
------------------------------------
With the game CLOSED, open:
   Documents\The Witcher 3\input.settings
and add these two lines right below each of these headers:
[Exploration], [Exploration_Replacer_Ciri], [Combat], [Combat_Replacer_Ciri],
[Horse], [Horse_Replacer_Ciri], [Boat], [BoatPassenger], [Swimming], [Diving],
[Scene], [ScriptedAction], [BASE_PanelsShortcuts]

   IK_F8=(Action=ModCycleRT)
   IK_F9=(Action=ModToggleFG)

To use other keys, replace IK_F8 / IK_F9 (e.g. IK_F7, IK_Insert).

IMPORTANT: only edit input.settings while the game is closed. If the game is
running, it rewrites the file on exit and the bindings are lost.

UNINSTALL
---------
1. Delete the folder The Witcher 3\mods\modRTToggle.
2. Double-click "remover-teclas.bat" (or remove the lines above by hand).

NOTES
-----
- Path Tracing on AMD/Intel GPUs depends on the game's own support.
- DLSS Ray Reconstruction (NVIDIA only) is re-enabled automatically when
  turning RT/PT on, if DLSS is in use, just like the game menu does.
- If F8/F9 were already bound to something else, the installer warns you.

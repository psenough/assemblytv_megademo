# assemblytv_megademo
Source code of Assembly 2023 Fantasy Console compo winner

## How to build

To "build" this project you need to clone this project with submodules to get `ticfile` dependency directory as a subdirectory.

To install `ticfile` properly you can refer for it's own readme (it's mostly having python3 and doing a pip install).

The batch files assume you clone the project into the default TIC-80 projects folder of your system and that the tic80 binary itself is under a subdirectory called `/tic80_bin/` which i randomly came up with as being more practical for me, so you'll very likely have to edit those files to match your system.

What the build does is call `assemble_chunks.py` which is a small python script that uses ticfile to grab and combine the different music, tiles and code into the different tic80 banks of the final tic80 cart. If you're adding a new asset/scene or renaming things, you'll need to edit it.

All the music and starting graphics are stored at `_music_and_tiles_ref.tic` but you need to know what each track/frame/bank corresponds to what scene, so you'll need to take a look at the main scene index array which you can find at `source\main_new.lua`.

## Common errors changing things

Each bank is limited to certain ammount of data, so a common error to get when adding new code and running `assemble_chunks.py` is `sctruct.error: ushort format requires 0 <= number <= 0xffff` which typically means you reached the bank quote for lua code and need to split the code among other banks.

## Where things are

`main_new.lua` is the main index of all the scenes played, referencing what bank switching is required for the scene to get initialized, the initializing function to call (our standard has been to name it `scene_name_init`), the function name of the scene itself, and it's `BDR` function if there is a need for one (for those only used to `SCN`, `BDR` is a better version of `SCN`, read tic80 documentation, our system doesn't use `SCN`). You can use `no_fn` dummy function name when you don't need one.

The bank switching requires a mask to be defined for what section the switching will refer to, that's what the bank switching macro defines are there for. If you change a bank for a scene, you need to make sure you're changing things back on the next scene (and also the previous one in case you want to keep things clean for when using the arrows to ffwd and rewind between scenes).

Taking a look at `main_new.lua` there are 4 important global vars that get globally updated per frame on the main loop which are `_t` for the `time()` and `_track` `_pattern` `_row` if you want to keep track of where you are in the music replay routine. To quick jumpstart to a specific scene you can alter the initial value of `current_track_id`.

If you don't know what scene_id you're at there is some debug code commented out at the bottom of `main_new.lua` that might help you.

Each scene typically initializes with a call to `sweetie16_init()` which resets the palette and any border offset missplacement. It also typically initialises the starting time for that scene `<scenename>_st` which can be used for scene specific progression on the main loop and is also used to time the tv channel id display time.

In terms of native tic80 graphics, the default palette is the sweetie16 palette, the fruit emojis are repeated on the sprites page of all used banks (to keep the fruit salad working regardless of what bank we're using). Custom pixelart loaded as gfx is typically included on the tiles page instead (starting at spr 256). Data can also be loaded entirely through the lua memory variables and not use the cart memory at all. Some of it was custom generated, other was converted using public tools like [ticmctile](https://github.com/PhilSwiss/ticmctile).

Each scene only runs as long as there are audio frames from the tracker data left to play. It jumps to the next frame automatically but once the audio replaying routine reaches an empty frame our system notices that end to the music and will skip to the next scene on the list and start playing the music from that assigned starting position of the audio. This means all audio on the `_music_and_tiles_ref.tic` is separated by an empty frame at the end of the scene. And the more frames you have lined up the longer the scene will play for.


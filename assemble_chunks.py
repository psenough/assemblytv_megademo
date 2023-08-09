import sys
sys.path.append('ticfile')

from ticfile import TICFile, Chunk, ChunkType

# open the cart where the default palette, tiles and music is
reference_cart = TICFile.open("source\\_music_and_tiles_ref.tic")

# remove all code from it
for chunk in reference_cart.chunks:
    if chunk.type == ChunkType.CODE:
        reference_cart.chunks.remove(chunk)

# add lua code

# bank 0 main code
reference_cart.chunks.append(Chunk(ChunkType.CODE, 0, bytes(open("source\\main_new.lua", "r").read(),"ascii")))

# bank 1
bank1 = ""
bank1 = bank1 + open("source\\timecheck.lua", "r").read()
bank1 = bank1 + open("source\\fruit_salad.lua", "r").read()
bank1 = bank1 + open("source\\common.lua", "r").read()
bank1 = bank1 + open("source\\noise_switch.lua", "r").read()
bank1 = bank1 + open("source\\lifeforce.lua", "r").read()
bank1 = bank1 + open("source\\title_screen.lua", "r").read()
bank1 = bank1 + open("source\\porrasturvat.lua", "r").read()
bank1 = bank1 + open("source\\mr_qrwx.lua", "r").read()
bank1 = bank1 + open("source\\hesburger.lua", "r").read()
bank1 = bank1 + open("source\\melon_iflac.lua", "r").read()
reference_cart.chunks.append(Chunk(ChunkType.CODE, 1, bytes(bank1,"ascii")))

# bank 2
bank2 = ""
bank2 = bank2 + open("source\\muffi.lua", "r").read()
bank2 = bank2 + open("source\\atomicplayboy.lua", "r").read()
bank2 = bank2 + open("source\\prophecy.lua", "r").read()
bank2 = bank2 + open("source\\testcard.lua", "r").read()
bank2 = bank2 + open("source\\gerbera.lua", "r").read()
bank2 = bank2 + open("source\\saint.lua", "r").read()
bank2 = bank2 + open("source\\ceasefire.lua", "r").read()
bank2 = bank2 + open("source\\nooon.lua", "r").read()
reference_cart.chunks.append(Chunk(ChunkType.CODE, 2, bytes(bank2,"ascii")))

# bank 3
bank3 = ""
bank3 = bank3 + open("source\\moomin.lua", "r").read()
bank3 = bank3 + open("source\\stickman.lua", "r").read()
bank3 = bank3 + open("source\\chimera.lua", "r").read()
bank3 = bank3 + open("source\\cows_cctv.lua", "r").read()
bank3 = bank3 + open("source\\birds_cctv.lua", "r").read()
bank3 = bank3 + open("source\\hurricane.lua", "r").read()
reference_cart.chunks.append(Chunk(ChunkType.CODE, 3, bytes(bank3,"ascii")))

# bank 4
bank4 = ""
bank4 = bank4 + open("source\\ddt.lua", "r").read()
bank4 = bank4 + open("source\\inercia.lua", "r").read()
bank4 = bank4 + open("source\\kewlers.lua", "r").read()
bank4 = bank4 + open("source\\killallaudio.lua", "r").read()
bank4 = bank4 + open("source\\scientist.lua", "r").read()
reference_cart.chunks.append(Chunk(ChunkType.CODE, 4, bytes(bank4,"ascii")))

# bank 5
bank5 = ""
#bank5 = bank5 + open("source\\whaa.lua", "r").read()
bank5 = bank5 + open("source\\meta_header.lua", "r").read() # to be first thing on cart this needs to be the first code of the last bank used
bank5 = bank5 + open("source\\hfc.lua", "r").read()
bank5 = bank5 + open("source\\disk_throwing.lua", "r").read()
bank5 = bank5 + open("source\\oprah.lua", "r").read()
bank5 = bank5 + open("source\\hockey.lua", "r").read()
bank5 = bank5 + open("source\\disk_throwing.lua", "r").read()
reference_cart.chunks.append(Chunk(ChunkType.CODE, 5, bytes(bank5,"ascii")))

# bank 6
#bank6 = ""
#bank6 = bank6 + open("source\\hockey.lua", "r").read()
#reference_cart.chunks.append(Chunk(ChunkType.CODE, 6, bytes(bank6,"ascii")))

# add the binary image data chunk for nooon
reference_cart.chunks.append(Chunk(ChunkType.MAP, 0, open("source\\_fly_s16_image.bin","rb").read()))

# save it to the final destination
reference_cart.save("assemblytv_megademo.tic")

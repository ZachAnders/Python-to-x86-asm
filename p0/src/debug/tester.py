import dbg

def myfunc():
    dbg.log("test")

    dbg.log.enable()
    dbg.log("test")
    dbg.log.disable()
    dbg.log("test")

myfunc()

env = self.Wage ?= {}
env.clock = new THREE.Clock()

include = (srcs, callback, params) ->
    if not src instanceOf Array
        srcs = [srcs]
    scripts = []
    alreadyGot = (value) ->
        for el in scripts
            if el.indexOf(value) isnt -1
                return true
        false

    got = 0
    _callOnEnd = ->
        if got is srcs.length
            callback(params)
        return

    _scripts = document.getElementsByTagName 'script'
    for el in _scripts
        scripts.push element.src
    for src in srcs
        if alreadyGot src
            continue
        s = document.createElement 'script'
        s.type = "text/javascript"
        s.src = src + ".js"
        s.onload = s.onreadystatechange = ->
            if not @readyState or @readyState is "complete"
                got += 1
                _callOnEnd()
        t = document.getElementsByTagName('script')[0]
        t.parentNode.insertBefore s, t
    _callOnEnd()
    return

env.include = include

self.requestAnimationFrame = (
    window.requestAnimationFrame       ||
    window.webkitRequestAnimationFrame ||
    window.mozRequestAnimationFrame    ||
    window.oRequestAnimationFrame      ||
    window.msRequestAnimationFrame)

self.onload = ->
    if app isnt undefined
        Wage.app = app
    else
        Wage.app = new Wage.App()
    # TODO utils checks
    # App load
    Wage.app.start()
    return

self.onresize = ->
    {screen, camera, renderer} = Wage
    screen.w = window.innerWidth
    screen.h = window.innerHeight
    screen.ratio = screen.w / screen.h
    camera.aspect = screen.ratio
    camera.updateProjectionMatrix()
    renderer.setSize(screen.w / screen.h)
    return

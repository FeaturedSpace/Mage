class AssetsManager
    constructor: ->
        # should implement @namespace via subclassing
        @data = {}
        @_loadStack = []
        {@assets} = Wage.managers
        return

    loadAssets: ->
        {app} = Wage
        for name, path of app.assets[@namespace]
            @_loadStack.push
                name: name
                path: path
        @_procStack()
        return

    _procStack: ->
        for el in @_loadStack
            _loadFile el.name, el.path
        return

    _loadFile: (name, path) ->
        # should be implemented via subclassing
        @_loadCallback(name)
        return

    _loadCallback: (name) ->
        for i in [0..@_loadStack.length-1]
            if @_loadStack[i].name is name
                @_loadStack.splice(i, 1)
                break
        if not @_loadStack
            @assets.notifyEnd(@namespace)
        return


env = self.Wage ?= {}
env.AssetsManager = AssetsManager

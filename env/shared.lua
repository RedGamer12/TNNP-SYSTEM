local SharedModule = {}

SharedModule.__urlcache = SharedModule.__urlcache or {}
SharedModule.threads = {}
SharedModule.callbacks = {}

if SharedModule._unload then
    pcall(SharedModule._unload)
end

function SharedModule._unload()
    for i = 1, #SharedModule.threads do
        coroutine.close(SharedModule.threads[i])
    end

    Fluent:Destroy()

    for i = 1, #SharedModule.callbacks do
        task.spawn(SharedModule.callbacks[i])
    end
end

function SharedModule.init(threads)
    for _, threadInfo in ipairs(threads) do
        local thread = task.spawn(function()
            print("Thread started:", threadInfo.name)
            while true do
                threadInfo.func()
                task.wait()
            end
        end)

        table.insert(SharedModule.callbacks, function()
            print("Canceling thread:", threadInfo.name)
            pcall(task.cancel, thread)
        end)
    end
end

return SharedModule

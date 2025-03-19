local SharedModule = {}

SharedModule.__urlcache = SharedModule.__urlcache or {}
SharedModule.threads = SharedModule.threads or {}
SharedModule.callbacks = {}

if SharedModule._unload then
    pcall(SharedModule._unload)
end

function SharedModule._unload()
    for _, thread in ipairs(SharedModule.threads) do
        if coroutine.status(thread) ~= "dead" then
            coroutine.close(thread)
        end
    end
    SharedModule.threads = {}

    Fluent:Destroy()

    for _, callback in ipairs(SharedModule.callbacks) do
        task.spawn(callback)
    end
    SharedModule.callbacks = {}
end

function SharedModule.init(threads)
    SharedModule._unload()
    
    for _, threadInfo in ipairs(threads) do
        local thread = task.spawn(function()
            print("Thread started:", threadInfo.name)
            while true do
                threadInfo.func()
                task.wait()
            end
        end)

        table.insert(SharedModule.threads, thread)
        table.insert(SharedModule.callbacks, function()
            print("Canceling thread:", threadInfo.name)
            pcall(task.cancel, thread)
        end)
    end
end

return SharedModule

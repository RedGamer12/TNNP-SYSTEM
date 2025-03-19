local SharedModule = {}

SharedModule.__urlcache = SharedModule.__urlcache or {}
SharedModule.threads = SharedModule.threads or {}
SharedModule.callbacks = {}
SharedModule.isRunning = false

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

    if _G.Library then
        _G.Library:Destroy()
    end

    for _, callback in ipairs(SharedModule.callbacks) do
        task.spawn(callback)
    end
    SharedModule.callbacks = {}
    SharedModule.isRunning = false
end

function SharedModule.init(threads, enable, threadName)
    if not enable then
        SharedModule._unload()
        return
    end
    
    if SharedModule.isRunning then return end
    SharedModule.isRunning = true
    
    for _, threadInfo in ipairs(threads) do
        if not threadName or threadInfo.name == threadName then
            local thread = task.spawn(function()
                print("Thread started:", threadInfo.name)
                while SharedModule.isRunning do
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
end

return SharedModule

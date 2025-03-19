local SharedModule = {}

SharedModule.__urlcache = SharedModule.__urlcache or {}
SharedModule.threads = SharedModule.threads or {}
SharedModule.callbacks = {}
SharedModule.runningThreads = {}

if SharedModule._unload then
    pcall(SharedModule._unload)
end

function SharedModule._unload()
    for _, callback in ipairs(SharedModule.callbacks) do
        task.spawn(callback)
    end
    SharedModule.threads = {}
    SharedModule.callbacks = {}
    SharedModule.runningThreads = {}
    if _G.Library then
        _G.Library:Destroy()
        _G.Library = nil
    end
end

function SharedModule.toggleThread(threadInfo, enable)
    if enable then
        if SharedModule.runningThreads[threadInfo.name] then return end -- Nếu đã chạy, bỏ qua
        
        local thread = task.spawn(function()
            print("Thread started:", threadInfo.name)
            while SharedModule.runningThreads[threadInfo.name] do
                threadInfo.func()
                task.wait()
            end
        end)
        
        SharedModule.runningThreads[threadInfo.name] = thread
        table.insert(SharedModule.threads, thread)
        table.insert(SharedModule.callbacks, function()
            print("Canceling thread:", threadInfo.name)
            pcall(task.cancel, thread)
            SharedModule.runningThreads[threadInfo.name] = nil
        end)
    else
        if SharedModule.runningThreads[threadInfo.name] then
            print("Canceling thread:", threadInfo.name)
            pcall(task.cancel, SharedModule.runningThreads[threadInfo.name])
            SharedModule.runningThreads[threadInfo.name] = nil
        end
    end
end

function SharedModule.init(threads, enable, threadName)
    if not enable then
        SharedModule._unload()
        return
    end
    
    if threadName then
        for _, threadInfo in ipairs(threads) do
            if threadInfo.name == threadName then
                SharedModule.toggleThread(threadInfo, enable)
                return
            end
        end
    else
        for _, threadInfo in ipairs(threads) do
            SharedModule.toggleThread(threadInfo, enable)
        end
    end
end

return SharedModule

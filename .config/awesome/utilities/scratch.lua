local client = client
local awful = require("awful")

local scratch = {}
local defaultRule = {instance = "scratch"}

local function manipulateTags(c, action)
    local currentTag = awful.tag.selected(c.screen)
    local ctags = {currentTag}
    for _, tag in pairs(c:tags()) do
        if tag ~= currentTag then
            table.insert(ctags, tag)
        end
    end
    c:tags(ctags)
    if action == "on" then
        c:raise()
        client.focus = c
    end
end

local function turnOn(c)
    manipulateTags(c, "on")
end

local function turnOff(c)
    manipulateTags(c, "off")
end

function scratch.raise(cmd, rule)
    local rule = rule or defaultRule
    local matcher = function(c) return awful.rules.match(c, rule) end

    local clients = client.get()
    local findex = awful.util.table.hasitem(clients, client.focus) or 1
    local start = awful.util.cycle(#clients, findex + 1)

    for c in awful.client.iterate(matcher, start) do
        turnOn(c)
        return
    end

    awful.spawn(cmd)
end

function scratch.toggle(cmd, rule, alwaysClose)
    local rule = rule or defaultRule

    if client.focus and awful.rules.match(client.focus, rule) then
        turnOff(client.focus)
    else
        scratch.raise(cmd, rule)
    end
end

return scratch
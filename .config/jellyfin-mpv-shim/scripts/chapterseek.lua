function chapter_seek(direction)
    local chapters = mp.get_property_number("chapters")
    if chapters == nil then chapters = 0 end
    local chapter  = mp.get_property_number("chapter")
    if chapter == nil then chapter = 0 end
    if chapter+direction < 0 then
        mp.command("playlist_prev")
    elseif chapter+direction >= chapters then
        mp.command("playlist_next")
    else
        mp.commandv("add", "chapter", direction)
    end
end
mp.add_key_binding("n", "chapter_next", function() chapter_seek(1) end)
mp.add_key_binding("p", "chapter_prev", function() chapter_seek(-1) end)
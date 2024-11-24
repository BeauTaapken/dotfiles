function chapter_seek(direction)
	local chapters = mp.get_property_number("chapters", 0) -- Total chapters
	local chapter = mp.get_property_number("chapter", -1) -- Current chapter

	if chapters > 0 and chapter >= 0 then
		-- Navigate chapters if available
		local new_chapter = chapter + direction
		if new_chapter >= 0 and new_chapter < chapters then
			mp.set_property("chapter", new_chapter)
			return
		end
	end

	-- Fallback to playlist navigation if no chapters or out of bounds
	if direction > 0 then
		mp.command("playlist-next")
	else
		mp.command("playlist-prev")
	end
end

mp.add_key_binding(nil, "chapter_next", function()
	mp.msg.info("chapter_next triggered")
	chapter_seek(1)
end)
mp.add_key_binding(nil, "chapter_prev", function()
	chapter_seek(-1)
end)


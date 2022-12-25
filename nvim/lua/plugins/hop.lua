
local status, hop = pcall(require, "hop")
if not status then
	return
end

hop.setup {
	keys = 'etovxqpdygfblzhckisuran',
	quit_key = '<ESC>',
	--  Sometimes, you will trigger a Hop command that will only hint a single item. In such a case, the default behavior is to automatically jump to it. You can control that behavier with jump_on_sole_occurrence
	jump_on_sole_occurrence = false,

	-- When using commands such as HopChar* or HopPattern, the default is be case insensitive: searching for a will hint both a and A.
	case_insensitive = false,

	-- By default, Hop will inject its own highlighting. This is a default option that is sound for most people but can be annoying at some time (you want to write the highlights yourself, or you are using a theme plugin that resets them).
	create_hl_autocmd = false,

	-- Labels are displayed by printing the content of your keys. You can switch to upper case if you want with:
	uppercase_labels = true,
	-- This configuration option is probably not to be set in setup but by using the Lua API. By default, Hop actions will take place for the whole visible part of the buffer, unless modified by variations. current_line_only is a kind of variation that will scope Hop to the same line as the the one the cursor is on.
	--current_line_only = true,
	-- When Hop hints items in a buffer, it actually hints two things: the beginning and the end of the target. That is especially true for HopPattern and HopWord. Of course, some Hop commands will have both their beginning and end overlapping, like HopChar1, HopLine and HopLineStart, for instance.
	-- By default, Hop will jump to the beginning part of the jump target. You can switch to the end with:

	-- hint_position = require'hop.hint'.HintPosition.END,
	-- hint_position = require'hop.hint'.HintPosition.MIDDLE,

	-- A very powerful feature: by default, Hop will jump to the target position. However, you can offset that position with hint_offset. That is especially useful to reimplement motions such as t / T, which move the cursor right before the actual thing you asked for. In that case, you would use hint_offset = -1.
	-- hint_offset = 1,
}

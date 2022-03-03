-- Tabnine’s AI code completion IDE plugin completes code
-- based on millions of programs in all languages
-- and on your own context,
-- empowering developers to code better and faster.

local tabnine = require("cmp_tabnine.config")
tabnine:setup(
  {
    max_lines = 1000,
    max_num_results = 20,
    sort = true,
    run_on_every_keystroke = true,
    snippet_placeholder = ".."
  }
)

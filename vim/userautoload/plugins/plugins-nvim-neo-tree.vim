" vimscriptベースの設定でluaを取り込む方法がわからなかったため，luaをあえてvimscriptにしている
lua vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

lua vim.fn.sign_define("DiagnosticSignError",
  \ {text = "x ", texthl = "DiagnosticSignError"})
lua vim.fn.sign_define("DiagnosticSignWarn",
  \ {text = "w ", texthl = "DiagnosticSignWarn"})
lua vim.fn.sign_define("DiagnosticSignInfo",
  \ {text = "i ", texthl = "DiagnosticSignInfo"})
lua vim.fn.sign_define("DiagnosticSignHint",
  \ {text = "h", texthl = "DiagnosticSignHint"})

lua require("neo-tree").setup({
\  close_if_last_window = false,
\  popup_border_style = "rounded",
\  enable_git_status = true,
\  enable_diagnostics = true,
\  default_component_configs = {
\    container = {
\      enable_character_fade = true
\    },
\    indent = {
\      indent_size = 2,
\      padding = 1,
\      with_markers = true,
\      indent_marker = "│",
\      last_indent_marker = "└",
\      highlight = "NeoTreeIndentMarker",
\      with_expanders = nil,
\      expander_collapsed = "x",
\      expander_expanded = "-",
\      expander_highlight = "NeoTreeExpander",
\    },
\    icon = {
\      folder_closed = "✚",
\      folder_open = "-",
\      folder_empty = "∅",
\      default = "*",
\      highlight = "NeoTreeFileIcon"
\    },
\    modified = {
\      symbol = "[+]",
\      highlight = "NeoTreeModified",
\    },
\    name = {
\      trailing_slash = false,
\      use_git_status_colors = true,
\      highlight = "NeoTreeFileName",
\    },
\    git_status = {
\      symbols = {
\        added     = "✚",
\        modified  = "!",
\        deleted   = "✖",
\        renamed   = "❇",
\        untracked = "ut",
\        ignored   = "ig",
\        unstaged  = "us",
\        staged    = "st",
\        conflict  = "cf",
\      }
\    },
\  },
\  window = {
\    position = "left",
\    width = 40,
\    mapping_options = {
\      noremap = true,
\      nowait = true,
\    },
\    mappings = {
\      ["<space>"] = { 
\          "toggle_node", 
\          nowait = false,
\      },
\      ["<2-LeftMouse>"] = "open",
\      ["<cr>"] = "open",
\      ["S"] = "open_split",
\      ["s"] = "open_vsplit",
"\      -- ["S"] = "split_with_window_picker",
"\      -- ["s"] = "vsplit_with_window_picker",
\      ["t"] = "open_tabnew",
\      ["w"] = "open_with_window_picker",
\      ["C"] = "close_node",
\      ["a"] = { 
\        "add",
\        config = {
\          show_path = "none" 
\        }
\      },
\      ["A"] = "add_directory",
\      ["d"] = "delete",
\      ["r"] = "rename",
\      ["y"] = "copy_to_clipboard",
\      ["x"] = "cut_to_clipboard",
\      ["p"] = "paste_from_clipboard",
\      ["c"] = "copy",
\      ["m"] = "move",
\      ["q"] = "close_window",
\      ["R"] = "refresh",
\      ["?"] = "show_help",
\    }
\  },
\  nesting_rules = {},
\  filesystem = {
\    filtered_items = {
\      visible = false,
\      hide_dotfiles = true,
\      hide_gitignored = true,
\      hide_hidden = true,
\      hide_by_name = {
\        "node_modules"
\      },
\      hide_by_pattern = {
\        "*.meta"
\      },
\      never_show = {
\        ".DS_Store",
\        "thumbs.db"
\      },
\    },
\    follow_current_file = false,
\    group_empty_dirs = false,
\    hijack_netrw_behavior = "open_default",
\    use_libuv_file_watcher = false,
\    window = {
\      mappings = {
\        ["<bs>"] = "navigate_up",
\        ["."] = "set_root",
\        ["H"] = "toggle_hidden",
\        ["/"] = "fuzzy_finder",
\        ["f"] = "filter_on_submit",
\        ["<c-x>"] = "clear_filter",
\        ["[g"] = "prev_git_modified",
\        ["]g"] = "next_git_modified",
\      }
\    }
\  },
\  buffers = {
\    follow_current_file = true,
\    group_empty_dirs = true,
\    show_unloaded = true,
\    window = {
\      mappings = {
\        ["bd"] = "buffer_delete",
\        ["<bs>"] = "navigate_up",
\        ["."] = "set_root",
\      }
\    },
\  },
\  git_status = {
\    window = {
\      position = "float",
\      mappings = {
\        ["A"]  = "git_add_all",
\        ["gu"] = "git_unstage_file",
\        ["ga"] = "git_add_file",
\        ["gr"] = "git_revert_file",
\        ["gc"] = "git_commit",
\        ["gp"] = "git_push",
\        ["gg"] = "git_commit_and_push",
\      }
\    }
\  }
\})

lua vim.cmd([[nnoremap \ :Neotree reveal<CR>]])

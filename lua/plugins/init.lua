local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap =
    fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
end

return require("packer").startup(
  {
    function()
      -- Packer can manage itself
      use {"wbthomason/packer.nvim"}
      -- colorscheme
      use {"shaunsingh/nord.nvim"}
      -- use 'glepnir/zephyr-nvim'
      use {"folke/tokyonight.nvim"}
      use {"tanvirtin/monokai.nvim"}
      use {"EdenEast/nightfox.nvim"}

      use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
      -- statusline and bufferline
      use {
        "tamton-aquib/staline.nvim",
        requires = {"kyazdani42/nvim-web-devicons", opt = true}
      }
      -- use {"akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons"}

      use {
        "kyazdani42/nvim-tree.lua",
        requires = {"kyazdani42/nvim-web-devicons", opt = true},
        -- after = 'kyazdani42/nvim-web-devicons',
        config = function()
          require "nvim-tree".setup {}
        end
      }
      use {"windwp/nvim-ts-autotag", ft = {"html", "javascript", "javascriptreact"}}
      use {"p00f/nvim-ts-rainbow"}
      use {"windwp/nvim-autopairs"}
      use {
        "folke/which-key.nvim",
        config = function()
          require("which-key").setup {}
        end
      }
      use {
        "nvim-telescope/telescope.nvim",
        requires = {{"nvim-lua/plenary.nvim"}}
      }
      use {"hrsh7th/vim-vsnip"}
      use {
        "hrsh7th/cmp-vsnip",
        requires = {
          {"rafamadriz/friendly-snippets"}, -- Base Snippets
          {"edheltzel/vscode-jekyll-snippets", ft = {"markdown", "html"}} -- Jekyll Snippets
        }
      }
      -- language server protocol
      use {"neovim/nvim-lspconfig"}
      use {
        "hrsh7th/nvim-cmp",
        requires = {
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-vsnip",
          "hrsh7th/cmp-path",
          "hrsh7th/cmp-buffer"
        }
      }

      use {"onsails/lspkind-nvim", requires = "hrsh7th/nvim-cmp"}
      -- fold for lsp
      use {"pierreglaser/folding-nvim"}

      use {
        "fatih/vim-go",
        run = ":GoUpdateBinaries"
      }
      use {"tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp"}

      -- comment
      use {
        "numToStr/Comment.nvim",
        config = function()
          require("Comment").setup()
        end
      }
      -- underline cursor word
      use {"xiyaowong/nvim-cursorword", event = "VimEnter"}
      -- markdown preview
      use {"ellisonleao/glow.nvim", ft = "markdown"}

      -- cheat.sh
      use {"dbeniamine/cheat.sh-vim"}
      use {
        "norcalli/nvim-colorizer.lua",
        config = function()
          require "colorizer".setup()
        end
      }
      use {"mhartington/formatter.nvim"}
      -- tippop ai completion startup
      use {"github/copilot.vim"}
      use {"glepnir/dashboard-nvim"}
      use {"lukas-reineke/indent-blankline.nvim"}
      use {"ggandor/lightspeed.nvim"}
      use {"xiyaowong/nvim-transparent"}

      -- toggle terminal
      use {"akinsho/toggleterm.nvim"}

      -- translate excellent recommended
      use {"voldikss/vim-translator"}

      -- debugger
      use {"mfussenegger/nvim-dap"}
      use {
        "theHamsta/nvim-dap-virtual-text",
        requires = {
          "mfusscient/nvim-dap"
        }
      }
      use {
        "rcarriga/nvim-dap-ui",
        requires = {
          "mfusscient/nvim-dap"
        }
      }

      -- change project dir
      use {"joacohoyos/directory.nvim"}
      -- show func signature when typing.
      use {"ray-x/lsp_signature.nvim"}

      -- tpope/vim-surround
      use {"tpope/vim-surround"}
      use {
        "lewis6991/gitsigns.nvim",
        requires = {
          "nvim-lua/plenary.nvim"
        },
        config = function()
          require("gitsigns").setup()
        end
      }
      use {"rcarriga/nvim-notify"}
      use {"simrat39/rust-tools.nvim"}
      if packer_bootstrap then
        require("packer").sync()
      end
    end,
    config = {
      -- Using a float window
      display = {
        open_fn = function()
          return require("packer.util").float({border = "single"})
        end
      },
      -- Profiling
      -- Profiling usage
      -- This will rebuild your packer_compiled.vim with profiling code included. In order to visualise
      -- the output of the profile restart your neovim and run PackerProfile. This will open a window with the output of your profiling.
      profile = {
        enable = true,
        threshold = 1
        -- the amount in ms that a plugins load time must be over for it to be included in the profile
      }
    }
  }
)

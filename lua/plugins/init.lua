return require("packer").startup(
  function()
    -- Packer can manage itself
    use "wbthomason/packer.nvim"
    -- colorscheme
    use "shaunsingh/nord.nvim"
    -- use 'glepnir/zephyr-nvim'
    use "folke/tokyonight.nvim"
    use "tanvirtin/monokai.nvim"
    use "EdenEast/nightfox.nvim"

    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
    use {
      "hoob3rt/lualine.nvim",
      requires = {"kyazdani42/nvim-web-devicons", opt = true}
    }
    use {"akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons"}
    use {
      "kyazdani42/nvim-tree.lua",
      requires = {"kyazdani42/nvim-web-devicons", opt = true},
      -- after = 'kyazdani42/nvim-web-devicons',
      config = function()
        require "nvim-tree".setup {}
      end
    }
    use "windwp/nvim-ts-autotag"
    use "p00f/nvim-ts-rainbow"
    use "windwp/nvim-autopairs"
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
    -- language server protocol
    use {"neovim/nvim-lspconfig"}
    use {"hrsh7th/cmp-nvim-lsp"}
    use {"hrsh7th/cmp-buffer"}
    use {"hrsh7th/nvim-cmp"}
    use {"hrsh7th/cmp-vsnip"}
    use {"hrsh7th/vim-vsnip"}
    use {"onsails/lspkind-nvim"}
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
    use "xiyaowong/nvim-cursorword"
    -- markdown preview
    use {"ellisonleao/glow.nvim"}
    use {
      "henriquehbr/nvim-startup.lua",
      config = function()
        require "nvim-startup".setup()
      end
    }
    -- git

    -- cheat.sh
    use {"dbeniamine/cheat.sh-vim"}
    use {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require "colorizer".setup()
      end
    }
    use "mhartington/formatter.nvim"
    -- tippop ai completion startup
    use "github/copilot.vim"
    use "glepnir/dashboard-nvim"
    use "lukas-reineke/indent-blankline.nvim"
    use "ggandor/lightspeed.nvim"
    use "xiyaowong/nvim-transparent"

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
    use "joacohoyos/directory.nvim"
    -- show func signature when typing.
    use {
      "ray-x/lsp_signature.nvim"
    }
  end
)

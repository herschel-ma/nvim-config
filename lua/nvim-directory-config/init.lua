-- https://github.com/joacohoyos/directory.nvim
-- usage:
--    :Telescope directory directory
require("directory").setup(
  {
    directories = {
      "~/go/src/large-file-upload/beego-file-uploader",
      "~/go/src/large-file-upload/vue-uploader-master",
      "~/pythonProjects/BlogApp",
      "~/pythonProjects/BlogApp/frontend"
    }
  }
)

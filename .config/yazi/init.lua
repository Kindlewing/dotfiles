require("simple-mtpfs"):setup({
  mount_point = os.getenv("HOME") .. "/Android"),
  mount_opts = { "debug", "max_read=1000" }
})

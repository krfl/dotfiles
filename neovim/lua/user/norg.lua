local status_ok, norg = pcall(require, "neorg")
if not status_ok then
  return
end

norg.setup {
    load = {
        ["core.defaults"] = {}
    }
}
